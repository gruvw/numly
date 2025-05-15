import "package:numly/models/data/score.dart";

abstract class Database {
  Future<void> init();

  Future<void> setHighScore({
    required String gameId,
    required Score highScore,
  });

  Stream<Score> watchHighScore({
    required String gameId,
  });
}
