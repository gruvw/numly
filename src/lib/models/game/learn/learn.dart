import "package:numly/models/game/learn/integer_addition.dart";

const defaultLevelLength = 20;

final learnCategories = [
  integerAddition,
];

// Using `.toList()` to preserve ordering
final learnCategoryIds =
    learnCategories.map((category) => category.id).toList();

final learnGames =
    learnCategories.expand((category) => category.games).toList();
final learnGameIds = learnGames.map((game) => game.id).toList();
