import "package:flutter/material.dart";

class ResultScreen extends StatelessWidget {
  final Duration testDuration;

  const ResultScreen({
    super.key,
    required this.testDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(testDuration.toString());
  }
}
