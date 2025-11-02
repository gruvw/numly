// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:numly/state/persistence/database/tables/favorite_table.drift.dart'
    as i1;
import 'package:numly/state/persistence/database/tables/favorite_table.dart'
    as i2;

class $FavoriteTableTable extends i2.FavoriteTable
    with i0.TableInfo<$FavoriteTableTable, i1.FavoriteTableData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteTableTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _gameIdMeta = const i0.VerificationMeta(
    'gameId',
  );
  @override
  late final i0.GeneratedColumn<String> gameId = i0.GeneratedColumn<String>(
    'game_id',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<i0.GeneratedColumn> get $columns => [gameId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.FavoriteTableData> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('game_id')) {
      context.handle(
        _gameIdMeta,
        gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {gameId};
  @override
  i1.FavoriteTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.FavoriteTableData(
      gameId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}game_id'],
      )!,
    );
  }

  @override
  $FavoriteTableTable createAlias(String alias) {
    return $FavoriteTableTable(attachedDatabase, alias);
  }
}

class FavoriteTableData extends i0.DataClass
    implements i0.Insertable<i1.FavoriteTableData> {
  final String gameId;
  const FavoriteTableData({required this.gameId});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['game_id'] = i0.Variable<String>(gameId);
    return map;
  }

  factory FavoriteTableData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return FavoriteTableData(
      gameId: serializer.fromJson<String>(json['gameId']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'gameId': serializer.toJson<String>(gameId)};
  }

  i1.FavoriteTableData copyWith({String? gameId}) =>
      i1.FavoriteTableData(gameId: gameId ?? this.gameId);
  FavoriteTableData copyWithCompanion(i1.FavoriteTableCompanion data) {
    return FavoriteTableData(
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteTableData(')
          ..write('gameId: $gameId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => gameId.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.FavoriteTableData && other.gameId == this.gameId);
}

class FavoriteTableCompanion extends i0.UpdateCompanion<i1.FavoriteTableData> {
  final i0.Value<String> gameId;
  final i0.Value<int> rowid;
  const FavoriteTableCompanion({
    this.gameId = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  FavoriteTableCompanion.insert({
    required String gameId,
    this.rowid = const i0.Value.absent(),
  }) : gameId = i0.Value(gameId);
  static i0.Insertable<i1.FavoriteTableData> custom({
    i0.Expression<String>? gameId,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (gameId != null) 'game_id': gameId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.FavoriteTableCompanion copyWith({
    i0.Value<String>? gameId,
    i0.Value<int>? rowid,
  }) {
    return i1.FavoriteTableCompanion(
      gameId: gameId ?? this.gameId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (gameId.present) {
      map['game_id'] = i0.Variable<String>(gameId.value);
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteTableCompanion(')
          ..write('gameId: $gameId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}
