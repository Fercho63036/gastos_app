/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/formato_strings.dart';
import 'package:gastos_app/app/core/utils/formato_helpers.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/models/resumen_mes_model.dart';

/********************************* FEATURE **********************************/
import '../constants/inicio_constants.dart';
import '../models/periodo_filtro.dart';

/****************************** INICIO HELPERS ******************************/
class InicioHelpers {
  InicioHelpers._();

  static String formatearMontoMovimiento(Movimiento movimiento) {
    final signo = movimiento.esEntrada
        ? FormatoStrings.signoPositivo
        : FormatoStrings.signoNegativo;
    return '$signo${FormatoHelpers.formatearMonto(movimiento.montoCentavos)}';
  }

  static double fraccionDisponible(ResumenMes resumen) =>
      FormatoHelpers.fraccion(
        resumen.gastableCentavos,
        resumen.gastableTotalCentavos,
      );

  static int porcentajeDisponible(ResumenMes resumen) =>
      FormatoHelpers.porcentaje(fraccionDisponible(resumen));

  /***************************** DESDE DE PERIODO *****************************/
  static DateTime desdeDePeriodo(PeriodoFiltro periodo, DateTime hoy) {
    final inicioHoy = FormatoHelpers.soloDia(hoy);
    return switch (periodo) {
      PeriodoFiltro.hoy => inicioHoy,
      PeriodoFiltro.semana => inicioHoy.subtract(
        const Duration(days: InicioConstants.diasSemana - 1),
      ),
      PeriodoFiltro.mes => DateTime(hoy.year, hoy.month),
    };
  }
}
