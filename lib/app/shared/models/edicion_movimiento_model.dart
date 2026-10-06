/********************************** SHARED **********************************/
import 'campo_edicion.dart';

/**************************** EDICION MOVIMIENTO ****************************/
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
