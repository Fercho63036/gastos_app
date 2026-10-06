/**************************** DATABASE CONSTANTS ****************************/
class DatabaseConstants {
  DatabaseConstants._();

  static const String nombreArchivo = 'gastos_app.db';
  static const int version = 2;

  /************************* VERSION EDICIONES CRUDAS *************************/
  static const int versionEdicionesCrudas = 2;

  /********************************** TABLAS **********************************/
  static const String tablaMovimientos = 'movimientos';
  static const String tablaEdiciones = 'ediciones';
  static const String tablaPeriodos = 'periodos';

  /***************************** COLUMNAS COMUNES *****************************/
  static const String colId = 'id';
  static const String colFecha = 'fecha';

  /******************************* MOVIMIENTOS ********************************/
  static const String colTitulo = 'titulo';
  static const String colCategoria = 'categoria';
  static const String colMontoCentavos = 'monto_centavos';
  static const String colAnulado = 'anulado';
  static const String colEsEntrada = 'es_entrada';

  /******************************** EDICIONES *********************************/
  static const String colMovimientoId = 'movimiento_id';
  static const String colCampo = 'campo';
  static const String colValorAnterior = 'valor_anterior';
  static const String colValorNuevo = 'valor_nuevo';

  /********************************* PERIODOS *********************************/
  static const String colInicio = 'inicio';
  static const String colArrastradoCentavos = 'arrastrado_centavos';
  static const String colMontoMesCentavos = 'monto_mes_centavos';
  static const String colPisoCentavos = 'piso_centavos';

  /*********************** S Q LITE NO TIENE BOOLEANOS ************************/
  static const int verdadero = 1;
  static const int falso = 0;

  static const String descendente = 'DESC';
  static const String whereId = '$colId = ?';
  static const int limiteUno = 1;
}
