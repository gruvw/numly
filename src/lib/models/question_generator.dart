import "package:flutter/material.dart";
import "package:numly/models/number_generator.dart";
import "package:numly/models/operation.dart";
import "package:numly/models/question.dart";
import "package:numly/models/rational_number.dart";
import "package:numly/static/numbers.dart";

abstract class QuestionGenerator {
  Question generate();
}

class MinMaxQuestionGenerator implements QuestionGenerator {
  final NumberGenerator numberGenerator;
  final NumberGenerator numberGenerator2;
  final Operation operation;
  final SolutionType solutionType;

  /// Minimum answer value (inclusive)
  final RationalNumber? min;

  /// Maximum answer value (inclusive)
  final RationalNumber? max;

  MinMaxQuestionGenerator({
    required this.numberGenerator,
    NumberGenerator? numberGenerator2,
    required this.operation,
    required this.solutionType,
    this.min,
    this.max,
  }) : numberGenerator2 = numberGenerator2 ?? numberGenerator;

  @override
  Question generate() {
    final min = this.min, max = this.max;

    RationalNumber number1, number2;
    Question question;

    int iterations = 0;
    do {
      iterations++;

      number1 = numberGenerator.generate();
      number2 = numberGenerator2.generate();
      question = Question(
        number1: number1,
        number2: number2,
        operation: operation,
        solutionType: solutionType,
      );
    } while ((min == null || question.solution >= min) &&
        (max == null || question.solution <= max));

    if (iterations >= 30) {
      debugPrint(
        "Warning - Took too long to generate min/max question $iterations iterations!",
      );
    }

    return question;
  }
}

class PositiveQuestionGenerator extends MinMaxQuestionGenerator {
  PositiveQuestionGenerator({
    required super.numberGenerator,
    super.numberGenerator2,
    required super.operation,
    required super.solutionType,
  }) : super(min: r0);
}

class SimpleQuestionGenerator extends MinMaxQuestionGenerator {
  SimpleQuestionGenerator({
    required super.numberGenerator,
    super.numberGenerator2,
    required super.operation,
    required super.solutionType,
  });
}
