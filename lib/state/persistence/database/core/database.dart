import "package:drift/drift.dart";
import "package:drift_flutter/drift_flutter.dart";
import "package:numly/state/persistence/database/core/database.drift.dart";
import "package:numly/state/persistence/database/queries/queries.dart";
import "package:numly/state/persistence/database/tables/completed_levels_table.dart";
import "package:numly/state/persistence/database/tables/favorite_table.dart";
import "package:numly/state/persistence/database/tables/high_score_table.dart";
import "package:numly/state/persistence/database/tables/kvs_table.dart";
import "package:numly/static/build_options.dart";
import "package:numly/static/values.dart";

@DriftDatabase(
  tables: [
    HighScoreTable,
    KvsTable,
    FavoriteTable,
    CompletedLevelsTable,
  ],
)
class Database extends $Database {
  static QueryExecutor _nativeConnection() {
    return driftDatabase(
      name: Values.databaseName,
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse("sqlite3.wasm"),
        driftWorker: Uri.parse("drift_worker.js"),
      ),
    );
  }

  late final queries = Queries(this);

  Database(super.executor);

  Database.native() : this(_nativeConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        final migrator = createMigrator();

        if (BuildOptions.debugEraseDB) {
          // delete and create fresh DB
          for (final table in allTables) {
            await migrator.deleteTable(table.actualTableName);
            await migrator.createTable(table);
          }
        }

        // enable SQLite foreign keys
        await customStatement("PRAGMA foreign_keys = ON");
      },
    );
  }
}
