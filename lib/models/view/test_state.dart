import "package:freezed_annotation/freezed_annotation.dart";
import "package:numly/models/test/question.dart";

part "test_state.freezed.dart";

@freezed
sealed class TestState with _$TestState {
  const TestState._();

  const factory TestState({
    required DateTime startTime,
    required DateTime? endTime,
    required Duration targetDuration,
    required int length,
    required bool isEndless,
    required int doneQuestionsCount,
    required int mistakesCount,
    required int mistakeStreak,
    required int maxMistakeStreak,
    required int failedQuestionsCount,
    required String? lastSubmittedAnswer,
    required Question currentQuestion,
    required Question? nextQuestion,
  }) = _TestState;

  bool get reachedMaxMistakeStreak => mistakeStreak >= maxMistakeStreak;
}
