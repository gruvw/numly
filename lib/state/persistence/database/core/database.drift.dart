// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:numly/state/persistence/database/tables/high_score_table.drift.dart'
    as i1;
import 'package:numly/state/persistence/database/tables/kvs_table.drift.dart'
    as i2;
import 'package:numly/state/persistence/database/tables/favorite_table.drift.dart'
    as i3;
import 'package:numly/state/persistence/database/tables/completed_levels_table.drift.dart'
    as i4;

abstract class $Database extends i0.GeneratedDatabase {
  $Database(i0.QueryExecutor e) : super(e);
  late final i1.$HighScoreTableTable highScoreTable = i1.$HighScoreTableTable(
    this,
  );
  late final i2.$KvsTableTable kvsTable = i2.$KvsTableTable(this);
  late final i3.$FavoriteTableTable favoriteTable = i3.$FavoriteTableTable(
    this,
  );
  late final i4.$CompletedLevelsTableTable completedLevelsTable = i4
      .$CompletedLevelsTableTable(this);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [
    highScoreTable,
    kvsTable,
    favoriteTable,
    completedLevelsTable,
  ];
  @override
  i0.DriftDatabaseOptions get options =>
      const i0.DriftDatabaseOptions(storeDateTimeAsText: true);
}
