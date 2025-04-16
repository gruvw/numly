import "package:numly/models/test.dart";

class Category {
  final int id;
  final String title;
  final String subtitle;
  final List<Game> games;

  Category({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.games,
  });
}

class Game {
  final int id;
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
