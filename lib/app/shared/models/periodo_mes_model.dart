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

  int get saldoInicialCentavos => arrastradoCentavos + montoMesCentavos;
}
