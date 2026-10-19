// ********************************** FEATURE **********************************
import 'banner_regla.dart';
import 'codigo_util.dart';
import 'incumplimiento.dart';

// ******************************** CONSTANTES *********************************
const int emojiDesde = 0x1F300;
const int emojiHasta = 0x1FAFF;
const int simboloDesde = 0x2600;
const int simboloHasta = 0x27BF;
const int selectorEmoji = 0xFE0F;

// **************************** REVISAR COMENTARIOS ****************************
List<Incumplimiento> revisarComentarios(String ruta, List<String> lineas) {
  final List<Incumplimiento> encontrados = <Incumplimiento>[];
  for (int indice = 0; indice < lineas.length; indice++) {
    final String mensaje = _mensajeDe(lineas[indice]);
    if (mensaje.isNotEmpty) {
      encontrados.add(Incumplimiento(ruta, indice + 1, mensaje));
    }
  }
  return encontrados;
}

// ******************************** MENSAJE DE *********************************
String _mensajeDe(String linea) {
  if (_tieneEmoji(linea)) return 'Emoji no permitido';
  if (esBannerValido(linea.trim())) return '';
  final String sinCadenas = quitarCadenas(linea);
  if (sinCadenas.contains('//') || sinCadenas.contains('/*')) {
    return 'Comentario que no es un banner de 80 columnas centrado';
  }
  return '';
}

// ******************************** TIENE EMOJI ********************************
bool _tieneEmoji(String linea) {
  return linea.runes.any(
    (int caracter) =>
        (caracter >= emojiDesde && caracter <= emojiHasta) ||
        (caracter >= simboloDesde && caracter <= simboloHasta) ||
        caracter == selectorEmoji,
  );
}
