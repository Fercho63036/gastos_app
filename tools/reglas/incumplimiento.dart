// ****************************** INCUMPLIMIENTO *******************************
class Incumplimiento {
  // ******************************** PROPIEDADES ********************************
  final String ruta;
  final int linea;
  final String mensaje;

  // ******************************** CONSTRUCTOR ********************************
  const Incumplimiento(this.ruta, this.linea, this.mensaje);

  // ********************************* TO STRING *********************************
  @override
  String toString() => '$ruta:$linea  $mensaje';
}
