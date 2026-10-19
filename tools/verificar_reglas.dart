// *********************************** DART ************************************
import 'dart:io';
// ********************************** FEATURE **********************************
import 'reglas/archivo_regla.dart';
import 'reglas/banner_regla.dart';
import 'reglas/color_regla.dart';
import 'reglas/comentario_regla.dart';
import 'reglas/import_regla.dart';
import 'reglas/incumplimiento.dart';
import 'reglas/metodo_regla.dart';
import 'reglas/recolector_archivos.dart';

// ******************************** CONSTANTES *********************************
const List<String> rutasPorDefecto = <String>['lib', 'test', 'tools'];
const List<String> rutasColores = <String>['lib'];
const String opcionBanner = '--banner';
const String opcionNormalizar = '--normalizar';
const String opcionColores = '--colores';

// *********************************** MAIN ************************************
void main(List<String> argumentos) {
  if (argumentos.isNotEmpty && argumentos.first == opcionBanner) {
    stdout.writeln(generarBanner(argumentos.skip(1).join(' ')));
    return;
  }
  final bool soloColores = argumentos.contains(opcionColores);
  final List<String> rutas = argumentos
      .where((String argumento) => !argumento.startsWith('--'))
      .toList();
  final List<String> rutasPorDefectoModo = soloColores
      ? rutasColores
      : rutasPorDefecto;
  final List<File> archivos = recolectarArchivosDart(
    rutas.isEmpty ? rutasPorDefectoModo : rutas,
  );
  if (argumentos.contains(opcionNormalizar)) _normalizar(archivos);
  final List<Incumplimiento> encontrados = <Incumplimiento>[
    for (final File archivo in archivos) ..._revisar(archivo, soloColores),
  ];
  _informar(encontrados, archivos.length);
}

// ******************************** NORMALIZAR *********************************
void _normalizar(List<File> archivos) {
  for (final File archivo in archivos) {
    if (normalizarArchivo(archivo)) {
      stdout.writeln('Normalizado: ${archivo.path}');
    }
  }
}

// ********************************** REVISAR **********************************
List<Incumplimiento> _revisar(File archivo, bool soloColores) {
  final String ruta = archivo.path;
  final List<String> lineas = archivo.readAsLinesSync();
  if (soloColores) return revisarColores(ruta, lineas);
  return <Incumplimiento>[
    ...revisarArchivo(ruta, lineas),
    ...revisarComentarios(ruta, lineas),
    ...revisarMetodos(ruta, lineas),
    ...revisarImports(ruta, lineas),
  ];
}

// ********************************* INFORMAR **********************************
void _informar(List<Incumplimiento> encontrados, int totalArchivos) {
  for (final Incumplimiento incumplimiento in encontrados) {
    stdout.writeln(incumplimiento);
  }
  stdout.writeln(
    '$totalArchivos archivos revisados, ${encontrados.length} incumplimientos',
  );
  if (encontrados.isNotEmpty) exitCode = 1;
}
