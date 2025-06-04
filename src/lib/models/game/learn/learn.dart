import "dart:collection";

import "package:flutter/material.dart";
import "package:numly/models/game/game.dart";
import "package:numly/models/game/learn/integer_addition.dart";

const learnTestLength = 20;

@visibleForTesting
final learnCategoriesList = [
  integerAddition,
];

final learnCategories = Map<CategoryId, Category>.unmodifiable(
  LinkedHashMap.fromIterable(
    learnCategoriesList,
    key: (category) => category.id,
  ),
);

final learnGames = Map<GameId, Game>.unmodifiable(
  LinkedHashMap.fromIterable(
    learnCategoriesList.expand((category) => category.games),
    key: (game) => game.id,
  ),
);
