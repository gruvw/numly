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

  final String Function(T value) serialize;
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

  Future<void> set(T value) async {
    final data = serialize(value);

    await _db.into(_db.kvsTable).insertOnConflictUpdate(
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
