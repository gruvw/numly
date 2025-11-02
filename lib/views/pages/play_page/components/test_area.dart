import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:gap/gap.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/game/game.dart";
import "package:numly/models/view/test_state.dart";
import "package:numly/state/view/test_notifier.dart";
import "package:numly/static/styles.dart";
import "package:numly/views/pages/play_page/components/input/number_input.dart";
import "package:numly/views/pages/play_page/components/input/virtual_keyboard.dart";
import "package:numly/views/pages/play_page/components/question_display.dart";
import "package:numly/views/pages/play_page/result_screen.dart";

class TestArea extends HookConsumerWidget {
  final Game game;
  final TestState testState;

  const TestArea({
    super.key,
    required this.game,
    required this.testState,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testStateProvider = testStateNotifierProvider(game);
    final testStateNotifier = ref.watch(testStateProvider.notifier);

    final nextQuestion = testState.nextQuestion;
    final testEndTime = testState.endTime;

    final numberController = useTextEditingController();

    if (testEndTime != null) {
      return ResultScreen(
        game: game,
        testDuration: testEndTime.difference(testState.startTime),
        targetDuration: testState.targetDuration,
        mistakesCount: testState.mistakesCount,
        doneQuestionsCount: testState.doneQuestionsCount,
        failedQuestionsCount: testState.failedQuestionsCount,
      );
    }

    final header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${testState.doneQuestionsCount}/${testState.isEndless ? "∞" : testState.length}",
        ),
        nextQuestion == null
            ? Text("---")
            : QuestionDisplay(question: nextQuestion),
      ],
    );

    return Column(
      children: [
        header,
        QuestionDisplay(question: testState.currentQuestion),
        NumberInput(
          numberController: numberController,
          currentQuestion: testState.currentQuestion,
          mistakeStreak: testState.mistakeStreak,
          lastSubmittedAnswer: testState.lastSubmittedAnswer,
          displayCorrectAnswer: testState.reachedMaxMistakeStreak,
        ),
        Gap(Styles.standardSpacing * 4),
        VirtualKeyboard(
          numberController: numberController,
          submitOnly: testState.reachedMaxMistakeStreak,
          onSubmit: testStateNotifier.submitAnswer,
        ),
        Gap(Styles.standardSpacing * 4),
      ],
    );
  }
}
