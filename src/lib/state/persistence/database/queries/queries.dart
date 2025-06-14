import "package:drift/drift.dart";
import "package:numly/models/data/score.dart";
import "package:numly/state/persistence/database/core/database.dart";
import "package:numly/state/persistence/database/tables/favorite_table.drift.dart";
import "package:numly/state/persistence/database/tables/high_score_table.drift.dart";

class Queries {
  final Database _db;

  Queries(this._db);

  Future<void> toggleFavorite(String gameId) async {
    return _db.transaction(() async {
      final query = _db.select(_db.favoriteTable)
        ..where((t) => t.gameId.equals(gameId));

      final existingFavorite = await query.getSingleOrNull();

      if (existingFavorite != null) {
        await (_db.delete(
          _db.favoriteTable,
        )..where((t) => t.gameId.equals(gameId))).go();
      } else {
        await _db
            .into(_db.favoriteTable)
            .insert(FavoriteTableCompanion.insert(gameId: gameId));
      }
    });
  }

  /// Register the new test score and return the highest score for the same game and test length.
  Future<Score> registerScore(Score score) async {
    return _db.transaction(() async {
      final query = _db.select(_db.highScoreTable)
        ..where(
          (t) => t.gameId.equals(score.gameId) & t.length.equals(score.length),
        );

      final existingHighScore = await query.getSingleOrNull();

      if (existingHighScore == null ||
          score.duration < existingHighScore.duration) {
        return await (_db
            .into(
              _db.highScoreTable,
            )
            .insertReturning(
              HighScoreTableCompanion.insert(
                gameId: score.gameId,
                length: score.length,
                durationMs: score.duration.inMilliseconds,
              ),
              mode: InsertMode.insertOrReplace,
            ));
      }

      return existingHighScore;
    });
  }
}
