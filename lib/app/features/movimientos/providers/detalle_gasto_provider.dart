/****************************** FLUTTER / DART ******************************/
import 'package:flutter/widgets.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/errors/app_exception.dart';
import 'package:gastos_app/app/core/utils/formato_helpers.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/constants/dominio_strings.dart';
import 'package:gastos_app/app/shared/models/categoria_movimiento.dart';
import 'package:gastos_app/app/shared/models/estado_movimiento.dart';
import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/services/movimientos_service.dart';
import 'package:gastos_app/app/shared/utils/ediciones_helpers.dart';
import 'package:gastos_app/app/shared/utils/guardado_mixin.dart';

/********************************* FEATURE **********************************/
import '../constants/movimientos_strings.dart';
import '../utils/movimientos_helpers.dart';

/************************** DETALLE GASTO PROVIDER **************************/
class DetalleGastoProvider extends ChangeNotifier with GuardadoMixin {
  final MovimientosService _datos;
  final String _id;
  final TextEditingController montoController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  Movimiento? _gasto;
  CategoriaMovimiento _categoria = CategoriaMovimiento.comida;
  EstadoMovimiento _estado = EstadoMovimiento.activo;
  bool _cargando = true;
  bool _desechado = false;

  DetalleGastoProvider(this._datos, this._id) {
    _cargarGasto();
  }

  Movimiento? get gasto => _gasto;
  CategoriaMovimiento get categoria => _categoria;
  EstadoMovimiento get estado => _estado;
  bool get cargando => _cargando;

  /******************************* CARGAR GASTO *******************************/
  Future<void> _cargarGasto() async {
    try {
      _aplicarBorrador(await _datos.obtener(_id));
    } on AppException catch (error) {
      debugPrint('${MovimientosStrings.gastoNoEncontrado}: $error');
    } finally {
      _cargando = false;
      if (!_desechado) notifyListeners();
    }
  }

  void _aplicarBorrador(Movimiento gasto) {
    _gasto = gasto;
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

  /***************************** GUARDAR CAMBIOS ******************************/
  Future<String?> guardarCambios() => guardarConEstado(_guardarBorrador);

  Future<String?> _guardarBorrador() async {
    final gasto = _gasto;
    if (gasto == null) return MovimientosStrings.gastoNoEncontrado;
    final monto = FormatoHelpers.parsearMonto(montoController.text);
    final titulo = descripcionController.text.trim();
    final quedaVigente = _estado != EstadoMovimiento.anulado;
    final error = quedaVigente
        ? MovimientosHelpers.validarGasto(
            monto,
            titulo,
            saldoDisponibleCentavos:
                _datos.resumen.saldoCentavos +
                (gasto.anulado ? 0 : gasto.montoCentavos),
          )
        : MovimientosHelpers.validarMonto(monto) ??
              (titulo.isEmpty ? MovimientosStrings.descripcionVacia : null);
    if (error != null) return error;
    final editado = gasto.copyWith(
      montoCentavos: monto,
      titulo: titulo,
      categoria: _categoria,
      anulado: _estado == EstadoMovimiento.anulado,
    );
    if (!EdicionesHelpers.hayCambios(gasto, editado)) {
      return DominioStrings.sinCambios;
    }
    _aplicarBorrador(await _datos.actualizar(editado));
    return null;
  }

  @override
  void dispose() {
    _desechado = true;
    montoController.dispose();
    descripcionController.dispose();
    super.dispose();
  }
}
