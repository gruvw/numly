import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/data/max_mistake_streak.dart";
import "package:numly/models/data/training_length.dart";
import "package:numly/models/game/game.dart";
import "package:numly/state/persistence/kvs/kvs_notifier.dart";
import "package:numly/state/persistence/providers.dart";

final kvsSourceProvider = StreamProvider.family<String?, String>(
  (ref, key) {
    final db = ref.watch(dbProvider);

    final query = (db.select(
      db.kvsTable,
    )..where((t) => t.key.equals(key))).map((row) => row.value);

    return query.watchSingleOrNull().distinct();
  },
);

final kvsTrainingLengthProvider =
    NotifierProvider<KvsNotifier<int>, AsyncValue<int>>(
      () {
        return KvsNotifier.integer(
          configKey: "training_length",
          defaultValue: TrainingLength.normal.length,
        );
      },
    );

final kvsMaxMistakeStreakProvider =
    NotifierProvider<KvsNotifier<int>, AsyncValue<int>>(
      () {
        return KvsNotifier.integer(
          configKey: "max_mistake_streak",
          defaultValue: MaxMistakeStreak.retry.amount,
        );
      },
    );

final kvsLastGameIdProvider =
    NotifierProvider<KvsNotifier<String?>, AsyncValue<GameId?>>(() {
      return KvsNotifier.string(
        configKey: "last_game_id",
        defaultValue: "",
      ).map(
        (value) => value.isEmpty ? null : value,
        (data) => data ?? "",
      );
    });

final kvsEndlessModeProvider =
    NotifierProvider<KvsNotifier<bool>, AsyncValue<bool>>(
      () {
        return KvsNotifier.boolean(
          configKey: "endless_mode",
          defaultValue: false,
        );
      },
    );
