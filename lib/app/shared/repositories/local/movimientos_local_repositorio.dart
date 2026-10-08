/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/errors/app_exception.dart';

/********************************** SHARED **********************************/
import '../../constants/dominio_strings.dart';
import '../../models/borrador_movimiento_model.dart';
import '../../models/movimiento_model.dart';
import '../../models/periodo_mes_model.dart';
import '../../models/resumen_mes_model.dart';
import '../../paginado/models/paginated_response_model.dart';
import '../../paginado/utils/paginado_helpers.dart';
import '../../services/movimientos_almacen.dart';
import '../../utils/ediciones_helpers.dart';
import '../../utils/saldo_helpers.dart';
import '../movimientos_repositorio.dart';

/********************** MOVIMIENTOS LOCAL REPOSITORIO ***********************/
class MovimientosLocalRepositorio implements MovimientosRepositorio {
  final MovimientosAlmacen _almacen;
  final DateTime Function() _ahora;

  MovimientosLocalRepositorio(
    this._almacen, {
    DateTime Function() ahora = DateTime.now,
  }) : _ahora = ahora;

  Future<Movimiento?> _buscar(String id) async {
    for (final movimiento in await _almacen.cargarMovimientos()) {
      if (movimiento.id == id) return movimiento;
    }
    return null;
  }

  @override
  Future<ResumenMes> obtenerResumen() async {
    final periodo = await _almacen.cargarPeriodoActual();
    return SaldoHelpers.calcular(
      periodo ?? PeriodoMes.sinIniciar,
      await _almacen.cargarMovimientos(),
    );
  }

  @override
  Future<PaginatedResponse<Movimiento>> listarMovimientos({
    required DateTime desde,
    required int pagina,
    required int porPagina,
  }) async {
    final todos = await _almacen.cargarMovimientos();
    final filtrados = todos.where((mov) => !mov.fecha.isBefore(desde)).toList();
    return PaginatedResponse(
      datos: PaginadoHelpers.paginar(filtrados, pagina, porPagina),
      total: filtrados.length,
    );
  }

  /************************** LISTAR VIGENTES DESDE ****************************/
  @override
  Future<List<Movimiento>> listarVigentesDesde({
    required DateTime desde,
  }) async {
    final todos = await _almacen.cargarMovimientos();
    return todos
        .where((mov) => !mov.anulado && !mov.fecha.isBefore(desde))
        .toList();
  }

  @override
  Future<Movimiento> obtenerMovimiento(String id) async {
    final movimiento = await _buscar(id);
    if (movimiento == null) {
      throw const NoEncontradoException(DominioStrings.movimientoNoEncontrado);
    }
    return movimiento;
  }

  @override
  Future<Movimiento> registrarMovimiento(BorradorMovimiento borrador) {
    return _almacen.insertarMovimiento(
      Movimiento(
        id: '',
        titulo: borrador.titulo,
        categoria: borrador.categoria,
        montoCentavos: borrador.montoCentavos,
        fecha: _ahora(),
        esEntrada: borrador.esEntrada,
      ),
    );
  }

  /*************************** ACTUALIZAR MOVIMIENTO ****************************/
  @override
  Future<Movimiento> actualizarMovimiento(Movimiento editado) async {
    final original = await obtenerMovimiento(editado.id);
    final cambios = EdicionesHelpers.diferencias(original, editado, _ahora());
    if (cambios.isEmpty) {
      throw const ValidacionException(DominioStrings.sinCambios);
    }
    final guardado = editado.copyWith(
      ediciones: [...cambios, ...original.ediciones],
    );
    await _almacen.actualizarMovimiento(guardado, cambios);
    return guardado;
  }

  @override
  Future<PeriodoMes?> obtenerPeriodoActual() => _almacen.cargarPeriodoActual();

  @override
  Future<PeriodoMes> iniciarMes({
    required int montoMesCentavos,
    required int pisoCentavos,
  }) async {
    final resumen = await obtenerResumen();
    final periodo = PeriodoMes(
      inicio: _ahora(),
      arrastradoCentavos: resumen.saldoCentavos,
      montoMesCentavos: montoMesCentavos,
      pisoCentavos: pisoCentavos,
    );
    await _almacen.insertarPeriodo(periodo);
    return periodo;
  }

  /***************************** ACTUALIZAR MONTO MES ***************************/
  @override
  Future<PeriodoMes> actualizarMontoMes({
    required int montoMesCentavos,
    required int pisoCentavos,
  }) async {
    final actual = await _almacen.cargarPeriodoActual();
    if (actual == null) {
      throw const ValidacionException(DominioStrings.sinCambios);
    }
    final periodo = PeriodoMes(
      inicio: actual.inicio,
      arrastradoCentavos: actual.arrastradoCentavos,
      montoMesCentavos: montoMesCentavos,
      pisoCentavos: pisoCentavos,
    );
    await _almacen.actualizarPeriodoActual(periodo);
    return periodo;
  }

  /******************************* ACTUALIZAR PISO ******************************/
  @override
  Future<PeriodoMes> actualizarPiso({
    required int pisoCentavos,
  }) async {
    final actual = await _almacen.cargarPeriodoActual();
    if (actual == null) {
      throw const ValidacionException(DominioStrings.sinCambios);
    }
    final periodo = PeriodoMes(
      inicio: actual.inicio,
      arrastradoCentavos: actual.arrastradoCentavos,
      montoMesCentavos: actual.montoMesCentavos,
      pisoCentavos: pisoCentavos,
    );
    await _almacen.actualizarPeriodoActual(periodo);
    return periodo;
  }
}
