import "package:drift/drift.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/data/score.dart";
import "package:numly/state/persistence/database/core/database.dart";

final dbProvider = Provider<Database>(
  (ref) => Database.native(),
);

// TODO transform to get the current questionCount
final highScoreProvider = StreamProvider.family<Score?, GameSetting>(
  (ref, gameSetting) {
    final db = ref.watch(dbProvider);

    return (db.select(db.highScoreTable)
          ..where(
            (t) =>
                t.gameId.equals(gameSetting.gameId) &
                t.length.equals(gameSetting.length),
          ))
        .watchSingleOrNull();
  },
);
