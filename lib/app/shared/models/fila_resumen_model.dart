enum EstiloFilaResumen { normal, destacado, acento, positivo }

/// Una fila "etiqueta · valor" de una tarjeta de resumen.
class FilaResumen {
  final String etiqueta;
  final String valor;
  final EstiloFilaResumen estilo;
  final bool divisorAntes;

  const FilaResumen({
    required this.etiqueta,
    required this.valor,
    this.estilo = EstiloFilaResumen.normal,
    this.divisorAntes = false,
  });
}
