import "package:numly/logic/input_processing.dart";
import "package:numly/models/operation.dart";
import "package:numly/models/rational_number.dart";

class Question {
  final RationalNumber number1;
  final RationalNumber number2;
  final Operation operation;

  late final RationalNumber answer = operation.compute(number1, number2);

  Question({
    required this.number1,
    required this.number2,
    required this.operation,
  });

  Result verify(String text) {
    text = numberSubmitter(text);
    // TODO verify user answer
  }
}

class Result {
  final bool correct;
  final String answer;
  final String? message;

  Result({
    required this.correct,
    required this.answer,
    required this.message,
  });
}
