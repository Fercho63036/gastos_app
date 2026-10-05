import 'package:gastos_app/app/core/constants/formato_strings.dart';
import 'package:gastos_app/app/core/utils/formato_helpers.dart';

import 'package:gastos_app/app/shared/constants/dominio_constants.dart';
import 'package:gastos_app/app/shared/models/fila_resumen_model.dart';

import '../constants/periodo_strings.dart';

class PeriodoHelpers {
  PeriodoHelpers._();

  /// "Sobrante de septiembre".
  static String textoSobrante(DateTime inicioAnterior) =>
      '${PeriodoStrings.sobranteDe}'
      '${FormatoHelpers.nombreMes(inicioAnterior).toLowerCase()}';

  static String? validar({
    required int montoMesCentavos,
    required int pisoCentavos,
    required int saldoInicialCentavos,
  }) {
    if (montoMesCentavos < DominioConstants.montoMinimoCentavos) {
      return PeriodoStrings.montoInvalido;
    }
    if (pisoCentavos > saldoInicialCentavos) {
      return PeriodoStrings.pisoMayorASaldo;
    }
    return null;
  }

  static List<FilaResumen> filasResumen({
    required int arrastradoCentavos,
    required int montoMesCentavos,
    required int pisoCentavos,
  }) {
    final saldoInicial = arrastradoCentavos + montoMesCentavos;
    return [
      FilaResumen(
        etiqueta: PeriodoStrings.arrastradoMasMonto,
        valor:
            '${FormatoHelpers.formatearMonto(arrastradoCentavos)}'
            '${FormatoStrings.suma}'
            '${FormatoHelpers.formatearNumero(montoMesCentavos)}',
      ),
      FilaResumen(
        etiqueta: PeriodoStrings.saldoInicial,
        valor: FormatoHelpers.formatearMonto(saldoInicial),
        estilo: EstiloFilaResumen.destacado,
      ),
      FilaResumen(
        etiqueta: PeriodoStrings.gastable,
        valor: FormatoHelpers.formatearMonto(saldoInicial - pisoCentavos),
        estilo: EstiloFilaResumen.acento,
        divisorAntes: true,
      ),
    ];
  }
}
