/****************************** FLUTTER / DART ******************************/
import 'package:flutter/foundation.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/services/movimientos_service.dart';

/********************************* FEATURE **********************************/
import '../../inicio/models/periodo_filtro.dart';
import '../../inicio/utils/inicio_helpers.dart';

/***************************** RESUMEN SERVICE *******************************/
class ResumenService {
  final MovimientosService _datos;

  ResumenService(this._datos);

  /********************************* CAMBIOS ***********************************/
  Listenable get cambios => _datos;

  Future<List<Movimiento>> obtenerVigentes(PeriodoFiltro periodo) =>
      _datos.listarVigentesDesde(
        desde: InicioHelpers.desdeDePeriodo(periodo, DateTime.now()),
      );
}
