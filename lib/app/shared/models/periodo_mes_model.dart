/// Un mes iniciado a mano: desde [inicio] cuentan los movimientos del saldo.
class PeriodoMes {
  final DateTime inicio;
  final int arrastradoCentavos;
  final int montoMesCentavos;
  final int pisoCentavos;

  const PeriodoMes({
    required this.inicio,
    required this.arrastradoCentavos,
    required this.montoMesCentavos,
    required this.pisoCentavos,
  });

  /// Mientras no se inicie un mes: todo en cero y cuentan todos los
  /// movimientos.
  static final PeriodoMes sinIniciar = PeriodoMes(
    inicio: DateTime.fromMillisecondsSinceEpoch(0),
    arrastradoCentavos: 0,
    montoMesCentavos: 0,
    pisoCentavos: 0,
  );

  int get saldoInicialCentavos => arrastradoCentavos + montoMesCentavos;
}
