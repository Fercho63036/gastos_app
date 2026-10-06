/******************************** API CLAVES ********************************/
class ApiClaves {
  ApiClaves._();

  /********************************* COMUNES **********************************/
  static const String id = 'id';
  static const String fecha = 'fecha';
  static const String datos = 'datos';
  static const String total = 'total';

  /******************************* MOVIMIENTOS ********************************/
  static const String codigo = 'codigo';
  static const String titulo = 'titulo';
  static const String categoria = 'categoria';
  static const String montoCentavos = 'monto_centavos';
  static const String anulado = 'anulado';
  static const String esEntrada = 'es_entrada';
  static const String ediciones = 'ediciones';

  /******************************** EDICIONES *********************************/
  static const String campo = 'campo';
  static const String valorAnterior = 'valor_anterior';
  static const String valorNuevo = 'valor_nuevo';

  /********************************* PERIODOS *********************************/
  static const String inicio = 'inicio';
  static const String arrastradoCentavos = 'arrastrado_centavos';
  static const String montoMesCentavos = 'monto_mes_centavos';
  static const String pisoCentavos = 'piso_centavos';

  /********************************* RESUMEN **********************************/
  static const String saldoCentavos = 'saldo_centavos';
  static const String gastableCentavos = 'gastable_centavos';
  static const String gastableTotalCentavos = 'gastable_total_centavos';
  static const String entradasCentavos = 'entradas_centavos';
  static const String gastadoCentavos = 'gastado_centavos';
}
