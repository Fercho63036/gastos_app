/****************************** FLUTTER / DART ******************************/
import 'package:flutter/foundation.dart';

/********************************** SHARED **********************************/
import '../models/borrador_movimiento_model.dart';
import '../models/categoria_movimiento.dart';
import '../models/movimiento_model.dart';
import '../models/periodo_mes_model.dart';
import '../models/resumen_mes_model.dart';
import '../paginado/models/paginated_response_model.dart';
import '../repositories/movimientos_repositorio.dart';

/*************************** MOVIMIENTOS SERVICE ****************************/
class MovimientosService extends ChangeNotifier {
  final MovimientosRepositorio _repositorio;
  ResumenMes _resumen = ResumenMes.vacio;
  PeriodoMes? _periodo;

  MovimientosService(this._repositorio);

  ResumenMes get resumen => _resumen;
  PeriodoMes? get periodoActual => _periodo;
  bool get mesIniciado => _periodo != null;

  /********************************** CARGAR **********************************/
  Future<void> cargar() async {
    _resumen = await _repositorio.obtenerResumen();
    _periodo = await _repositorio.obtenerPeriodoActual();
    notifyListeners();
  }

  Future<PaginatedResponse<Movimiento>> listarMovimientos({
    required DateTime desde,
    required int pagina,
    required int porPagina,
  }) => _repositorio.listarMovimientos(
    desde: desde,
    pagina: pagina,
    porPagina: porPagina,
  );

  Future<Movimiento> obtener(String id) => _repositorio.obtenerMovimiento(id);

  Future<Movimiento> _registrar(BorradorMovimiento borrador) async {
    final guardado = await _repositorio.registrarMovimiento(borrador);
    await cargar();
    return guardado;
  }

  Future<Movimiento> registrarGasto({
    required String titulo,
    required CategoriaMovimiento categoria,
    required int montoCentavos,
  }) => _registrar(
    BorradorMovimiento(
      titulo: titulo,
      categoria: categoria,
      montoCentavos: montoCentavos,
    ),
  );

  Future<Movimiento> registrarEntrada({
    required String titulo,
    required int montoCentavos,
  }) => _registrar(
    BorradorMovimiento(
      titulo: titulo,
      categoria: CategoriaMovimiento.entrada,
      montoCentavos: montoCentavos,
      esEntrada: true,
    ),
  );

  /******************************** ACTUALIZAR ********************************/
  Future<Movimiento> actualizar(Movimiento editado) async {
    final guardado = await _repositorio.actualizarMovimiento(editado);
    await cargar();
    return guardado;
  }

  Future<void> iniciarMes({
    required int montoMesCentavos,
    required int pisoCentavos,
  }) async {
    await _repositorio.iniciarMes(
      montoMesCentavos: montoMesCentavos,
      pisoCentavos: pisoCentavos,
    );
    await cargar();
  }
}
