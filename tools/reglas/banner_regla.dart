// *********************************** DART ************************************
import 'dart:io';

// ******************************** CONSTANTES *********************************
const int anchoBanner = 80;
const String prefijoBanner = '// ';
final RegExp _patronBanner = RegExp(r'^// (\*+) (.+?) (\*+)$');
final RegExp _patronBannerAntiguo = RegExp(r'^/\*+\s*(.+?)\s*\*+/$');
final RegExp _patronBannerSuelto = RegExp(r'^//\s*\*+\s*(.+?)\s*\*+\s*$');

// ****************************** GENERAR BANNER *******************************
String generarBanner(String texto) {
  final String textoMayuscula = texto.trim().toUpperCase();
  final int disponible =
      anchoBanner - prefijoBanner.length - textoMayuscula.length - 2;
  final int relleno = disponible < 2 ? 2 : disponible;
  final int izquierda = relleno ~/ 2;
  final int derecha = relleno - izquierda;
  return '$prefijoBanner${'*' * izquierda} $textoMayuscula ${'*' * derecha}';
}

// ***************************** ES BANNER VALIDO ******************************
bool esBannerValido(String lineaRecortada) {
  final RegExpMatch? coincidencia = _patronBanner.firstMatch(lineaRecortada);
  if (coincidencia == null) return false;
  final String texto = coincidencia.group(2) ?? '';
  return generarBanner(texto) == lineaRecortada;
}

// ************************** TEXTO BANNER APROXIMADO **************************
String? _textoBannerAproximado(String lineaRecortada) {
  for (final RegExp patron in <RegExp>[
    _patronBannerAntiguo,
    _patronBannerSuelto,
  ]) {
    final RegExpMatch? coincidencia = patron.firstMatch(lineaRecortada);
    if (coincidencia != null) return coincidencia.group(1);
  }
  return null;
}

// ***************************** NORMALIZAR LINEA ******************************
String? _normalizarLinea(String linea) {
  final String? texto = _textoBannerAproximado(linea.trim());
  if (texto == null) return null;
  final int sangria = linea.length - linea.trimLeft().length;
  return '${linea.substring(0, sangria)}${generarBanner(texto)}';
}

// **************************** NORMALIZAR ARCHIVO *****************************
bool normalizarArchivo(File archivo) {
  final List<String> lineas = archivo.readAsLinesSync();
  bool huboCambios = false;
  for (int indice = 0; indice < lineas.length; indice++) {
    final String? lineaNueva = _normalizarLinea(lineas[indice]);
    if (lineaNueva == null || lineaNueva == lineas[indice]) continue;
    lineas[indice] = lineaNueva;
    huboCambios = true;
  }
  if (huboCambios) archivo.writeAsStringSync('${lineas.join('\n')}\n');
  return huboCambios;
}
