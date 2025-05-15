import "package:collection/collection.dart";
import "package:numly/models/math/random.dart";
import "package:numly/models/test/question.dart";
import "package:numly/models/test/question_generator.dart";

class TestPart {
  final QuestionGenerator questionGenerator;
  final Duration? targetTimePerQuestion; // non-null only for levels
  final int proportion;

  TestPart({
    required this.questionGenerator,
    this.targetTimePerQuestion,
    this.proportion = 1,
  }) : assert(proportion >= 1, "proportion must be >= 1");
}

class Test {
  final List<Question> _questions;
  final Duration targetDuration; // relevant only for levels

  Test._(
    this._questions, {
    required this.targetDuration,
  }) : assert(_questions.isNotEmpty, "test has no questions");

  factory Test({
    required List<TestPart> parts,
    required int length,
  }) {
    final List<Question> questions = [];
    var targetDuration = Duration.zero;

    final proportions = parts.map((p) => p.proportion).sum;

    // generate questions given the proportions
    for (final part in parts) {
      final amount = (part.proportion * length / proportions).floor();
      for (int i = 0; i < amount; i++) {
        questions.add(part.questionGenerator.generate());
        targetDuration += part.targetTimePerQuestion ?? Duration.zero;
      }
    }

    // generate missing questions from random parts
    for (int i = questions.length; i < length; i++) {
      final part = parts[random.nextInt(parts.length)];
      questions.add(part.questionGenerator.generate());
      targetDuration += part.targetTimePerQuestion ?? Duration.zero;
    }

    questions.shuffle(random);

    return Test._(
      questions,
      targetDuration: targetDuration,
    );
  }

  Question getQuestion(int i) => _questions[i];
}
