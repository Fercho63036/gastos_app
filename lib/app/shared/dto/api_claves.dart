/// Claves JSON del contrato con el backend (ver `docs/api_contrato.md`).
class ApiClaves {
  ApiClaves._();

  // Comunes
  static const String id = 'id';
  static const String fecha = 'fecha';
  static const String datos = 'datos';
  static const String total = 'total';

  // Movimientos
  static const String codigo = 'codigo';
  static const String titulo = 'titulo';
  static const String categoria = 'categoria';
  static const String montoCentavos = 'monto_centavos';
  static const String anulado = 'anulado';
  static const String esEntrada = 'es_entrada';
  static const String ediciones = 'ediciones';

  // Ediciones
  static const String campo = 'campo';
  static const String valorAnterior = 'valor_anterior';
  static const String valorNuevo = 'valor_nuevo';

  // Periodos
  static const String inicio = 'inicio';
  static const String arrastradoCentavos = 'arrastrado_centavos';
  static const String montoMesCentavos = 'monto_mes_centavos';
  static const String pisoCentavos = 'piso_centavos';

  // Resumen
  static const String saldoCentavos = 'saldo_centavos';
  static const String gastableCentavos = 'gastable_centavos';
  static const String gastableTotalCentavos = 'gastable_total_centavos';
}
