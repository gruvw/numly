import "package:numly/state/persistence/database/core/database.dart";
import "package:numly/state/persistence/database/tables/favorite_table.drift.dart";

class Queries {
  final Database _db;

  Queries(this._db);

  Future<void> toggleFavorite(String gameId) async {
    return _db.transaction(() async {
      final query = _db.select(_db.favoriteTable)
        ..where((tbl) => tbl.gameId.equals(gameId));

      final existingFavorite = await query.getSingleOrNull();

      if (existingFavorite != null) {
        await (_db.delete(_db.favoriteTable)
              ..where((tbl) => tbl.gameId.equals(gameId)))
            .go();
      } else {
        await _db
            .into(_db.favoriteTable)
            .insert(FavoriteTableCompanion.insert(gameId: gameId));
      }
    });
  }
}
