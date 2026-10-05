import 'package:flutter/widgets.dart';

class TabBarItem {
  final String id;
  final String titulo;
  final IconData icono;
  final IconData iconoActivo;
  final String ruta;

  const TabBarItem({
    required this.id,
    required this.titulo,
    required this.icono,
    required this.iconoActivo,
    required this.ruta,
  });
}
