import "package:drift/drift.dart";

class FavoriteTable extends Table {
  @override
  String get tableName => "favorite";

  @override
  Set<Column> get primaryKey => {gameId};

  TextColumn get gameId => text()();
}
