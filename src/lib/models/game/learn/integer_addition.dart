import "package:numly/models/game/game.dart";
import "package:numly/models/test/operation.dart";
import "package:numly/models/test/question.dart";
import "package:numly/models/test/question_generator.dart";
import "package:numly/models/test/test.dart";
import "package:numly/static/math/number_generators.dart";
import "package:numly/static/math/numbers.dart";
import "package:numly/static/math/times.dart";

final _id = "integer-addition";

final integerAddition = Category(
  id: _id,
  title: "Integer Addition",
  subtitle: "Adding integer numbers",
  games: [
    Game.part(
      id: Category.subId(_id, "small-result"),
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
      id: Category.subId(_id, "small-numbers"),
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
