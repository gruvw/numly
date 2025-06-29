import "package:numly/models/math/rational_number.dart";
import "package:numly/models/test/number_generator.dart";
import "package:numly/models/test/operation.dart";
import "package:numly/models/test/question.dart";
import "package:numly/static/math/numbers.dart";

abstract class QuestionGenerator {
  Question generate();
}

class SimpleQuestionGenerator implements QuestionGenerator {
  final NumberGenerator numberGenerator;
  final NumberGenerator numberGenerator2;
  final Operation operation;
  final SolutionType solutionType;

  SimpleQuestionGenerator({
    required this.numberGenerator,
    NumberGenerator? numberGenerator2,
    required this.operation,
    required this.solutionType,
  }) : numberGenerator2 = numberGenerator2 ?? numberGenerator;

  @override
  Question generate() {
    final number1 = numberGenerator.generate();
    final number2 = numberGenerator2.generate();

    return Question(
      number1: number1,
      number2: number2,
      operation: operation,
      solutionType: solutionType,
    );
  }
}

class DecimalAdditionQuestionGenerator implements QuestionGenerator {
  /// Should not generate numbers larger than [maxSolution]
  final MinMaxDecimalNumberGenerator numberGenerator;

  /// Maximum solution value (exclusive)
  final RationalNumber? maxSolution;

  DecimalAdditionQuestionGenerator({
    required this.numberGenerator,
    this.maxSolution,
  });

  @override
  Question generate() {
    final maxSolution = this.maxSolution;

    final number1 = numberGenerator.generate();
    var number2 = numberGenerator.generate();

    if (maxSolution != null) {
      final answer = MinMaxDecimalNumberGenerator(
        minimum: number1,
        maximum: maxSolution,
        decimals: numberGenerator.decimals,
      ).generate();
      number2 = answer.sub(number1);
    }

    return Question(
      number1: number1,
      number2: number2,
      operation: Operation.addition,
      solutionType: SolutionType.decimal,
    );
  }
}

class DecimalSubtractionQuestionGenerator implements QuestionGenerator {
  /// Should not generate numbers smaller than [minSolution]
  final MinMaxDecimalNumberGenerator numberGenerator;

  /// Minimum solution value (exclusive)
  final RationalNumber? minSolution;

  DecimalSubtractionQuestionGenerator({
    required this.numberGenerator,
    this.minSolution,
  });

  @override
  Question generate() {
    final minSolution = this.minSolution;

    final number1 = numberGenerator.generate();
    var number2 = numberGenerator.generate();

    if (minSolution != null) {
      final answer = MinMaxDecimalNumberGenerator(
        minimum: minSolution,
        maximum: number1,
        decimals: numberGenerator.decimals,
      ).generate();
      number2 = number1.sub(answer);
    }

    return Question(
      number1: number1,
      number2: number2,
      operation: Operation.subtraction,
      solutionType: SolutionType.decimal,
    );
  }
}

class DecimalPositiveSubtractionQuestionGenerator
    extends DecimalSubtractionQuestionGenerator {
  DecimalPositiveSubtractionQuestionGenerator({
    required super.numberGenerator,
  }) : super(minSolution: r0);
}

class DecimalDivisionQuestionGenerator implements QuestionGenerator {
  final MinMaxDecimalNumberGenerator multiplesGenerator;

  DecimalDivisionQuestionGenerator({
    required this.multiplesGenerator,
  });

  @override
  Question generate() {
    final answer = multiplesGenerator.generate();
    final denominator = multiplesGenerator.generate();

    return Question(
      number1: denominator.mul(answer),
      number2: denominator,
      operation: Operation.division,
      solutionType: SolutionType.decimal,
    );
  }
}
