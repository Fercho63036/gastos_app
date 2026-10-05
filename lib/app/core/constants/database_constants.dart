/// Nombres de la base local, sus tablas y columnas.
class DatabaseConstants {
  DatabaseConstants._();

  static const String nombreArchivo = 'gastos_app.db';
  static const int version = 1;

  // Tablas
  static const String tablaMovimientos = 'movimientos';
  static const String tablaEdiciones = 'ediciones';
  static const String tablaPeriodos = 'periodos';

  // Columnas comunes
  static const String colId = 'id';
  static const String colFecha = 'fecha';

  // Movimientos
  static const String colTitulo = 'titulo';
  static const String colCategoria = 'categoria';
  static const String colMontoCentavos = 'monto_centavos';
  static const String colAnulado = 'anulado';
  static const String colEsEntrada = 'es_entrada';

  // Ediciones
  static const String colMovimientoId = 'movimiento_id';
  static const String colCampo = 'campo';
  static const String colValorAnterior = 'valor_anterior';
  static const String colValorNuevo = 'valor_nuevo';

  // Periodos
  static const String colInicio = 'inicio';
  static const String colArrastradoCentavos = 'arrastrado_centavos';
  static const String colMontoMesCentavos = 'monto_mes_centavos';
  static const String colPisoCentavos = 'piso_centavos';

  // SQLite no tiene booleanos
  static const int verdadero = 1;
  static const int falso = 0;

  static const String descendente = 'DESC';
  static const String whereId = '$colId = ?';
  static const int limiteUno = 1;
}
