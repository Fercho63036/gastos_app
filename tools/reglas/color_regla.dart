// ********************************** FEATURE **********************************
import 'codigo_util.dart';
import 'incumplimiento.dart';

// ******************************** CONSTANTES *********************************
const String carpetaTema = 'lib/app/core/theme/';
final RegExp _patronColor = RegExp(
  r'Color\(\s*0x|Color\.fromARGB|Color\.fromRGBO|'
  r'\bColors\.(?!transparent\b)\w+|CupertinoColors\.\w+',
);

// ****************************** REVISAR COLORES ******************************
List<Incumplimiento> revisarColores(String ruta, List<String> lineas) {
  final List<Incumplimiento> encontrados = <Incumplimiento>[];
  if (ruta.replaceAll('\\', '/').contains(carpetaTema)) return encontrados;
  for (int indice = 0; indice < lineas.length; indice++) {
    final String codigo = codigoSinComentario(lineas[indice]);
    final RegExpMatch? coincidencia = _patronColor.firstMatch(codigo);
    if (coincidencia == null) continue;
    encontrados.add(
      Incumplimiento(
        ruta,
        indice + 1,
        'Color fuera de AppColores: ${coincidencia.group(0)}',
      ),
    );
  }
  return encontrados;
}
