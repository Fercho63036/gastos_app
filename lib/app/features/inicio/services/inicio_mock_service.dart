import 'package:flutter/foundation.dart';

import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/models/resumen_mes_model.dart';
import 'package:gastos_app/app/shared/paginado/models/paginated_response_model.dart';
import 'package:gastos_app/app/shared/paginado/utils/paginado_helpers.dart';
import 'package:gastos_app/app/shared/services/movimientos_memoria_service.dart';

import '../constants/inicio_constants.dart';
import '../models/periodo_filtro.dart';
import '../utils/inicio_helpers.dart';

/// Lee del servicio en memoria compartido y filtra/pagina para Inicio.
class InicioMockService {
  final MovimientosMemoriaService _datos;

  InicioMockService(this._datos);

  /// Avisa cuando otra pantalla registra o edita un movimiento.
  Listenable get cambios => _datos;

  Future<ResumenMes> obtenerResumen() async => _datos.resumen;

  Future<PaginatedResponse<Movimiento>> obtenerMovimientos({
    required PeriodoFiltro periodo,
    required int pagina,
  }) async {
    final delPeriodo = InicioHelpers.filtrarPorPeriodo(
      _datos.movimientos,
      periodo,
      DateTime.now(),
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
