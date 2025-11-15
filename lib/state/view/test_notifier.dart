import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/game/game.dart";
import "package:numly/models/game/learn/learn.dart";
import "package:numly/models/test/test.dart";
import "package:numly/models/view/test_state.dart";
import "package:numly/state/persistence/kvs/providers.dart";

class TestStateNotifier extends AsyncNotifier<TestState> {
  final Game game;

  TestStateNotifier(this.game);

  late Test _test;
  late Test _nextTest; // used for endless tests

  @override
  TestState build() {
    final maxMistakeStreakAsync = ref.watch(kvsMaxMistakeStreakProvider);
    final endlessModeAsync = ref.watch(kvsEndlessModeProvider);
    final trainingLengthAsync = ref.watch(kvsTrainingLengthProvider);

    final testLength = learnGames.containsKey(game.id)
        ? learnTestLength
        : trainingLengthAsync.requireValue;

    _test = Test(parts: game.parts, length: testLength);
    _nextTest = Test(parts: game.parts, length: testLength);

    return TestState(
      startTime: DateTime.now(),
      endTime: null,
      targetDuration: _test.targetDuration,
      length: testLength,
      isEndless: endlessModeAsync.requireValue,
      doneQuestionsCount: 0,
      mistakesCount: 0,
      mistakeStreak: 0,
      maxMistakeStreak: maxMistakeStreakAsync.requireValue,
      failedQuestionsCount: 0,
      lastSubmittedAnswer: null,
      currentQuestion: _test.getQuestion(0),
      nextQuestion: testLength >= 2 ? _test.getQuestion(1) : null,
    );
  }

  void restart() {
    ref.invalidateSelf();
  }

  void submitAnswer(String answer) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncData(_withSubmitted(currentState, answer));
  }

  TestState _withSubmitted(TestState state, String answer) {
    if (state.reachedMaxMistakeStreak) {
      // question was not answered (submit to go to next after failed question)
      return _nextQuestion(
        state.copyWith(
          failedQuestionsCount: state.failedQuestionsCount + 1,
        ),
      );
    }

    if (answer.isEmpty) {
      return state;
    }

    var nextState = state.copyWith(lastSubmittedAnswer: answer);

    if (!nextState.currentQuestion.verify(answer).correct) {
      return nextState.copyWith(
        mistakesCount: nextState.mistakesCount + 1,
        mistakeStreak: nextState.mistakeStreak + 1,
      );
    }

    return _nextQuestion(nextState);
  }

  TestState _nextQuestion(TestState state) {
    final nextState = state.copyWith(
      doneQuestionsCount: state.doneQuestionsCount + 1,
      mistakeStreak: 0,
    );

    if (((nextState.doneQuestionsCount - 1) % nextState.length) + 1 >=
        nextState.length) {
      if (!nextState.isEndless) {
        // test finished
        return nextState.copyWith(endTime: DateTime.now());
      }

      _test = _nextTest;
      _nextTest = Test(
        parts: game.parts,
        length: _test.length,
      );
    }

    final currentQuestionIndex = nextState.doneQuestionsCount % _test.length;

    return nextState.copyWith(
      currentQuestion: _test.getQuestion(currentQuestionIndex),
      nextQuestion: currentQuestionIndex + 1 < _test.length
          ? _test.getQuestion(currentQuestionIndex + 1)
          : (nextState.isEndless ? _nextTest.getQuestion(0) : null),
    );
  }
}

final testStateNotifierProvider =
    AsyncNotifierProvider.family<TestStateNotifier, TestState, Game>(
      TestStateNotifier.new,
      isAutoDispose: true,
    );
