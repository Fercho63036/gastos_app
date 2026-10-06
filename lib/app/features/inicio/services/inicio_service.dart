/****************************** FLUTTER / DART ******************************/
import 'package:flutter/foundation.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/models/resumen_mes_model.dart';
import 'package:gastos_app/app/shared/paginado/models/paginated_response_model.dart';
import 'package:gastos_app/app/shared/services/movimientos_service.dart';

/********************************* FEATURE **********************************/
import '../constants/inicio_constants.dart';
import '../models/periodo_filtro.dart';
import '../utils/inicio_helpers.dart';

/****************************** INICIO SERVICE ******************************/
class InicioService {
  final MovimientosService _datos;

  InicioService(this._datos);

  /********************************* CAMBIOS **********************************/
  Listenable get cambios => _datos;

  Future<ResumenMes> obtenerResumen() async => _datos.resumen;

  Future<PaginatedResponse<Movimiento>> obtenerMovimientos({
    required PeriodoFiltro periodo,
    required int pagina,
  }) => _datos.listarMovimientos(
    desde: InicioHelpers.desdeDePeriodo(periodo, DateTime.now()),
    pagina: pagina,
    porPagina: InicioConstants.movimientosPorPagina,
  );
}
