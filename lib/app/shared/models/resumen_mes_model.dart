class ResumenMes {
  /******************************** PROPIEDADES ********************************/
  final int saldoCentavos;
  final int gastableCentavos;
  final int gastableTotalCentavos;
  final int pisoCentavos;
  final int entradasCentavos;
  final int gastadoCentavos;
  final int montoInicialCentavos;

  /******************************** CONSTRUCTOR ********************************/
  const ResumenMes({
    required this.saldoCentavos,
    required this.gastableCentavos,
    required this.gastableTotalCentavos,
    required this.pisoCentavos,
    required this.entradasCentavos,
    required this.gastadoCentavos,
    required this.montoInicialCentavos,
  });

  /************************************ VACIO ************************************/
  static const ResumenMes vacio = ResumenMes(
    saldoCentavos: 0,
    gastableCentavos: 0,
    gastableTotalCentavos: 0,
    pisoCentavos: 0,
    entradasCentavos: 0,
    gastadoCentavos: 0,
    montoInicialCentavos: 0,
  );
}
