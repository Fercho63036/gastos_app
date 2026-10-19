// ******************************** CONSTANTES *********************************
final RegExp _patronCadena = RegExp(
  r'''r?'(?:[^'\\]|\\.)*'|r?"(?:[^"\\]|\\.)*"''',
);

// ****************************** QUITAR CADENAS *******************************
String quitarCadenas(String linea) => linea.replaceAll(_patronCadena, '""');

// *************************** CODIGO SIN COMENTARIO ***************************
String codigoSinComentario(String linea) {
  final String sinCadenas = quitarCadenas(linea);
  final int posicion = sinCadenas.indexOf('//');
  return posicion == -1 ? sinCadenas : sinCadenas.substring(0, posicion);
}
