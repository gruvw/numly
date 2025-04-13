import "package:flutter/material.dart";
import "package:numly/models/number_generator.dart";
import "package:numly/models/operation.dart";
import "package:numly/models/question.dart";
import "package:numly/models/rational_number.dart";

abstract class QuestionGenerator {
  Question generate();
}

class MinMaxQuestionGenerator implements QuestionGenerator {
  final NumberGenerator numberGenerator1;
  final NumberGenerator numberGenerator2;
  final Operation operation;

  /// Minimum answer value (inclusive)
  final RationalNumber? min;

  /// Maximum answer value (inclusive)
  final RationalNumber? max;

  MinMaxQuestionGenerator({
    required this.numberGenerator1,
    required this.numberGenerator2,
    required this.operation,
    this.min,
    this.max,
  });

  @override
  Question generate() {
    final min = this.min, max = this.max;

    RationalNumber number1, number2;
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
    } while ((min == null || question.answer >= min) &&
        (max == null || question.answer <= max));

    if (iterations >= 30) {
      debugPrint(
        "Warning - Took too long to generate min/max question $iterations iterations!",
      );
    }

    return question;
  }
}

class SimpleQuestionGenerator extends MinMaxQuestionGenerator {
  SimpleQuestionGenerator({
    required super.numberGenerator1,
    required super.numberGenerator2,
    required super.operation,
  });
}
