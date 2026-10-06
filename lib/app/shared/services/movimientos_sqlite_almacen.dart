/**************************** PAQUETES EXTERNOS *****************************/
import 'package:sqflite/sqflite.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/database_constants.dart';
import 'package:gastos_app/app/core/database/app_database.dart';

/********************************** SHARED **********************************/
import '../models/edicion_movimiento_model.dart';
import '../models/movimiento_model.dart';
import '../models/periodo_mes_model.dart';
import '../utils/movimiento_mapper.dart';
import 'movimientos_almacen.dart';

class MovimientosSqliteAlmacen implements MovimientosAlmacen {
  final AppDatabase _baseDatos;

  MovimientosSqliteAlmacen(this._baseDatos);

  static const String _recientesPrimero =
      '${DatabaseConstants.colFecha} ${DatabaseConstants.descendente}, '
      '${DatabaseConstants.colId} ${DatabaseConstants.descendente}';

  Future<Database> get _db => _baseDatos.database;

  Future<Map<int, List<EdicionMovimiento>>> _edicionesPorMovimiento(
    Database db,
  ) async {
    final filas = await db.query(
      DatabaseConstants.tablaEdiciones,
      orderBy: _recientesPrimero,
    );
    final agrupadas = <int, List<EdicionMovimiento>>{};
    for (final fila in filas) {
      final movimientoId = fila[DatabaseConstants.colMovimientoId] as int;
      agrupadas
          .putIfAbsent(movimientoId, () => [])
          .add(MovimientoMapper.edicionDesdeFila(fila));
    }
    return agrupadas;
  }

  @override
  Future<List<Movimiento>> cargarMovimientos() async {
    final db = await _db;
    final filas = await db.query(
      DatabaseConstants.tablaMovimientos,
      orderBy: _recientesPrimero,
    );
    final ediciones = await _edicionesPorMovimiento(db);
    return [
      for (final fila in filas)
        MovimientoMapper.desdeFila(
          fila,
          ediciones[fila[DatabaseConstants.colId]] ?? const [],
        ),
    ];
  }

  @override
  Future<PeriodoMes?> cargarPeriodoActual() async {
    final db = await _db;
    final filas = await db.query(
      DatabaseConstants.tablaPeriodos,
      orderBy: '${DatabaseConstants.colId} ${DatabaseConstants.descendente}',
      limit: DatabaseConstants.limiteUno,
    );
    if (filas.isEmpty) return null;
    return MovimientoMapper.periodoDesdeFila(filas.first);
  }

  @override
  Future<Movimiento> insertarMovimiento(Movimiento movimiento) async {
    final db = await _db;
    final id = await db.insert(
      DatabaseConstants.tablaMovimientos,
      MovimientoMapper.aFila(movimiento),
    );
    return MovimientoMapper.conId(movimiento, id);
  }

  @override
  Future<void> actualizarMovimiento(
    Movimiento movimiento,
    List<EdicionMovimiento> nuevasEdiciones,
  ) async {
    final db = await _db;
    final id = int.parse(movimiento.id);
    await db.transaction((txn) async {
      await txn.update(
        DatabaseConstants.tablaMovimientos,
        MovimientoMapper.aFila(movimiento),
        where: DatabaseConstants.whereId,
        whereArgs: [id],
      );
      final batch = txn.batch();
      for (final edicion in nuevasEdiciones) {
        batch.insert(
          DatabaseConstants.tablaEdiciones,
          MovimientoMapper.edicionAFila(id, edicion),
        );
      }
      await batch.commit(noResult: true);
    });
  }

  @override
  Future<void> insertarPeriodo(PeriodoMes periodo) async {
    final db = await _db;
    await db.insert(
      DatabaseConstants.tablaPeriodos,
      MovimientoMapper.periodoAFila(periodo),
    );
  }
}
