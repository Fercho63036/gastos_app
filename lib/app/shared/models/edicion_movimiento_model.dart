import 'campo_edicion.dart';

/// Un cambio guardado sobre un movimiento. Los valores son crudos (centavos,
/// texto, `name` de la categoría o del estado); se formatean al mostrarlos.
class EdicionMovimiento {
  final CampoEdicion campo;
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
