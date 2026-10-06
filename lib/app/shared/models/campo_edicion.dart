/********************************** SHARED **********************************/
import '../constants/dominio_strings.dart';

/****************************** CAMPO EDICION *******************************/
enum CampoEdicion {
  monto(DominioStrings.campoMonto),
  descripcion(DominioStrings.campoDescripcion),
  categoria(DominioStrings.campoCategoria),
  estado(DominioStrings.campoEstado);

  final String etiqueta;

  const CampoEdicion(this.etiqueta);
}
