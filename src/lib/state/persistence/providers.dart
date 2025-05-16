import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/data/score.dart";
import "package:numly/state/persistence/core/database.dart";

final dbProvider = Provider<Database>(
  (ref) => Database.native(),
);

// TODO transform to get the current questionCount
final highScoreProvider = StreamProvider.family<Score?, String>(
  (ref, gameId) {
    final db = ref.watch(dbProvider);

    return (db.select(db.highScoreTable)..where((t) => t.gameId.equals(gameId)))
        .watchSingleOrNull();
  },
);
