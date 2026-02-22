import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/measurement.dart';

class DatabaseService {
  static const String _databaseName = 'plc_inspection.db';
  static const String _measurementsTable = 'measurements';
  static const String _preferencesTable = 'preferences';
  static const int _version = 1;

  static final DatabaseService _instance = DatabaseService._internal();
  Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    try {
      final databasesPath = await getDatabasesPath();
      final path = join(databasesPath, _databaseName);
      return await openDatabase(
        path,
        version: _version,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );
    } catch (e) {
      print('Database initialization error: $e');
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute(
        'CREATE TABLE $_measurementsTable (id INTEGER PRIMARY KEY AUTOINCREMENT,measure_no INTEGER NOT NULL UNIQUE,photo_filename TEXT,photo_path TEXT,description TEXT,improvement_measure TEXT,priority TEXT NOT NULL DEFAULT "MEDIUM",created_at TEXT NOT NULL)',
      );
      await db.execute(
        'CREATE TABLE $_preferencesTable (key TEXT PRIMARY KEY,value TEXT NOT NULL)',
      );
      await db.insert(_preferencesTable, {'key': 'next_measure_no', 'value': '1'});
    } catch (e) {
      print('Database creation error: $e');
      rethrow;
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  Future<int> getNextMeasureNo() async {
    try {
      final db = await database;
      final result = await db.query(
        _preferencesTable, where: 'key = ?', whereArgs: ['next_measure_no'],
      );
      if (result.isNotEmpty) {
        return int.parse(result.first['value'] as String);
      }
      return 1;
    } catch (e) {
      print('Error getting next measure no: $e');
      return 1;
    }
  }

  Future<void> updateNextMeasureNo(int nextNo) async {
    try {
      final db = await database;
      await db.update(
        _preferencesTable,
        {'value': nextNo.toString()}, where: 'key = ?', whereArgs: ['next_measure_no'],
      );
    } catch (e) {
      print('Error updating next measure no: $e');
    }
  }

  Future<int> insertMeasurement(Measurement measurement) async {
    try {
      final db = await database;
      final id = await db.insert(
        _measurementsTable, measurement.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id;
    } catch (e) {
      print('Error inserting measurement: $e');
      rethrow;
    }
  }

  Future<List<Measurement>> getAllMeasurements() async {
    try {
      final db = await database;
      final result = await db.query(
        _measurementsTable, orderBy: 'measure_no ASC',
      );
      return result.map((map) => Measurement.fromMap(map)).toList();
    } catch (e) {
      print('Error getting measurements: $e');
      return [];
    }
  }

  Future<int> getMeasurementCount() async {
    try {
      final db = await database;
      final result = await db.rawQuery('SELECT COUNT(*) as count FROM $_measurementsTable');
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      print('Error getting measurement count: $e');
      return 0;
    }
  }

  Future<void> clearAllMeasurements() async {
    try {
      final db = await database;
      await db.delete(_measurementsTable);
      await updateNextMeasureNo(1);
    } catch (e) {
      print('Error clearing measurements: $e');
      rethrow;
    }
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}