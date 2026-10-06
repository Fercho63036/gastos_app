/********************************** SHARED **********************************/
import '../models/borrador_movimiento_model.dart';
import '../models/movimiento_model.dart';
import '../models/periodo_mes_model.dart';
import '../models/resumen_mes_model.dart';
import '../paginado/models/paginated_response_model.dart';

/************************** MOVIMIENTOS REPOSITORIO ***************************/
abstract class MovimientosRepositorio {
  /***************************** OBTENER RESUMEN ******************************/
  Future<ResumenMes> obtenerResumen();

  /**************************** LISTAR MOVIMIENTOS ****************************/
  Future<PaginatedResponse<Movimiento>> listarMovimientos({
    required DateTime desde,
    required int pagina,
    required int porPagina,
  });

  /**************************** OBTENER MOVIMIENTO ****************************/
  Future<Movimiento> obtenerMovimiento(String id);

  /*************************** REGISTRAR MOVIMIENTO ***************************/
  Future<Movimiento> registrarMovimiento(BorradorMovimiento borrador);

  /************************** ACTUALIZAR MOVIMIENTO ***************************/
  Future<Movimiento> actualizarMovimiento(Movimiento editado);

  /************************** OBTENER PERIODO ACTUAL **************************/
  Future<PeriodoMes?> obtenerPeriodoActual();

  /******************************* INICIAR MES ********************************/
  Future<PeriodoMes> iniciarMes({
    required int montoMesCentavos,
    required int pisoCentavos,
  });

  /***************************** ACTUALIZAR MONTO MES ***************************/
  Future<PeriodoMes> actualizarMontoMes({
    required int montoMesCentavos,
    required int pisoCentavos,
  });
}
