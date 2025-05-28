import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/game/game.dart";
import "package:numly/state/persistence/kvs/kvs_notifier.dart";
import "package:numly/state/persistence/providers.dart";

final kvsSourceProvider = StreamProvider.family<String?, String>(
  (ref, key) {
    final db = ref.read(dbProvider);

    final query = (db.select(db.kvsTable)..where((t) => t.key.equals(key)))
        .map((row) => row.value);

    return query.watchSingleOrNull();
  },
);

final kvsTrainingLengthProvider =
    AsyncNotifierProvider<KvsNotifier<int>, int>(() {
  return KvsNotifier.integer(
    configKey: "training_length",
    defaultValue: 20,
  );
});

final kvsLastGameIdProvider =
    AsyncNotifierProvider<KvsNotifier<String?>, GameId?>(() {
  return KvsNotifier.string(
    configKey: "last_game_id",
    defaultValue: "",
  ).map(
    (value) => value.isEmpty ? null : value,
    (data) => data ?? "",
  );
});
