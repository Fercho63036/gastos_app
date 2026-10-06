import '../constants/dominio_strings.dart';

/// Campos editables de un movimiento; [name] es la clave que viaja al API.
enum CampoEdicion {
  monto(DominioStrings.campoMonto),
  descripcion(DominioStrings.campoDescripcion),
  categoria(DominioStrings.campoCategoria),
  estado(DominioStrings.campoEstado);

  final String etiqueta;

  const CampoEdicion(this.etiqueta);
}
