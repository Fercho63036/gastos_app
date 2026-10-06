/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/formato_strings.dart';
import 'package:gastos_app/app/core/utils/formato_helpers.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/constants/dominio_constants.dart';
import 'package:gastos_app/app/shared/models/fila_resumen_model.dart';
import 'package:gastos_app/app/shared/models/periodo_mes_model.dart';

/********************************* FEATURE **********************************/
import '../constants/periodo_strings.dart';

class PeriodoHelpers {
  PeriodoHelpers._();

  /****************************** TEXTO SOBRANTE ******************************/
  static String textoSobrante(PeriodoMes? anterior) {
    if (anterior == null) return PeriodoStrings.sinMesAnterior;
    return '${PeriodoStrings.sobranteDe}'
        '${FormatoHelpers.nombreMes(anterior.inicio).toLowerCase()}';
  }

  /***************************** PISO PRECARGADO ******************************/
  static String pisoPrecargado(PeriodoMes? anterior) {
    if (anterior == null) return '';
    return FormatoHelpers.formatearNumero(anterior.pisoCentavos);
  }

  /******************************* ES MES ACTUAL *******************************/
  static bool esMesActual(PeriodoMes? periodo, DateTime ahora) =>
      periodo != null &&
      periodo.inicio.year == ahora.year &&
      periodo.inicio.month == ahora.month;

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
        etiqueta: PeriodoStrings.pisoDescontado,
        valor:
            '${FormatoStrings.signoNegativo}'
            '${FormatoHelpers.formatearNumero(pisoCentavos)}',
        divisorAntes: true,
      ),
      FilaResumen(
        etiqueta: PeriodoStrings.disponibleEsteMes,
        valor: FormatoHelpers.formatearMonto(saldoInicial - pisoCentavos),
        estilo: EstiloFilaResumen.acento,
      ),
    ];
  }
}
