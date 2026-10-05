import 'package:flutter/cupertino.dart';

import 'package:gastos_app/app/core/routes/route_names.dart';
import 'package:gastos_app/app/shared/layout/constants/layout_strings.dart';
import 'package:gastos_app/app/shared/layout/models/menu_item_model.dart';

/// Menú estático del Drawer. Para agregar una pantalla: registra su ruta en
/// `RouteNames`/`AppRouter` y añade aquí su item (o un `expandible` con
/// `subItems` para agrupar varias).
class MenuConfig {
  MenuConfig._();

  static const IconData iconoPorDefecto = CupertinoIcons.circle;

  static const List<MenuItem> items = [
    MenuItem(
      id: 'seccion_gastos',
      titulo: LayoutStrings.seccionGastos,
      tipo: TipoMenuItem.seccion,
    ),
    MenuItem(
      id: 'lista_gastos',
      titulo: LayoutStrings.menuListaGastos,
      icono: CupertinoIcons.list_bullet,
      ruta: RouteNames.home,
    ),
    MenuItem(
      id: 'iniciar_mes',
      titulo: LayoutStrings.menuIniciarMes,
      icono: CupertinoIcons.calendar_badge_plus,
      ruta: RouteNames.iniciarMes,
    ),
    MenuItem(
      id: 'seccion_cuenta',
      titulo: LayoutStrings.seccionCuenta,
      tipo: TipoMenuItem.seccion,
    ),
    MenuItem(
      id: 'perfil',
      titulo: LayoutStrings.menuPerfil,
      icono: CupertinoIcons.person_crop_circle,
      ruta: RouteNames.perfil,
    ),
  ];
}
