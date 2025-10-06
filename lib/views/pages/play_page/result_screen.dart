import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/i18n/utils/unlocalized_string.dart";
import "package:numly/models/data/score.dart";
import "package:numly/models/game/game.dart";
import "package:numly/state/persistence/providers.dart";

class ResultScreen extends HookConsumerWidget {
  final Game game;
  final Duration testDuration;
  final Duration targetDuration;
  final int mistakesCount;
  final int doneQuestionsCount;
  final int failedQuestionsCount;

  const ResultScreen({
    super.key,
    required this.game,
    required this.testDuration,
    required this.targetDuration,
    required this.mistakesCount,
    required this.doneQuestionsCount,
    required this.failedQuestionsCount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invalidTest = failedQuestionsCount > 0;

    final scoreRegistration = useMemoized(() {
      if (invalidTest) {
        return null;
      }

      return ref
          .read(dbProvider)
          .queries
          .registerScore(
            Score(
              gameId: game.id,
              length: doneQuestionsCount,
              duration: testDuration,
            ),
            targetDuration,
          );
    });
    final highScore = useFuture(scoreRegistration).data;

    return Column(
      children: [
        Text("duration: $testDuration".unlocalized),
        Text("target duration: $targetDuration".unlocalized),
        Text("level success: ${testDuration < targetDuration}".unlocalized),
        if (highScore != null)
          Text("high score: ${highScore.duration}".unlocalized),
        Text(
          "mistakes: $mistakesCount (/$doneQuestionsCount questions)"
              .unlocalized,
        ),
        Text(
          "accuracy: ${((doneQuestionsCount - mistakesCount) / doneQuestionsCount * 100).toStringAsFixed(1)}%"
              .unlocalized,
        ),
        Text("failed: $failedQuestionsCount".unlocalized),
        Text("test invalid: $invalidTest".unlocalized),
      ],
    );
  }
}
