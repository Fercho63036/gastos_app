/******************************* PERIODO MES ********************************/
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

  /******************************* SIN INICIAR ********************************/
  static final PeriodoMes sinIniciar = PeriodoMes(
    inicio: DateTime.fromMillisecondsSinceEpoch(0),
    arrastradoCentavos: 0,
    montoMesCentavos: 0,
    pisoCentavos: 0,
  );

  int get saldoInicialCentavos => arrastradoCentavos + montoMesCentavos;
}
