import "package:flutter/material.dart";

class ResultScreen extends StatelessWidget {
  final Duration testDuration;
  final int mistakesCount;
  final int answeredQuestionsCount;

  const ResultScreen({
    super.key,
    required this.testDuration,
    required this.mistakesCount,
    required this.answeredQuestionsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("duration: $testDuration"),
        Text(
          "mistakes: $mistakesCount/$answeredQuestionsCount",
        ),
      ],
    );
  }
}
