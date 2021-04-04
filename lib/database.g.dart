// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorIEDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$IEDatabaseBuilder databaseBuilder(String name) =>
      _$IEDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$IEDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$IEDatabaseBuilder(null);
}

class _$IEDatabaseBuilder {
  _$IEDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$IEDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$IEDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<IEDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$IEDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$IEDatabase extends IEDatabase {
  _$IEDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BiographyDao? _biographyDaoInstance;

  HistoryDao? _historyDaoInstance;

  HistoryDetailDao? _historyDetailDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Biography` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `mukjizat` TEXT NOT NULL, `story` TEXT NOT NULL, `category_id` INTEGER NOT NULL, `lifetime` TEXT NOT NULL, `sort` INTEGER NOT NULL, `bookmark` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `History` (`id` INTEGER NOT NULL, `name` TEXT, `summary` TEXT, `name_en` TEXT, `summary_en` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `HistoryDetail` (`id` INTEGER NOT NULL, `history_id` INTEGER NOT NULL, `period` TEXT NOT NULL, `description` TEXT NOT NULL, `images` TEXT NOT NULL, `description_en` TEXT NOT NULL, `subtitle` TEXT NOT NULL, `subtitle_en` TEXT NOT NULL, `is_bookmark` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BiographyDao get biographyDao {
    return _biographyDaoInstance ??= _$BiographyDao(database, changeListener);
  }

  @override
  HistoryDao get historyDao {
    return _historyDaoInstance ??= _$HistoryDao(database, changeListener);
  }

  @override
  HistoryDetailDao get historyDetailDao {
    return _historyDetailDaoInstance ??=
        _$HistoryDetailDao(database, changeListener);
  }
}

class _$BiographyDao extends BiographyDao {
  _$BiographyDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<Biography>> findAllBiography() async {
    return _queryAdapter.queryList('SELECT * FROM Biography',
        mapper: (Map<String, Object?> row) => Biography(
            row['id'] as int,
            row['name'] as String,
            row['mukjizat'] as String,
            row['story'] as String,
            row['category_id'] as int,
            row['lifetime'] as String,
            row['sort'] as int,
            row['bookmark'] as int));
  }
}

class _$HistoryDao extends HistoryDao {
  _$HistoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<History>> findAllHistory() async {
    return _queryAdapter.queryList('SELECT * FROM History',
        mapper: (Map<String, Object?> row) => History(
            row['id'] as int,
            row['name'] as String?,
            row['summary'] as String?,
            row['name_en'] as String?,
            row['summary_en'] as String?));
  }

  @override
  Future<History?> findHistoryById(int id) async {
    return _queryAdapter.query('SELECT * FROM History WHERE id=?',
        arguments: [id],
        mapper: (Map<String, Object?> row) => History(
            row['id'] as int,
            row['name'] as String?,
            row['summary'] as String?,
            row['name_en'] as String?,
            row['summary_en'] as String?));
  }

  @override
  Stream<List<History>> findAllHistoryAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM History',
        queryableName: 'History',
        isView: false,
        mapper: (Map<String, Object?> row) => History(
            row['id'] as int,
            row['name'] as String?,
            row['summary'] as String?,
            row['name_en'] as String?,
            row['summary_en'] as String?));
  }
}

class _$HistoryDetailDao extends HistoryDetailDao {
  _$HistoryDetailDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<HistoryDetail>> findAllHistoryDetails() async {
    return _queryAdapter.queryList('SELECT * FROM HistoryDetail',
        mapper: (Map<String, Object?> row) => HistoryDetail(
            row['id'] as int,
            row['history_id'] as int,
            row['period'] as String,
            row['description'] as String,
            row['images'] as String,
            row['description_en'] as String,
            row['subtitle'] as String,
            row['subtitle_en'] as String,
            row['is_bookmark'] as int));
  }

  @override
  Stream<List<HistoryDetail>> findAllHistoryDetailsAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM HistoryDetail',
        queryableName: 'HistoryDetail',
        isView: false,
        mapper: (Map<String, Object?> row) => HistoryDetail(
            row['id'] as int,
            row['history_id'] as int,
            row['period'] as String,
            row['description'] as String,
            row['images'] as String,
            row['description_en'] as String,
            row['subtitle'] as String,
            row['subtitle_en'] as String,
            row['is_bookmark'] as int));
  }

  @override
  Future<List<HistoryDetail>> findAllHistoryDetailsById(int historyId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM HistoryDetail WHERE history_id = ?',
        arguments: [historyId],
        mapper: (Map<String, Object?> row) => HistoryDetail(
            row['id'] as int,
            row['history_id'] as int,
            row['period'] as String,
            row['description'] as String,
            row['images'] as String,
            row['description_en'] as String,
            row['subtitle'] as String,
            row['subtitle_en'] as String,
            row['is_bookmark'] as int));
  }

  @override
  Future<List<HistoryDetail>> findAllPeriods() async {
    return _queryAdapter.queryList(
        'SELECT * FROM HistoryDetail GROUP BY history_id',
        mapper: (Map<String, Object?> row) => HistoryDetail(
            row['id'] as int,
            row['history_id'] as int,
            row['period'] as String,
            row['description'] as String,
            row['images'] as String,
            row['description_en'] as String,
            row['subtitle'] as String,
            row['subtitle_en'] as String,
            row['is_bookmark'] as int));
  }
}
