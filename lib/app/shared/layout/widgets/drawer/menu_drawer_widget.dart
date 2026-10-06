/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/layout/config/menu_config.dart';
import 'package:gastos_app/app/shared/layout/models/menu_item_model.dart';
import 'package:gastos_app/app/shared/layout/widgets/drawer/cerrar_sesion_tile_widget.dart';
import 'package:gastos_app/app/shared/layout/widgets/drawer/drawer_footer_widget.dart';
import 'package:gastos_app/app/shared/layout/widgets/drawer/drawer_header_widget.dart';
import 'package:gastos_app/app/shared/layout/widgets/drawer/menu_item_expandible_widget.dart';
import 'package:gastos_app/app/shared/layout/widgets/drawer/menu_item_tile_widget.dart';
import 'package:gastos_app/app/shared/layout/widgets/drawer/menu_seccion_header_widget.dart';

class MenuDrawerWidget extends StatefulWidget {
  final String rutaActual;

  const MenuDrawerWidget({super.key, required this.rutaActual});

  @override
  State<MenuDrawerWidget> createState() => _MenuDrawerWidgetState();
}

class _MenuDrawerWidgetState extends State<MenuDrawerWidget> {
  final Map<String, bool> _expandidos = {};

  void _alternarExpandido(String id) {
    setState(() => _expandidos[id] = !(_expandidos[id] ?? false));
  }

  Widget _buildItem(MenuItem item) {
    if (item.esSeccion) return MenuSeccionHeaderWidget(titulo: item.titulo);
    if (item.esExpandible) {
      return MenuItemExpandibleWidget(
        item: item,
        rutaActual: widget.rutaActual,
        estaExpandido: _expandidos[item.id] ?? false,
        onToggle: () => _alternarExpandido(item.id),
      );
    }
    return MenuItemTileWidget(item: item, rutaActual: widget.rutaActual);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeaderWidget(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: AppDimensions.paddingSM),
              children: [
                ...MenuConfig.items.map(_buildItem),
                const Divider(height: AppDimensions.alturaDivisor),
                const CerrarSesionTileWidget(),
              ],
            ),
          ),
          const DrawerFooterWidget(),
        ],
      ),
    );
  }
}
