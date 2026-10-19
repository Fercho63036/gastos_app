// *********************************** DART ************************************
import 'dart:io';
// ********************************** FEATURE **********************************
import 'incumplimiento.dart';

// ******************************** CONSTANTES *********************************
const int maxLineasArchivo = 200;
final RegExp _patronNombreArchivo = RegExp(r'^[a-z][a-z0-9_]*\.dart$');

// ****************************** REVISAR ARCHIVO ******************************
List<Incumplimiento> revisarArchivo(String ruta, List<String> lineas) {
  final List<Incumplimiento> encontrados = <Incumplimiento>[];
  final String nombre = ruta.split(Platform.pathSeparator).last;
  if (!_patronNombreArchivo.hasMatch(nombre)) {
    encontrados.add(
      Incumplimiento(ruta, 1, 'Nombre de archivo no es snake_case'),
    );
  }
  if (lineas.length > maxLineasArchivo) {
    encontrados.add(
      Incumplimiento(
        ruta,
        maxLineasArchivo + 1,
        'Archivo de ${lineas.length} líneas (máx $maxLineasArchivo)',
      ),
    );
  }
  return encontrados;
}
