import "dart:collection";

import "package:numly/models/game/learn/learn.dart";
import "package:numly/models/game/train/train.dart";
import "package:numly/models/test/test.dart";

typedef CategoryId = String;
typedef GameId = String;

final _categoryGameSeparator = "/";

class Category {
  final CategoryId id;
  final String title;
  final String subtitle;
  final List<Game> games;

  static String subId(CategoryId categoryId, String gameIdSuffix) {
    return "$categoryId$_categoryGameSeparator$gameIdSuffix";
  }

  Category({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.games,
  });
}

class Game {
  final GameId id;
  final String title;
  final String subtitle;
  final List<TestPart> parts;

  String? get gameIdSuffix {
    final split = id.split(_categoryGameSeparator);
    return split.elementAtOrNull(1);
  }

  Game.parts({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.parts,
  });

  Game.part({
    required this.id,
    required this.title,
    required this.subtitle,
    required TestPart part,
  }) : parts = [part];
}

final allGames = Map<GameId, Game>.unmodifiable(
  LinkedHashMap.fromEntries(
    learnGames.entries.followedBy(trainGames.entries),
  ),
);
