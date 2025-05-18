import "package:drift/drift.dart";

class PreferenceTable extends Table {
  @override
  String get tableName => "preference";

  @override
  Set<Column> get primaryKey => {key};

  TextColumn get key => text()();
  TextColumn get value => text()();
}
