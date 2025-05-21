import "dart:collection";

import "package:numly/models/game/game.dart";

final List<Category> trainCategories = [
  // integerAddition,
];

final trainCategoryIds =
    LinkedHashSet.of(trainCategories.map((category) => category.id));

final trainGames =
    LinkedHashSet.of(trainCategories.expand((category) => category.games));
final trainGameIds = LinkedHashSet.of(trainGames.map((game) => game.id));
