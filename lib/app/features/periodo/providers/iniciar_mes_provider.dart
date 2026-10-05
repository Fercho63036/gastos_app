import 'package:flutter/widgets.dart';

import 'package:gastos_app/app/core/utils/formato_helpers.dart';

import 'package:gastos_app/app/shared/models/fila_resumen_model.dart';
import 'package:gastos_app/app/shared/services/movimientos_memoria_service.dart';

import '../utils/periodo_helpers.dart';

/// El sobrante del periodo actual se arrastra al mes que se inicia.
class IniciarMesProvider extends ChangeNotifier {
  final MovimientosMemoriaService _datos;
  final int arrastradoCentavos;
  final String tituloMes;
  final String textoSobrante;
  final TextEditingController montoController = TextEditingController();
  final TextEditingController pisoController;

  IniciarMesProvider(this._datos, DateTime ahora)
    : arrastradoCentavos = _datos.resumen.saldoCentavos,
      tituloMes = FormatoHelpers.formatearMesAnio(ahora),
      textoSobrante = PeriodoHelpers.textoSobrante(_datos.periodoActual.inicio),
      pisoController = TextEditingController(
        text: FormatoHelpers.formatearNumero(_datos.periodoActual.pisoCentavos),
      ) {
    montoController.addListener(notifyListeners);
    pisoController.addListener(notifyListeners);
  }

  int get _montoMes => FormatoHelpers.parsearMonto(montoController.text);
  int get _piso => FormatoHelpers.parsearMonto(pisoController.text);

  List<FilaResumen> get filasResumen => PeriodoHelpers.filasResumen(
    arrastradoCentavos: arrastradoCentavos,
    montoMesCentavos: _montoMes,
    pisoCentavos: _piso,
  );

  /// Devuelve el error a mostrar, o `null` si el mes se inició.
  String? iniciar() {
    final error = PeriodoHelpers.validar(
      montoMesCentavos: _montoMes,
      pisoCentavos: _piso,
      saldoInicialCentavos: arrastradoCentavos + _montoMes,
    );
    if (error != null) return error;
    _datos.iniciarMes(montoMesCentavos: _montoMes, pisoCentavos: _piso);
    return null;
  }

  @override
  void dispose() {
    montoController.dispose();
    pisoController.dispose();
    super.dispose();
  }
}
