import "package:numly/logic/input_processing.dart";
import "package:numly/models/math/rational_number.dart";
import "package:numly/models/test/operation.dart";

enum SolutionType { decimal, fractional, percent }

class Question {
  final RationalNumber number1;
  final RationalNumber number2;
  final Operation operation;
  final SolutionType solutionType;

  Question({
    required this.number1,
    required this.number2,
    required this.operation,
    required this.solutionType,
  });

  late final solution = operation.compute(number1, number2);
  late final solutionText = () {
    switch (solutionType) {
      case SolutionType.decimal:
        return solution.intDecFracString;
      case SolutionType.fractional:
        return solution.intFracString;
      case SolutionType.percent:
        return solution.percentString;
    }
  }();

  Result _correctResult() => Result.correct(solutionText);

  Result _wrongResult([String? message]) {
    return Result.wrong(
      solutionText,
      message: message,
    );
  }

  Result verify(String answerText) {
    answerText = numberSubmitter(answerText);
    final answer = RationalNumber.tryParse(answerText);

    if (answer == null) {
      return _wrongResult("Your answer is not a valid number.");
    }

    if (answerText == solutionText) {
      return _correctResult();
    }

    if (solution.equals(answer)) {
      return _wrongResult("Mathematically correct but wrong format.");
    }

    return _wrongResult();
  }
}

class Result {
  final bool correct;
  final String solution;
  final String? message;

  Result({
    required this.correct,
    required this.solution,
    required this.message,
  });

  Result.correct(this.solution) : correct = true, message = null;

  Result.wrong(
    this.solution, {
    this.message,
  }) : correct = false;
}
