import '../models/borrador_movimiento_model.dart';
import '../models/movimiento_model.dart';
import '../models/periodo_mes_model.dart';
import '../models/resumen_mes_model.dart';
import '../paginado/models/paginated_response_model.dart';

/// Contrato de datos de movimientos. Cada método corresponde a un endpoint
/// de `docs/api_contrato.md`; los cálculos (saldo, historial, código,
/// arrastre) son responsabilidad de quien lo implemente, no de la app.
///
/// Los errores esperables se lanzan como `AppException`.
abstract class MovimientosRepositorio {
  /// `GET /resumen`
  Future<ResumenMes> obtenerResumen();

  /// `GET /movimientos?desde=&pagina=&por_pagina=`, del más reciente al más
  /// antiguo.
  Future<PaginatedResponse<Movimiento>> listarMovimientos({
    required DateTime desde,
    required int pagina,
    required int porPagina,
  });

  /// `GET /movimientos/{id}`, con su historial. Lanza
  /// `NoEncontradoException` si no existe.
  Future<Movimiento> obtenerMovimiento(String id);

  /// `POST /movimientos`. Devuelve el movimiento con id, código y fecha.
  Future<Movimiento> registrarMovimiento(BorradorMovimiento borrador);

  /// `PATCH /movimientos/{id}`. Devuelve el movimiento con el historial ya
  /// actualizado; lanza `ValidacionException` si no hubo cambios.
  Future<Movimiento> actualizarMovimiento(Movimiento editado);

  /// `GET /periodos/actual`; `null` si nunca se inició un mes.
  Future<PeriodoMes?> obtenerPeriodoActual();

  /// `POST /periodos`. El saldo actual se arrastra al nuevo mes.
  Future<PeriodoMes> iniciarMes({
    required int montoMesCentavos,
    required int pisoCentavos,
  });
}
