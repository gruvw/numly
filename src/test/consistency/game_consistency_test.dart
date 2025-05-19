import "package:numly/models/game/learn/learn.dart";
import "package:numly/models/game/train/train.dart";
import "package:test/test.dart";

void main() {
  test("game levels and trainings have unique ids", () {
    final gameIds = learnCategories.followedBy(trainCategories).expand(
          (category) => category.games.map((game) => game.id),
        );

    expect(gameIds.length, gameIds.toSet().length);
  });

  test("all game level parts have time constrains", () {
    final levelsExpectedTimesPerQuestion = learnCategories.expand(
      (category) => category.games.expand(
        (game) => game.parts.map((part) => part.targetTimePerQuestion),
      ),
    );

    expect(
      levelsExpectedTimesPerQuestion.every((duration) => duration != null),
      true,
    );
  });
}
