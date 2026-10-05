import 'package:gastos_app/app/shared/paginado/models/paginated_response_model.dart';
import 'package:gastos_app/app/shared/paginado/utils/paginado_helpers.dart';

import '../constants/inicio_constants.dart';
import '../models/movimiento_model.dart';
import '../models/periodo_filtro.dart';
import '../models/resumen_mes_model.dart';
import '../utils/inicio_helpers.dart';
import 'movimientos_ejemplo_mock.dart';

/// Datos de ejemplo hasta conectar SQLite; las fechas se calculan desde hoy
/// para que siempre haya movimientos en el filtro "Hoy".
class InicioMockService {
  Future<ResumenMes> obtenerResumen() async {
    return const ResumenMes(
      saldoCentavos: 124550,
      gastableCentavos: 119550,
      gastableTotalCentavos: 192800,
      pisoCentavos: 5000,
    );
  }

  Future<PaginatedResponse<Movimiento>> obtenerMovimientos({
    required PeriodoFiltro periodo,
    required int pagina,
  }) async {
    final hoy = DateTime.now();
    final delPeriodo = InicioHelpers.filtrarPorPeriodo(
      MovimientosEjemploMock.generar(hoy),
      periodo,
      hoy,
    );
    return PaginatedResponse(
      datos: PaginadoHelpers.paginar(
        delPeriodo,
        pagina,
        InicioConstants.movimientosPorPagina,
      ),
      total: delPeriodo.length,
    );
  }
}
