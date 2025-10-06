import "package:drift/drift.dart";

class CompletedLevelsTable extends Table {
  @override
  String get tableName => "completed_levels";

  @override
  Set<Column> get primaryKey => {gameId};

  TextColumn get gameId => text()();
}
