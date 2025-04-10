import "package:flutter/material.dart";
import "package:numly/models/number.dart";
import "package:numly/models/operation.dart";

class Question {
  final Number number1;
  final Number number2;
  final Operation operation;

  late final Number answer = operation.compute(number1, number2);

  Question({
    required this.number1,
    required this.number2,
    required this.operation,
  });
}

abstract class QuestionGenerator {
  Question generate();
}

class SimpleQuestionGenerator extends MinMaxQuestionGenerator {
  SimpleQuestionGenerator({
    required super.numberGenerator1,
    required super.numberGenerator2,
    required super.operation,
  });
}

class MinMaxQuestionGenerator implements QuestionGenerator {
  final NumberGenerator numberGenerator1;
  final NumberGenerator numberGenerator2;
  final Operation operation;

  /// Minimum answer value (inclusive)
  final double? min;

  /// Maximum answer value (inclusive)
  final double? max;

  MinMaxQuestionGenerator({
    required this.numberGenerator1,
    required this.numberGenerator2,
    required this.operation,
    this.min,
    this.max,
  });

  @override
  Question generate() {
    final double? min = this.min, max = this.max;

    Number number1, number2;
    Question question;

    int iterations = 0;
    do {
      iterations++;

      number1 = numberGenerator1.generate();
      number2 = numberGenerator2.generate();
      question = Question(
        number1: number1,
        number2: number2,
        operation: operation,
      );
    } while ((min == null || question.answer.value >= min) &&
        (max == null || question.answer.value <= max));

    if (iterations >= 20) {
      debugPrint(
        "Warning - Took too long to generate min/max question $iterations iterations!",
      );
    }

    return question;
  }
}
