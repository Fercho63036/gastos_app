/// Un cambio guardado sobre un movimiento; los valores ya vienen formateados.
class EdicionMovimiento {
  final String campo;
  final String valorAnterior;
  final String valorNuevo;
  final DateTime fecha;

  const EdicionMovimiento({
    required this.campo,
    required this.valorAnterior,
    required this.valorNuevo,
    required this.fecha,
  });
}
