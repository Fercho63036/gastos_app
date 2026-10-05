import 'package:flutter/widgets.dart';

import 'package:gastos_app/app/core/utils/formato_helpers.dart';

import 'package:gastos_app/app/shared/models/categoria_movimiento.dart';
import 'package:gastos_app/app/shared/models/estado_movimiento.dart';
import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/services/movimientos_service.dart';
import 'package:gastos_app/app/shared/utils/guardado_mixin.dart';

import '../constants/movimientos_strings.dart';
import '../utils/movimientos_helpers.dart';

/// Borrador editable de un gasto; al guardar, el servicio arma el historial.
class DetalleGastoProvider extends ChangeNotifier with GuardadoMixin {
  final MovimientosService _datos;
  final String _id;
  final TextEditingController montoController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  Movimiento? _gasto;
  CategoriaMovimiento _categoria = CategoriaMovimiento.comida;
  EstadoMovimiento _estado = EstadoMovimiento.activo;

  DetalleGastoProvider(this._datos, this._id) {
    _cargarBorrador();
  }

  Movimiento? get gasto => _gasto;
  CategoriaMovimiento get categoria => _categoria;
  EstadoMovimiento get estado => _estado;

  void _cargarBorrador() {
    final gasto = _datos.buscar(_id);
    _gasto = gasto;
    if (gasto == null) return;
    montoController.text = FormatoHelpers.formatearNumero(gasto.montoCentavos);
    descripcionController.text = gasto.titulo;
    _categoria = gasto.categoria;
    _estado = gasto.estado;
  }

  void seleccionarCategoria(CategoriaMovimiento categoria) {
    _categoria = categoria;
    notifyListeners();
  }

  void seleccionarEstado(EstadoMovimiento estado) {
    _estado = estado;
    notifyListeners();
  }

  /// Devuelve el error a mostrar, o `null` si los cambios se guardaron.
  Future<String?> guardarCambios() => guardarConEstado(_guardarBorrador);

  Future<String?> _guardarBorrador() async {
    final gasto = _gasto;
    if (gasto == null) return MovimientosStrings.gastoNoEncontrado;
    final monto = FormatoHelpers.parsearMonto(montoController.text);
    final titulo = descripcionController.text.trim();
    final error = MovimientosHelpers.validarGasto(monto, titulo);
    if (error != null) return error;
    final editado = gasto.copyWith(
      montoCentavos: monto,
      titulo: titulo,
      categoria: _categoria,
      anulado: _estado == EstadoMovimiento.anulado,
    );
    if (!await _datos.actualizar(editado)) return MovimientosStrings.sinCambios;
    _cargarBorrador();
    return null;
  }

  @override
  void dispose() {
    montoController.dispose();
    descripcionController.dispose();
    super.dispose();
  }
}
