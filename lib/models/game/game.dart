import "dart:collection";

import "package:numly/i18n/utils/locale_string.dart";
import "package:numly/models/game/learn/learn.dart";
import "package:numly/models/game/train/train.dart";
import "package:numly/models/test/test.dart";
import "package:numly/views/navigation/routes.dart";

typedef CategoryId = String;
typedef GameId = String;

class Category {
  final CategoryId id;
  final LocaleString title;
  final LocaleString subtitle;
  final List<Game> games;

  static String subId(CategoryId categoryId, String gameIdSuffix) {
    return "$categoryId${AppRoute.separator}$gameIdSuffix";
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
  final LocaleString title;
  final LocaleString subtitle;
  final List<TestPart> parts;

  String? get gameIdSuffix {
    final split = id.split(AppRoute.separator);
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

  // equality only based on `id`
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Game && runtimeType == other.runtimeType && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

final allGames = Map<GameId, Game>.unmodifiable(
  LinkedHashMap.fromEntries(
    learnGames.entries.followedBy(trainGames.entries),
  ),
);
