// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:numly/state/persistence/database/tables/preference_table.drift.dart'
    as i1;
import 'package:numly/state/persistence/database/tables/preference_table.dart'
    as i2;

class $PreferenceTableTable extends i2.PreferenceTable
    with i0.TableInfo<$PreferenceTableTable, i1.PreferenceTableData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PreferenceTableTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _keyMeta = const i0.VerificationMeta('key');
  @override
  late final i0.GeneratedColumn<String> key = i0.GeneratedColumn<String>(
      'key', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _valueMeta =
      const i0.VerificationMeta('value');
  @override
  late final i0.GeneratedColumn<String> value = i0.GeneratedColumn<String>(
      'value', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<i0.GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'preference';
  @override
  i0.VerificationContext validateIntegrity(
      i0.Insertable<i1.PreferenceTableData> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {key};
  @override
  i1.PreferenceTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.PreferenceTableData(
      key: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $PreferenceTableTable createAlias(String alias) {
    return $PreferenceTableTable(attachedDatabase, alias);
  }
}

class PreferenceTableData extends i0.DataClass
    implements i0.Insertable<i1.PreferenceTableData> {
  final String key;
  final String value;
  const PreferenceTableData({required this.key, required this.value});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['key'] = i0.Variable<String>(key);
    map['value'] = i0.Variable<String>(value);
    return map;
  }

  factory PreferenceTableData.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return PreferenceTableData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  i1.PreferenceTableData copyWith({String? key, String? value}) =>
      i1.PreferenceTableData(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  PreferenceTableData copyWithCompanion(i1.PreferenceTableCompanion data) {
    return PreferenceTableData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PreferenceTableData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.PreferenceTableData &&
          other.key == this.key &&
          other.value == this.value);
}

class PreferenceTableCompanion
    extends i0.UpdateCompanion<i1.PreferenceTableData> {
  final i0.Value<String> key;
  final i0.Value<String> value;
  final i0.Value<int> rowid;
  const PreferenceTableCompanion({
    this.key = const i0.Value.absent(),
    this.value = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  PreferenceTableCompanion.insert({
    required String key,
    required String value,
    this.rowid = const i0.Value.absent(),
  })  : key = i0.Value(key),
        value = i0.Value(value);
  static i0.Insertable<i1.PreferenceTableData> custom({
    i0.Expression<String>? key,
    i0.Expression<String>? value,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.PreferenceTableCompanion copyWith(
      {i0.Value<String>? key, i0.Value<String>? value, i0.Value<int>? rowid}) {
    return i1.PreferenceTableCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (key.present) {
      map['key'] = i0.Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = i0.Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreferenceTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}
