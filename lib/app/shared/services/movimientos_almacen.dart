/********************************** SHARED **********************************/
import '../models/edicion_movimiento_model.dart';
import '../models/movimiento_model.dart';
import '../models/periodo_mes_model.dart';

/**************************** MOVIMIENTOS ALMACEN ****************************/
abstract class MovimientosAlmacen {
  /**************************** CARGAR MOVIMIENTOS ****************************/
  Future<List<Movimiento>> cargarMovimientos();

  /************************** CARGAR PERIODO ACTUAL ***************************/
  Future<PeriodoMes?> cargarPeriodoActual();

  /*************************** INSERTAR MOVIMIENTO ****************************/
  Future<Movimiento> insertarMovimiento(Movimiento movimiento);

  /************************** ACTUALIZAR MOVIMIENTO ***************************/
  Future<void> actualizarMovimiento(
    Movimiento movimiento,
    List<EdicionMovimiento> nuevasEdiciones,
  );

  Future<void> insertarPeriodo(PeriodoMes periodo);

  /************************* ACTUALIZAR PERIODO ACTUAL *************************/
  Future<void> actualizarPeriodoActual(PeriodoMes periodo);
}
