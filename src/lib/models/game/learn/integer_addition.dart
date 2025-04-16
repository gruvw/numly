import "package:numly/models/game/game.dart";
import "package:numly/models/operation.dart";
import "package:numly/models/question.dart";
import "package:numly/models/question_generator.dart";
import "package:numly/models/test.dart";
import "package:numly/static/math/number_generators.dart";
import "package:numly/static/math/numbers.dart";
import "package:numly/static/math/times.dart";

final integerAddition = Category(
  id: 0,
  title: "Integer Addition",
  subtitle: "Adding integer numbers",
  games: [
    Game.part(
      id: 0,
      title: "Small result",
      subtitle: "Addition with result <10",
      part: TestPart(
        questionGenerator: MinMaxQuestionGenerator(
          numberGenerator: int0to10,
          maxSolution: r10,
          operation: Operation.addition,
          solutionType: SolutionType.decimal,
        ),
        targetTimePerQuestion: t2,
      ),
    ),
    Game.part(
      id: 1,
      title: "Small numbers",
      subtitle: "Adding numbers <10",
      part: TestPart(
        questionGenerator: MinMaxQuestionGenerator(
          numberGenerator: int0to10,
          operation: Operation.addition,
          solutionType: SolutionType.decimal,
        ),
        targetTimePerQuestion: t2,
      ),
    ),
  ],
);
