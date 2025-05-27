import "package:numly/models/game/learn/learn.dart";
import "package:numly/models/game/train/train.dart";
import "package:numly/views/navigation/routes.dart";
import "package:test/test.dart";

void main() {
  test("categories have unique (and not conflicting) ids", () {
    final categoryIds = learnCategoriesList
        .followedBy(trainCategoriesList)
        .map((category) => category.id);

    expect(categoryIds.length, categoryIds.toSet().length);

    expect(
      categoryIds.any((id) => id == CategoryRoute.favoritesCategory),
      false,
      reason: "'${CategoryRoute.favoritesCategory}' is a reserved category id",
    );
  });

  test("game levels and trainings have unique ids", () {
    final gameIds = learnCategoriesList
        .followedBy(trainCategoriesList)
        .expand((category) => category.games.map((game) => game.id));

    expect(gameIds.length, gameIds.toSet().length);
  });

  test("all game level parts have time constrains", () {
    final levelsExpectedTimesPerQuestion = learnCategoriesList.expand(
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
