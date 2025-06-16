import "package:numly/i18n/utils/hardcoded_string.dart";
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
  title: (l) => "Integer Addition".hardcoded,
  subtitle: (l) => "Adding integer numbers".hardcoded,
  games: [
    Game.part(
      id: Category.subId(_id, "small-result"),
      title: (l) => "Small result".hardcoded,
      subtitle: (l) => "Addition with result <10".hardcoded,
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
      title: (l) => "Small numbers".hardcoded,
      subtitle: (l) => "Adding numbers <10".hardcoded,
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
