import "package:numly/models/game/game.dart";

final List<Category> trainCategories = [
  // integerAddition,
];

// Using `.toList()` to preserve ordering
final trainCategoryIds =
    trainCategories.map((category) => category.id).toList();

final trainGames =
    trainCategories.expand((category) => category.games).toList();
final trainGameIds = trainGames.map((game) => game.id).toList();
