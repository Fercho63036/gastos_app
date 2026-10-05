import 'package:flutter/foundation.dart';

import '../models/categoria_movimiento.dart';
import '../models/movimiento_model.dart';
import '../models/periodo_mes_model.dart';
import '../models/resumen_mes_model.dart';
import '../utils/ediciones_helpers.dart';
import '../utils/resumen_helpers.dart';
import 'movimientos_almacen.dart';

/// Fuente única de movimientos y del periodo. Persiste en [MovimientosAlmacen]
/// y mantiene una copia en memoria; avisa en cada cambio para que todas las
/// pantallas se refresquen solas.
class MovimientosService extends ChangeNotifier {
  final MovimientosAlmacen _almacen;
  final DateTime Function() _ahora;
  final List<Movimiento> _movimientos = [];
  PeriodoMes? _periodo;

  MovimientosService(this._almacen, {DateTime Function() ahora = DateTime.now})
    : _ahora = ahora;

  List<Movimiento> get movimientos => List.unmodifiable(_movimientos);
  PeriodoMes? get periodoActual => _periodo;
  bool get mesIniciado => _periodo != null;

  ResumenMes get resumen =>
      ResumenHelpers.calcular(_periodo ?? PeriodoMes.sinIniciar, _movimientos);

  /// Lee lo guardado; se llama una vez al arrancar la app.
  Future<void> cargar() async {
    final guardados = await _almacen.cargarMovimientos();
    _periodo = await _almacen.cargarPeriodoActual();
    _movimientos
      ..clear()
      ..addAll(guardados);
    notifyListeners();
  }

  Movimiento? buscar(String id) {
    for (final movimiento in _movimientos) {
      if (movimiento.id == id) return movimiento;
    }
    return null;
  }

  /// El id y el código de [borrador] los asigna el almacén.
  Future<Movimiento> _agregar(Movimiento borrador) async {
    final guardado = await _almacen.insertarMovimiento(borrador);
    _movimientos.insert(0, guardado);
    notifyListeners();
    return guardado;
  }

  Future<Movimiento> registrarGasto({
    required String titulo,
    required CategoriaMovimiento categoria,
    required int montoCentavos,
  }) {
    return _agregar(
      Movimiento(
        id: '',
        titulo: titulo,
        categoria: categoria,
        montoCentavos: montoCentavos,
        fecha: _ahora(),
      ),
    );
  }

  Future<Movimiento> registrarEntrada({
    required String titulo,
    required int montoCentavos,
  }) {
    return _agregar(
      Movimiento(
        id: '',
        titulo: titulo,
        categoria: CategoriaMovimiento.entrada,
        montoCentavos: montoCentavos,
        fecha: _ahora(),
        esEntrada: true,
      ),
    );
  }

  /// Guarda [editado] y antepone al historial los campos que cambiaron.
  /// Devuelve `false` si no había cambios o el movimiento no existe.
  Future<bool> actualizar(Movimiento editado) async {
    final original = buscar(editado.id);
    if (original == null) return false;
    final cambios = EdicionesHelpers.diferencias(original, editado, _ahora());
    if (cambios.isEmpty) return false;
    final guardado = editado.copyWith(
      ediciones: [...cambios, ...original.ediciones],
    );
    await _almacen.actualizarMovimiento(guardado, cambios);
    final indice = _movimientos.indexWhere((mov) => mov.id == editado.id);
    if (indice >= 0) _movimientos[indice] = guardado;
    notifyListeners();
    return true;
  }

  /// Abre un periodo nuevo desde ahora; el saldo actual se arrastra.
  Future<void> iniciarMes({
    required int montoMesCentavos,
    required int pisoCentavos,
  }) async {
    final periodo = PeriodoMes(
      inicio: _ahora(),
      arrastradoCentavos: resumen.saldoCentavos,
      montoMesCentavos: montoMesCentavos,
      pisoCentavos: pisoCentavos,
    );
    await _almacen.insertarPeriodo(periodo);
    _periodo = periodo;
    notifyListeners();
  }
}
