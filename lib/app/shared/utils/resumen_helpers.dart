import '../models/movimiento_model.dart';
import '../models/periodo_mes_model.dart';
import '../models/resumen_mes_model.dart';

/// Cálculo del saldo del mes a partir del periodo y sus movimientos.
class ResumenHelpers {
  ResumenHelpers._();

  /// Movimientos que cuentan: no anulados y desde el inicio del periodo.
  static Iterable<Movimiento> vigentes(
    PeriodoMes periodo,
    List<Movimiento> movimientos,
  ) => movimientos.where(
    (movimiento) =>
        !movimiento.anulado && !movimiento.fecha.isBefore(periodo.inicio),
  );

  static int _sumar(Iterable<Movimiento> movimientos) => movimientos.fold(
    0,
    (total, movimiento) => total + movimiento.montoCentavos,
  );

  static ResumenMes calcular(PeriodoMes periodo, List<Movimiento> movimientos) {
    final cuentan = vigentes(periodo, movimientos);
    final entradas = _sumar(cuentan.where((mov) => mov.esEntrada));
    final gastos = _sumar(cuentan.where((mov) => !mov.esEntrada));
    final ingresado = periodo.saldoInicialCentavos + entradas;
    final saldo = ingresado - gastos;
    return ResumenMes(
      saldoCentavos: saldo,
      gastableCentavos: saldo - periodo.pisoCentavos,
      gastableTotalCentavos: ingresado - periodo.pisoCentavos,
      pisoCentavos: periodo.pisoCentavos,
    );
  }

  static int saldoDespuesDeGasto(int saldoCentavos, int gastoCentavos) =>
      saldoCentavos - gastoCentavos;

  static int saldoDespuesDeEntrada(int saldoCentavos, int entradaCentavos) =>
      saldoCentavos + entradaCentavos;
}
