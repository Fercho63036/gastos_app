// *********************************** DART ************************************
import 'dart:io';

// ************************* RECOLECTAR ARCHIVOS DART **************************
List<File> recolectarArchivosDart(List<String> rutas) {
  final Set<String> vistos = <String>{};
  final List<File> archivos = <File>[];
  for (final String ruta in rutas) {
    for (final File archivo in _archivosEn(ruta)) {
      if (vistos.add(archivo.path)) archivos.add(archivo);
    }
  }
  archivos.sort(
    (File primero, File segundo) => primero.path.compareTo(segundo.path),
  );
  return archivos;
}

// ******************************** ARCHIVOS EN ********************************
List<File> _archivosEn(String ruta) {
  return switch (FileSystemEntity.typeSync(ruta)) {
    FileSystemEntityType.directory => _dartEnCarpeta(ruta),
    FileSystemEntityType.file => <File>[File(ruta)],
    _ => <File>[],
  };
}

// ****************************** DART EN CARPETA ******************************
List<File> _dartEnCarpeta(String ruta) {
  return Directory(ruta)
      .listSync(recursive: true)
      .whereType<File>()
      .where((File archivo) => archivo.path.endsWith('.dart'))
      .toList();
}
