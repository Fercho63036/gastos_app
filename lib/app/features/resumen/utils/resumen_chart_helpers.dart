/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/models/categoria_movimiento.dart';
import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/utils/agrupacion_helpers.dart';

/********************************* FEATURE **********************************/
import '../models/categoria_totalizada_model.dart';
import '../models/punto_barra_model.dart';

/***************************** RESUMEN CHART HELPERS *************************/
class ResumenChartHelpers {
  ResumenChartHelpers._();

  /******************************* POR CATEGORIA *******************************/
  static List<CategoriaTotalizada> porCategoria(List<Movimiento> movimientos) {
    final totales = <CategoriaMovimiento, int>{};
    for (final movimiento in movimientos) {
      if (movimiento.esEntrada) continue;
      totales.update(
        movimiento.categoria,
        (total) => total + movimiento.montoCentavos,
        ifAbsent: () => movimiento.montoCentavos,
      );
    }
    return [
      for (final categoria in CategoriaMovimiento.deGasto)
        if ((totales[categoria] ?? 0) > 0)
          CategoriaTotalizada(
            categoria: categoria,
            totalCentavos: totales[categoria]!,
          ),
    ];
  }

  /*********************************** POR DIA **********************************/
  static List<PuntoBarra> porDia(List<Movimiento> movimientos) {
    final gastos = movimientos.where((mov) => !mov.esEntrada).toList();
    final grupos = AgrupacionHelpers.agruparPorDia(
      gastos,
      (movimiento) => movimiento.fecha,
    );
    return [
      for (final grupo in grupos.reversed)
        PuntoBarra(
          fecha: grupo.fecha,
          totalCentavos: grupo.items.fold(
            0,
            (total, mov) => total + mov.montoCentavos,
          ),
        ),
    ];
  }
}
