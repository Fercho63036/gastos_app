import 'package:flutter/widgets.dart';

import 'package:gastos_app/app/core/utils/formato_helpers.dart';

import 'package:gastos_app/app/shared/models/categoria_movimiento.dart';
import 'package:gastos_app/app/shared/services/movimientos_memoria_service.dart';
import 'package:gastos_app/app/shared/utils/resumen_helpers.dart';

import '../utils/movimientos_helpers.dart';

class NuevoGastoProvider extends ChangeNotifier {
  final MovimientosMemoriaService _datos;
  final TextEditingController montoController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  CategoriaMovimiento _categoria = CategoriaMovimiento.comida;

  NuevoGastoProvider(this._datos) {
    montoController.addListener(notifyListeners);
  }

  CategoriaMovimiento get categoria => _categoria;

  int get montoCentavos => FormatoHelpers.parsearMonto(montoController.text);

  int get saldoDespuesCentavos => ResumenHelpers.saldoDespuesDeGasto(
    _datos.resumen.saldoCentavos,
    montoCentavos,
  );

  void seleccionarCategoria(CategoriaMovimiento categoria) {
    _categoria = categoria;
    notifyListeners();
  }

  /// Devuelve el error a mostrar, o `null` si el gasto se guardó.
  String? guardar() {
    final titulo = descripcionController.text.trim();
    final error = MovimientosHelpers.validarGasto(montoCentavos, titulo);
    if (error != null) return error;
    _datos.registrarGasto(
      titulo: titulo,
      categoria: _categoria,
      montoCentavos: montoCentavos,
    );
    return null;
  }

  @override
  void dispose() {
    montoController.dispose();
    descripcionController.dispose();
    super.dispose();
  }
}
