import "package:numly/models/test.dart";

class Category {
  final String id;
  final String title;
  final String subtitle;
  final List<Game> games;

  static String subId(String categoryId, String gameId) {
    return "$categoryId/$gameId";
  }

  Category({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.games,
  });
}

class Game {
  final String id;
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
