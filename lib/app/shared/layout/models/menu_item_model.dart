import 'package:flutter/widgets.dart';

enum TipoMenuItem { item, seccion, expandible }

class MenuItem {
  final String id;
  final String titulo;
  final IconData? icono;
  final String? ruta;
  final List<MenuItem> subItems;
  final TipoMenuItem tipo;

  const MenuItem({
    required this.id,
    required this.titulo,
    this.icono,
    this.ruta,
    this.subItems = const [],
    this.tipo = TipoMenuItem.item,
  });

  bool get esSeccion => tipo == TipoMenuItem.seccion;
  bool get esExpandible => tipo == TipoMenuItem.expandible;
}
