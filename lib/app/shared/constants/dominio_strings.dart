/// Textos del dominio de movimientos compartidos por varias features.
class DominioStrings {
  DominioStrings._();

  // Categorías
  static const String comida = 'Comida';
  static const String pasajes = 'Pasajes';
  static const String diversion = 'Diversión';
  static const String ropa = 'Ropa';
  static const String deportes = 'Deportes';
  static const String otros = 'Otros';
  static const String entrada = 'Entrada';

  // Estados
  static const String activo = 'Activo';
  static const String anulado = 'Anulado';

  // Campos editables (historial)
  static const String campoMonto = 'Monto';
  static const String campoDescripcion = 'Descripción';
  static const String campoCategoria = 'Categoría';
  static const String campoEstado = 'Estado';

  // Formato del historial: "Monto: Bs 20,00 → Bs 25,00"
  static const String separadorCampo = ': ';
  static const String flechaCambio = ' → ';
  static const String comillaApertura = '“';
  static const String comillaCierre = '”';

  // Códigos: "G-0042"
  static const String prefijoGasto = 'G-';
  static const String prefijoEntrada = 'E-';

  // Persistencia
  static const String sinCambios = 'No hay cambios para guardar';
  static const String movimientoNoEncontrado = 'No se encontró el movimiento';
  static const String errorGuardar = 'No se pudo guardar. Intenta de nuevo.';
  static const String guardando = 'Guardando…';
}
