import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../constants/database_constants.dart';

/// Base SQLite de la app; se abre una sola vez y se reutiliza.
class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static const String _sqlMovimientos =
      '''
    CREATE TABLE ${DatabaseConstants.tablaMovimientos} (
      ${DatabaseConstants.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DatabaseConstants.colTitulo} TEXT NOT NULL,
      ${DatabaseConstants.colCategoria} TEXT NOT NULL,
      ${DatabaseConstants.colMontoCentavos} INTEGER NOT NULL,
      ${DatabaseConstants.colFecha} TEXT NOT NULL,
      ${DatabaseConstants.colAnulado} INTEGER NOT NULL,
      ${DatabaseConstants.colEsEntrada} INTEGER NOT NULL
    )''';

  static const String _sqlEdiciones =
      '''
    CREATE TABLE ${DatabaseConstants.tablaEdiciones} (
      ${DatabaseConstants.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DatabaseConstants.colMovimientoId} INTEGER NOT NULL
        REFERENCES ${DatabaseConstants.tablaMovimientos}(${DatabaseConstants.colId})
        ON DELETE CASCADE,
      ${DatabaseConstants.colCampo} TEXT NOT NULL,
      ${DatabaseConstants.colValorAnterior} TEXT NOT NULL,
      ${DatabaseConstants.colValorNuevo} TEXT NOT NULL,
      ${DatabaseConstants.colFecha} TEXT NOT NULL
    )''';

  static const String _sqlPeriodos =
      '''
    CREATE TABLE ${DatabaseConstants.tablaPeriodos} (
      ${DatabaseConstants.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DatabaseConstants.colInicio} TEXT NOT NULL,
      ${DatabaseConstants.colArrastradoCentavos} INTEGER NOT NULL,
      ${DatabaseConstants.colMontoMesCentavos} INTEGER NOT NULL,
      ${DatabaseConstants.colPisoCentavos} INTEGER NOT NULL
    )''';

  static const String _sqlClavesForaneas = 'PRAGMA foreign_keys = ON';

  Database? _database;

  Future<Database> get database async => _database ??= await _abrir();

  Future<Database> _abrir() async {
    final directorio = await getDatabasesPath();
    return openDatabase(
      p.join(directorio, DatabaseConstants.nombreArchivo),
      version: DatabaseConstants.version,
      onConfigure: (db) => db.execute(_sqlClavesForaneas),
      onCreate: _crearTablas,
    );
  }

  static Future<void> _crearTablas(Database db, int version) async {
    final batch = db.batch()
      ..execute(_sqlMovimientos)
      ..execute(_sqlEdiciones)
      ..execute(_sqlPeriodos);
    await batch.commit(noResult: true);
  }
}
