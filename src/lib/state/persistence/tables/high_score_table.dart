import "package:drift/drift.dart";
import "package:numly/models/data/score.dart";

@UseRowClass(Score, constructor: "fromData")
class HighScoreTable extends Table {
  @override
  String get tableName => "high_score";

  @override
  Set<Column> get primaryKey => {gameId, questionCount};

  TextColumn get gameId => text()();
  IntColumn get questionCount => integer()();

  IntColumn get durationMs => integer()();
}
