import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/data/score.dart";
import "package:numly/state/persistence/database.dart";
import "package:numly/state/persistence/hive/hive_database.dart";

final Database database = HiveDatabase();

final highScoreProvider = StreamProvider.family<Score?, String>(
  (ref, gameId) {
    return database.watchHighScore(gameId: gameId);
  },
);
