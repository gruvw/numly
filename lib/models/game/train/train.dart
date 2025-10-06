import "dart:collection";

import "package:flutter/material.dart";
import "package:numly/models/game/game.dart";

@visibleForTesting
final List<Category> trainCategoriesList = [
  // integerAddition,
];

final trainCategories = Map<CategoryId, Category>.unmodifiable(
  LinkedHashMap.fromIterable(
    trainCategoriesList,
    key: (category) => category.id,
  ),
);

final trainGames = Map<GameId, Game>.unmodifiable(
  LinkedHashMap.fromIterable(
    trainCategoriesList.expand((category) => category.games),
    key: (game) => game.id,
  ),
);
