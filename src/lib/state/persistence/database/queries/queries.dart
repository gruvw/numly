import "package:numly/state/persistence/database/core/database.dart";
import "package:numly/state/persistence/database/tables/favorite_table.drift.dart";

class Queries {
  final Database db;

  Queries(this.db);

  Future<void> toggleFavorite(String gameId) async {
    return db.transaction(() async {
      final query = db.select(db.favoriteTable)
        ..where((tbl) => tbl.gameId.equals(gameId));

      final existingFavorite = await query.getSingleOrNull();

      if (existingFavorite != null) {
        await (db.delete(db.favoriteTable)
              ..where((tbl) => tbl.gameId.equals(gameId)))
            .go();
      } else {
        await db
            .into(db.favoriteTable)
            .insert(FavoriteTableCompanion.insert(gameId: gameId));
      }
    });
  }
}
