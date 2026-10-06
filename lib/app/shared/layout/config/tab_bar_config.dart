/****************************** FLUTTER / DART ******************************/
import 'package:flutter/cupertino.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/routes/route_names.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/layout/constants/layout_strings.dart';
import 'package:gastos_app/app/shared/layout/models/tab_bar_model.dart';

class TabBarConfig {
  TabBarConfig._();

  static const List<TabBarItem> items = [
    TabBarItem(
      id: 'home',
      titulo: LayoutStrings.tabInicio,
      icono: CupertinoIcons.home,
      iconoActivo: CupertinoIcons.house_fill,
      ruta: RouteNames.home,
    ),
    TabBarItem(
      id: 'perfil',
      titulo: LayoutStrings.tabPerfil,
      icono: CupertinoIcons.person,
      iconoActivo: CupertinoIcons.person_fill,
      ruta: RouteNames.perfil,
    ),
  ];

  static int obtenerIndiceActivo(String rutaActual) {
    final exacto = items.indexWhere((item) => item.ruta == rutaActual);
    if (exacto >= 0) return exacto;

    final indices = List<int>.generate(items.length, (indice) => indice)
      ..sort((a, b) => items[b].ruta.length.compareTo(items[a].ruta.length));
    for (final indice in indices) {
      if (rutaActual.startsWith(items[indice].ruta)) return indice;
    }
    return 0;
  }
}
