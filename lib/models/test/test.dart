import "package:collection/collection.dart";
import "package:numly/models/math/random.dart";
import "package:numly/models/test/question.dart";
import "package:numly/models/test/question_generator.dart";
import "package:numly/utils/language.dart";

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
  }) : assert(_questions.isNotEmpty, "test must have at least one question");

  factory Test({
    required List<TestPart> parts,
    required int length,
  }) {
    assert(parts.isNotEmpty, "test must have at least one part");
    assert(length > 0, "test must have a > 0 length");

    final List<Question> questions = [];
    var targetDuration = Duration.zero;

    final proportions = parts.map((p) => p.proportion).sum;

    // generate questions given the proportions
    for (final part in parts) {
      final amount = (part.proportion * length / proportions).floor();
      for (var i = 0; i < amount; i++) {
        questions.add(part.questionGenerator.generate());
        targetDuration += part.targetTimePerQuestion ?? Duration.zero;
      }
    }

    // generate missing questions from random parts
    while (questions.length < length) {
      // TODO weighted random choice based on proportion
      final part = parts.pick(random);
      questions.add(part.questionGenerator.generate());
      targetDuration += part.targetTimePerQuestion ?? Duration.zero;
    }

    questions.shuffle(random);

    return Test._(
      questions,
      targetDuration: targetDuration,
    );
  }

  int get length => _questions.length;

  Question getQuestion(int i) => _questions[i];
}
