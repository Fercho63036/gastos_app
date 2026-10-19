// ********************************** FEATURE **********************************
import 'banner_regla.dart';
import 'incumplimiento.dart';

// ******************************** CONSTANTES *********************************
const String nombrePaquete = 'gastos_app';
const List<String> ordenGrupos = <String>[
  'DART',
  'FLUTTER',
  'LIBRERIAS',
  'CORE',
  'SHARED',
  'FEATURE',
];
final RegExp _patronImport = RegExp(
  r'''^(?:import|export)\s+['"]([^'"]+)['"]''',
);

// ****************************** GRUPO DE IMPORT ******************************
String grupoDeImport(String uri) {
  if (uri.startsWith('dart:')) return 'DART';
  if (uri.startsWith('package:flutter/')) return 'FLUTTER';
  if (uri.startsWith('package:$nombrePaquete/app/core/')) return 'CORE';
  if (uri.startsWith('package:$nombrePaquete/app/shared/')) return 'SHARED';
  if (uri.startsWith('package:$nombrePaquete/') || !uri.contains(':')) {
    return 'FEATURE';
  }
  return 'LIBRERIAS';
}

// ****************************** REVISAR IMPORTS ******************************
List<Incumplimiento> revisarImports(String ruta, List<String> lineas) {
  final List<int> indices = <int>[
    for (int indice = 0; indice < lineas.length; indice++)
      if (_patronImport.hasMatch(lineas[indice])) indice,
  ];
  if (indices.isEmpty) return const <Incumplimiento>[];
  final List<Incumplimiento> encontrados = <Incumplimiento>[];
  _revisarHuecos(ruta, lineas, indices, encontrados);
  _revisarGrupos(ruta, lineas, indices, encontrados);
  return encontrados;
}

// ********************************** URI DE ***********************************
String _uriDe(String linea) => _patronImport.firstMatch(linea)?.group(1) ?? '';

// ****************************** REVISAR HUECOS *******************************
void _revisarHuecos(
  String ruta,
  List<String> lineas,
  List<int> indices,
  List<Incumplimiento> encontrados,
) {
  for (int indice = indices.first; indice <= indices.last; indice++) {
    final String mensaje = _mensajeHueco(lineas[indice]);
    if (mensaje.isEmpty) continue;
    encontrados.add(Incumplimiento(ruta, indice + 1, mensaje));
  }
}

// ******************************* MENSAJE HUECO *******************************
String _mensajeHueco(String linea) {
  if (linea.trim().isEmpty) return 'Línea en blanco dentro de los imports';
  final bool esValida =
      linea.startsWith(' ') ||
      _patronImport.hasMatch(linea) ||
      esBannerValido(linea.trim());
  return esValida ? '' : 'Solo imports y banners dentro del bloque de imports';
}

// ****************************** REVISAR GRUPOS *******************************
void _revisarGrupos(
  String ruta,
  List<String> lineas,
  List<int> indices,
  List<Incumplimiento> encontrados,
) {
  String grupoPrevio = '';
  String uriPrevio = '';
  for (final int indice in indices) {
    final String uri = _uriDe(lineas[indice]);
    final String grupo = grupoDeImport(uri);
    final String mensaje = grupo == grupoPrevio
        ? _mensajeAlfabetico(uri, uriPrevio)
        : _mensajeGrupo(lineas, indice, grupo, grupoPrevio);
    if (uri.contains('../../')) {
      encontrados.add(
        Incumplimiento(ruta, indice + 1, 'Usar package: en vez de ../../'),
      );
    }
    if (mensaje.isNotEmpty) {
      encontrados.add(Incumplimiento(ruta, indice + 1, mensaje));
    }
    grupoPrevio = grupo;
    uriPrevio = uri;
  }
}

// **************************** MENSAJE ALFABETICO *****************************
String _mensajeAlfabetico(String uri, String uriPrevio) {
  return uri.compareTo(uriPrevio) < 0
      ? 'Imports del grupo no están en orden alfabético'
      : '';
}

// ******************************* MENSAJE GRUPO *******************************
String _mensajeGrupo(
  List<String> lineas,
  int indice,
  String grupo,
  String grupoPrevio,
) {
  if (ordenGrupos.indexOf(grupo) < ordenGrupos.indexOf(grupoPrevio)) {
    return 'Grupo $grupo fuera de orden (${ordenGrupos.join(', ')})';
  }
  final String anterior = indice == 0 ? '' : lineas[indice - 1].trim();
  return anterior == generarBanner(grupo) ? '' : 'Falta el banner $grupo';
}
