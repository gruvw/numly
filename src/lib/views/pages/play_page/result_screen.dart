import "package:flutter/material.dart";

class ResultScreen extends StatelessWidget {
  final Duration testDuration;
  final int mistakesCount;
  final int doneQuestionsCount;
  final int failedQuestionsCount;

  const ResultScreen({
    super.key,
    required this.testDuration,
    required this.mistakesCount,
    required this.doneQuestionsCount,
    required this.failedQuestionsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("duration: $testDuration"),
        Text("mistakes: $mistakesCount/$doneQuestionsCount"),
        Text("failed: $failedQuestionsCount"),
        Text("test invalid: ${failedQuestionsCount >= 0}"),
      ],
    );
  }
}
