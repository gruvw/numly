// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:numly/models/data/score.dart' as i1;
import 'package:numly/state/persistence/tables/high_score_table.drift.dart'
    as i2;
import 'package:numly/state/persistence/tables/high_score_table.dart' as i3;

class $HighScoreTableTable extends i3.HighScoreTable
    with i0.TableInfo<$HighScoreTableTable, i1.Score> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HighScoreTableTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _gameIdMeta =
      const i0.VerificationMeta('gameId');
  @override
  late final i0.GeneratedColumn<String> gameId = i0.GeneratedColumn<String>(
      'game_id', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _questionCountMeta =
      const i0.VerificationMeta('questionCount');
  @override
  late final i0.GeneratedColumn<int> questionCount = i0.GeneratedColumn<int>(
      'question_count', aliasedName, false,
      type: i0.DriftSqlType.int, requiredDuringInsert: true);
  static const i0.VerificationMeta _durationMsMeta =
      const i0.VerificationMeta('durationMs');
  @override
  late final i0.GeneratedColumn<int> durationMs = i0.GeneratedColumn<int>(
      'duration_ms', aliasedName, false,
      type: i0.DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<i0.GeneratedColumn> get $columns => [gameId, questionCount, durationMs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'high_score';
  @override
  i0.VerificationContext validateIntegrity(i0.Insertable<i1.Score> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('game_id')) {
      context.handle(_gameIdMeta,
          gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta));
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    if (data.containsKey('question_count')) {
      context.handle(
          _questionCountMeta,
          questionCount.isAcceptableOrUnknown(
              data['question_count']!, _questionCountMeta));
    } else if (isInserting) {
      context.missing(_questionCountMeta);
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
          _durationMsMeta,
          durationMs.isAcceptableOrUnknown(
              data['duration_ms']!, _durationMsMeta));
    } else if (isInserting) {
      context.missing(_durationMsMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {gameId, questionCount};
  @override
  i1.Score map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Score.fromData(
      gameId: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}game_id'])!,
      questionCount: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}question_count'])!,
      durationMs: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}duration_ms'])!,
    );
  }

  @override
  $HighScoreTableTable createAlias(String alias) {
    return $HighScoreTableTable(attachedDatabase, alias);
  }
}

class HighScoreTableCompanion extends i0.UpdateCompanion<i1.Score> {
  final i0.Value<String> gameId;
  final i0.Value<int> questionCount;
  final i0.Value<int> durationMs;
  final i0.Value<int> rowid;
  const HighScoreTableCompanion({
    this.gameId = const i0.Value.absent(),
    this.questionCount = const i0.Value.absent(),
    this.durationMs = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  HighScoreTableCompanion.insert({
    required String gameId,
    required int questionCount,
    required int durationMs,
    this.rowid = const i0.Value.absent(),
  })  : gameId = i0.Value(gameId),
        questionCount = i0.Value(questionCount),
        durationMs = i0.Value(durationMs);
  static i0.Insertable<i1.Score> custom({
    i0.Expression<String>? gameId,
    i0.Expression<int>? questionCount,
    i0.Expression<int>? durationMs,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (gameId != null) 'game_id': gameId,
      if (questionCount != null) 'question_count': questionCount,
      if (durationMs != null) 'duration_ms': durationMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i2.HighScoreTableCompanion copyWith(
      {i0.Value<String>? gameId,
      i0.Value<int>? questionCount,
      i0.Value<int>? durationMs,
      i0.Value<int>? rowid}) {
    return i2.HighScoreTableCompanion(
      gameId: gameId ?? this.gameId,
      questionCount: questionCount ?? this.questionCount,
      durationMs: durationMs ?? this.durationMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (gameId.present) {
      map['game_id'] = i0.Variable<String>(gameId.value);
    }
    if (questionCount.present) {
      map['question_count'] = i0.Variable<int>(questionCount.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = i0.Variable<int>(durationMs.value);
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HighScoreTableCompanion(')
          ..write('gameId: $gameId, ')
          ..write('questionCount: $questionCount, ')
          ..write('durationMs: $durationMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}
