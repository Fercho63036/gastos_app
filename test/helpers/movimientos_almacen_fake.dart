import 'package:gastos_app/app/shared/models/edicion_movimiento_model.dart';
import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/models/periodo_mes_model.dart';
import 'package:gastos_app/app/shared/services/movimientos_almacen.dart';
import 'package:gastos_app/app/shared/utils/movimiento_mapper.dart';

/// Almacén en memoria que imita a SQLite: sobrevive a crear otro servicio.
class MovimientosAlmacenFake implements MovimientosAlmacen {
  final List<Movimiento> guardados = [];
  final List<PeriodoMes> periodos = [];
  int _ultimoId = 0;

  @override
  Future<List<Movimiento>> cargarMovimientos() async => [...guardados];

  @override
  Future<PeriodoMes?> cargarPeriodoActual() async =>
      periodos.isEmpty ? null : periodos.last;

  @override
  Future<Movimiento> insertarMovimiento(Movimiento movimiento) async {
    final guardado = MovimientoMapper.conId(movimiento, ++_ultimoId);
    guardados.insert(0, guardado);
    return guardado;
  }

  @override
  Future<void> actualizarMovimiento(
    Movimiento movimiento,
    List<EdicionMovimiento> nuevasEdiciones,
  ) async {
    final indice = guardados.indexWhere((mov) => mov.id == movimiento.id);
    guardados[indice] = movimiento;
  }

  @override
  Future<void> insertarPeriodo(PeriodoMes periodo) async =>
      periodos.add(periodo);

  @override
  Future<void> actualizarPeriodoActual(PeriodoMes periodo) async {
    periodos[periodos.length - 1] = periodo;
  }
}
