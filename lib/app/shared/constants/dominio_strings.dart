/***************************** DOMINIO STRINGS ******************************/
class DominioStrings {
  DominioStrings._();

  /******************************** CATEGORÍAS ********************************/
  static const String comida = 'Comida';
  static const String pasajes = 'Pasajes';
  static const String diversion = 'Diversión';
  static const String ropa = 'Ropa';
  static const String deportes = 'Deportes';
  static const String otros = 'Otros';
  static const String entrada = 'Entrada';

  /********************************* ESTADOS **********************************/
  static const String activo = 'Activo';
  static const String anulado = 'Anulado';

  /*********************** CAMPOS EDITABLES (HISTORIAL) ***********************/
  static const String campoMonto = 'Monto';
  static const String campoDescripcion = 'Descripción';
  static const String campoCategoria = 'Categoría';
  static const String campoEstado = 'Estado';

  /************************* FORMATO DEL HISTORIAL **************************/
  static const String separadorCampo = ': ';
  static const String flechaCambio = ' → ';
  static const String comillaApertura = '“';
  static const String comillaCierre = '”';

  /********************************** CODIGOS *********************************/
  static const String prefijoGasto = 'G-';
  static const String prefijoEntrada = 'E-';

  /******************************* PERSISTENCIA *******************************/
  static const String sinCambios = 'No hay cambios para guardar';
  static const String movimientoNoEncontrado = 'No se encontró el movimiento';
  static const String errorGuardar = 'No se pudo guardar. Intenta de nuevo.';
  static const String guardando = 'Guardando…';
}
