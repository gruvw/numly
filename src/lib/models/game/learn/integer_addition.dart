import "package:numly/models/game/game.dart";
import "package:numly/models/test/operation.dart";
import "package:numly/models/test/question.dart";
import "package:numly/models/test/question_generator.dart";
import "package:numly/models/test/test.dart";
import "package:numly/static/math/number_generators.dart";
import "package:numly/static/math/numbers.dart";
import "package:numly/static/math/times.dart";

const _id = "integer-addition";

final integerAddition = Category(
  id: _id,
  title: (l) => l.integerAdditionCategoryTitle,
  subtitle: (l) => l.integerAdditionCategorySubtitle,
  games: [
    Game.part(
      id: Category.subId(_id, "small-result"),
      title: (l) => l.smallResultGameTitle,
      subtitle: (l) => l.smallResultGameSubtitle,
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
      title: (l) => l.smallNumbersGameTitle,
      subtitle: (l) => l.smallNumbersGameSubtitle,
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
