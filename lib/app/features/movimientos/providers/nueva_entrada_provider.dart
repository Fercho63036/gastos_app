import 'package:flutter/widgets.dart';

import 'package:gastos_app/app/core/utils/formato_helpers.dart';

import 'package:gastos_app/app/shared/models/fila_resumen_model.dart';
import 'package:gastos_app/app/shared/services/movimientos_memoria_service.dart';

import '../constants/movimientos_strings.dart';
import '../utils/movimientos_helpers.dart';

class NuevaEntradaProvider extends ChangeNotifier {
  final MovimientosMemoriaService _datos;
  final TextEditingController montoController = TextEditingController();
  final TextEditingController motivoController = TextEditingController();

  NuevaEntradaProvider(this._datos) {
    montoController.addListener(notifyListeners);
  }

  int get montoCentavos => FormatoHelpers.parsearMonto(montoController.text);

  List<FilaResumen> get filasResumen => MovimientosHelpers.filasResumenEntrada(
    _datos.resumen.saldoCentavos,
    montoCentavos,
  );

  /// Devuelve el error a mostrar, o `null` si la entrada se registró.
  String? registrar() {
    final error = MovimientosHelpers.validarMonto(montoCentavos);
    if (error != null) return error;
    final motivo = motivoController.text.trim();
    _datos.registrarEntrada(
      titulo: motivo.isEmpty ? MovimientosStrings.entrada : motivo,
      montoCentavos: montoCentavos,
    );
    return null;
  }

  @override
  void dispose() {
    montoController.dispose();
    motivoController.dispose();
    super.dispose();
  }
}
