import "package:flutter/material.dart";
import "package:numly/models/math/rational_number.dart";
import "package:numly/models/test/number_generator.dart";
import "package:numly/models/test/operation.dart";
import "package:numly/models/test/question.dart";
import "package:numly/static/math/numbers.dart";

abstract class QuestionGenerator {
  Question generate();
}

class MinMaxQuestionGenerator implements QuestionGenerator {
  final NumberGenerator numberGenerator;
  final NumberGenerator numberGenerator2;
  final Operation operation;
  final SolutionType solutionType;

  /// Minimum solution value (inclusive)
  final RationalNumber? minSolution;

  /// Maximum solution value (exclusive)
  final RationalNumber? maxSolution;

  MinMaxQuestionGenerator({
    required this.numberGenerator,
    NumberGenerator? numberGenerator2,
    required this.operation,
    required this.solutionType,
    this.minSolution,
    this.maxSolution,
  }) : numberGenerator2 = numberGenerator2 ?? numberGenerator;

  @override
  Question generate() {
    final minSolution = this.minSolution, maxSolution = this.maxSolution;

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

      if (iterations >= 30) {
        debugPrint(
          "Warning - Takes too long to generate min/max question $iterations iterations!",
        );
      }
    } while (!((minSolution == null || question.solution >= minSolution) &&
        (maxSolution == null || question.solution < maxSolution)));

    return question;
  }
}

class PositiveQuestionGenerator extends MinMaxQuestionGenerator {
  PositiveQuestionGenerator({
    required super.numberGenerator,
    super.numberGenerator2,
    required super.operation,
    required super.solutionType,
  }) : super(minSolution: r0);
}
