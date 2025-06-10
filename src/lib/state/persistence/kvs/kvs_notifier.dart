import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/state/persistence/database/tables/kvs_table.drift.dart";
import "package:numly/state/persistence/kvs/providers.dart";
import "package:numly/state/persistence/providers.dart";
import "package:numly/utils/language.dart";

class KvsNotifier<T> extends AsyncNotifier<T> {
  static KvsNotifier<bool> boolean({
    required String configKey,
    required bool defaultValue,
  }) {
    return KvsNotifier(
      key: configKey,
      defaultValue: defaultValue,
      parse: (s) => bool.parse(s),
      serialize: (v) => v.toString(),
    );
  }

  static KvsNotifier<int> integer({
    required String configKey,
    required int defaultValue,
  }) {
    return KvsNotifier(
      key: configKey,
      defaultValue: defaultValue,
      parse: (s) => int.parse(s),
      serialize: (v) => v.toString(),
    );
  }

  static KvsNotifier<String> string({
    required String configKey,
    required String defaultValue,
  }) {
    return KvsNotifier(
      key: configKey,
      defaultValue: defaultValue,
      serialize: (s) => s,
      parse: (s) => s,
    );
  }

  final String key;
  final T defaultValue;

  /// The serialization function used to convert the value to text for storage.
  /// Note - This function should be pure and idempotent.
  final String Function(T value) serialize;

  /// The parsing function used to convert the stored text to the (typed) value.
  /// Note - This function should be pure and idempotent.
  final T Function(String source) parse;

  late final _db = ref.read(dbProvider);

  KvsNotifier({
    required this.key,
    required this.defaultValue,
    required this.serialize,
    required this.parse,
  });

  @override
  Future<T> build() async {
    final row = await ref.watch(kvsSourceProvider(key).future);
    final value = row?.nmap((source) => parse(source));

    return value ?? defaultValue;
  }

  /// Assigns a new value to the key in the store, with (opt-out) immediate effect on the notifier's state.
  /// Note - if the state is immediately updated, it could de-synchronize the store and the notifier's state.
  Future<void> set(
    T value, {
    bool immediate = true,
  }) async {
    if (immediate) {
      state = AsyncValue.data(value);
    }

    final data = serialize(value);
    await _db
        .into(_db.kvsTable)
        .insertOnConflictUpdate(
          KvsTableCompanion.insert(
            key: key,
            value: data,
          ),
        );
  }

  Future<void> reset() async {
    final delete = (_db.delete(_db.kvsTable))..where((t) => t.key.equals(key));

    await delete.go();
  }

  KvsNotifier<E> map<E>(
    E Function(T) map,
    T Function(E) reverse,
  ) {
    return KvsNotifier<E>(
      key: key,
      defaultValue: map(defaultValue),
      serialize: (value) => serialize(reverse(value)),
      parse: (source) => map(parse(source)),
    );
  }
}
