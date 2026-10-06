/********************************** SHARED **********************************/
import '../constants/dominio_strings.dart';

enum EstadoMovimiento {
  activo(DominioStrings.activo),
  anulado(DominioStrings.anulado);

  final String etiqueta;

  const EstadoMovimiento(this.etiqueta);

  static EstadoMovimiento desde({required bool anulado}) =>
      anulado ? EstadoMovimiento.anulado : EstadoMovimiento.activo;
}
