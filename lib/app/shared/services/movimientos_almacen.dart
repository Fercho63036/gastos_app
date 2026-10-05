import '../models/edicion_movimiento_model.dart';
import '../models/movimiento_model.dart';
import '../models/periodo_mes_model.dart';

/// Dónde se guardan los movimientos y periodos. La app usa SQLite; los
/// tests, una versión en memoria.
abstract class MovimientosAlmacen {
  /// Del más reciente al más antiguo, cada uno con su historial.
  Future<List<Movimiento>> cargarMovimientos();

  /// El último mes iniciado, o `null` si nunca se inició uno.
  Future<PeriodoMes?> cargarPeriodoActual();

  /// Devuelve el movimiento con el id y el código asignados.
  Future<Movimiento> insertarMovimiento(Movimiento movimiento);

  /// Guarda [movimiento] y agrega [nuevasEdiciones] a su historial.
  Future<void> actualizarMovimiento(
    Movimiento movimiento,
    List<EdicionMovimiento> nuevasEdiciones,
  );

  Future<void> insertarPeriodo(PeriodoMes periodo);
}
