import "dart:collection";

import "package:numly/models/game/learn/integer_addition.dart";

const defaultLevelLength = 20;

final learnCategories = [
  integerAddition,
];

final learnCategoryIds =
    LinkedHashSet.of(learnCategories.map((category) => category.id));

final learnGames =
    LinkedHashSet.of(learnCategories.expand((category) => category.games));
final learnGameIds = LinkedHashSet.of(learnGames.map((game) => game.id));
