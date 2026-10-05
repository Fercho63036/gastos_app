import 'package:gastos_app/app/core/constants/formato_strings.dart';
import 'package:gastos_app/app/core/utils/formato_helpers.dart';

import '../constants/inicio_constants.dart';
import '../models/movimiento_model.dart';
import '../models/periodo_filtro.dart';
import '../models/resumen_mes_model.dart';

/// Reglas propias de Inicio; el formateo genérico vive en [FormatoHelpers].
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

  static List<Movimiento> filtrarPorPeriodo(
    List<Movimiento> movimientos,
    PeriodoFiltro periodo,
    DateTime hoy,
  ) {
    final inicioHoy = FormatoHelpers.soloDia(hoy);
    final desde = switch (periodo) {
      PeriodoFiltro.hoy => inicioHoy,
      PeriodoFiltro.semana => inicioHoy.subtract(
        const Duration(days: InicioConstants.diasSemana - 1),
      ),
      PeriodoFiltro.mes => DateTime(hoy.year, hoy.month),
    };
    return movimientos.where((mov) => !mov.fecha.isBefore(desde)).toList();
  }
}
