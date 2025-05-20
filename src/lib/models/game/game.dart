import "package:numly/models/test/test.dart";

typedef CategoryId = String;
typedef GameId = String;

class Category {
  final CategoryId id;
  final String title;
  final String subtitle;
  final List<Game> games;

  static String subId(CategoryId categoryId, String gameIdSuffix) {
    return "$categoryId/$gameIdSuffix";
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
