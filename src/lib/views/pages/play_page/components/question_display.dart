import "package:flutter/material.dart";
import "package:numly/models/test/operation.dart";
import "package:numly/models/test/question.dart";

class QuestionDisplay extends StatelessWidget {
  final Question question;

  const QuestionDisplay({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return switch (question.operation) {
      Operation.addition => Text("${question.number1} + ${question.number2}"),
      Operation.subtraction =>
        Text("${question.number1} - ${question.number2}"),
      Operation.multiplication =>
        Text("${question.number1} × ${question.number2}"),
      Operation.division => Text("${question.number1} / ${question.number2}"),
      _ => throw UnsupportedError("Operation not yet supported"),
    };
  }
}
