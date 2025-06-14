import "package:flutter/material.dart";
import "package:numly/models/game/game.dart";

class ResultScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("duration: $testDuration"),
        Text("mistakes: $mistakesCount (/$doneQuestionsCount questions)"),
        Text(
          "accuracy: ${((doneQuestionsCount - mistakesCount) / doneQuestionsCount * 100).toStringAsFixed(1)}%",
        ),
        Text("failed: $failedQuestionsCount"),
        Text("test invalid: ${failedQuestionsCount >= 0}"),
      ],
    );
  }
}
