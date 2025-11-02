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

  Result verify(String answerText) {
    answerText = numberSubmitter(answerText);
    final answer = RationalNumber.tryParse(answerText);

    if (answer == null) {
      return Result.invalidNumber;
    }

    if (answerText == solutionText) {
      return Result.exact;
    }

    if (solution.equals(answer)) {
      return Result.wrongFormat;
    }

    return Result.wrong;
  }
}

enum Result {
  exact(true),
  wrong(false),
  invalidNumber(false),
  wrongFormat(false);

  final bool correct;

  const Result(this.correct);
}
