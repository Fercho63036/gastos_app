import 'package:flutter/foundation.dart';

import '../constants/dominio_strings.dart';
import '../models/categoria_movimiento.dart';
import '../models/movimiento_model.dart';
import '../models/periodo_mes_model.dart';
import '../models/resumen_mes_model.dart';
import '../utils/codigo_helpers.dart';
import '../utils/ediciones_helpers.dart';
import '../utils/resumen_helpers.dart';
import 'ejemplo/movimientos_ejemplo_mock.dart';

/// Fuente única de movimientos y del periodo mientras no hay SQLite.
/// Avisa a sus oyentes en cada cambio para que todas las pantallas se
/// refresquen solas.
class MovimientosMemoriaService extends ChangeNotifier {
  final DateTime Function() _ahora;
  final List<Movimiento> _movimientos;
  PeriodoMes _periodo;
  int _ultimoNumero;

  MovimientosMemoriaService({DateTime Function() ahora = DateTime.now})
    : this._sembrado(ahora, ahora());

  MovimientosMemoriaService._sembrado(this._ahora, DateTime hoy)
    : _movimientos = MovimientosEjemploMock.generar(hoy),
      _periodo = MovimientosEjemploMock.periodo(hoy),
      _ultimoNumero = 0 {
    for (var indice = _movimientos.length - 1; indice >= 0; indice--) {
      _movimientos[indice] = _movimientos[indice].copyWith(
        codigo: _siguienteCodigo(DominioStrings.prefijoGasto),
      );
    }
  }

  List<Movimiento> get movimientos => List.unmodifiable(_movimientos);
  PeriodoMes get periodoActual => _periodo;
  ResumenMes get resumen => ResumenHelpers.calcular(_periodo, _movimientos);

  String _siguienteCodigo(String prefijo) =>
      CodigoHelpers.formatear(prefijo, ++_ultimoNumero);

  Movimiento? buscar(String id) {
    for (final movimiento in _movimientos) {
      if (movimiento.id == id) return movimiento;
    }
    return null;
  }

  Movimiento _agregar(Movimiento movimiento) {
    _movimientos.insert(0, movimiento);
    notifyListeners();
    return movimiento;
  }

  Movimiento registrarGasto({
    required String titulo,
    required CategoriaMovimiento categoria,
    required int montoCentavos,
  }) {
    final codigo = _siguienteCodigo(DominioStrings.prefijoGasto);
    return _agregar(
      Movimiento(
        id: codigo,
        codigo: codigo,
        titulo: titulo,
        categoria: categoria,
        montoCentavos: montoCentavos,
        fecha: _ahora(),
      ),
    );
  }

  Movimiento registrarEntrada({
    required String titulo,
    required int montoCentavos,
  }) {
    final codigo = _siguienteCodigo(DominioStrings.prefijoEntrada);
    return _agregar(
      Movimiento(
        id: codigo,
        codigo: codigo,
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
  bool actualizar(Movimiento editado) {
    final indice = _movimientos.indexWhere((mov) => mov.id == editado.id);
    if (indice < 0) return false;
    final original = _movimientos[indice];
    final cambios = EdicionesHelpers.diferencias(original, editado, _ahora());
    if (cambios.isEmpty) return false;
    _movimientos[indice] = editado.copyWith(
      ediciones: [...cambios, ...original.ediciones],
    );
    notifyListeners();
    return true;
  }

  /// Abre un periodo nuevo desde ahora; el saldo actual se arrastra.
  void iniciarMes({required int montoMesCentavos, required int pisoCentavos}) {
    _periodo = PeriodoMes(
      inicio: _ahora(),
      arrastradoCentavos: resumen.saldoCentavos,
      montoMesCentavos: montoMesCentavos,
      pisoCentavos: pisoCentavos,
    );
    notifyListeners();
  }
}
