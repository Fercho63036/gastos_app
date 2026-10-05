import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/shared/layout/config/menu_config.dart';
import 'package:gastos_app/app/shared/layout/models/menu_item_model.dart';
import 'package:gastos_app/app/shared/layout/utils/menu_colores.dart';
import 'package:gastos_app/app/shared/layout/widgets/drawer/menu_chevron_widget.dart';
import 'package:gastos_app/app/shared/layout/widgets/drawer/menu_list_tile_widget.dart';

class MenuItemTileWidget extends StatelessWidget {
  final MenuItem item;
  final String rutaActual;

  const MenuItemTileWidget({
    super.key,
    required this.item,
    required this.rutaActual,
  });

  void _navegar(BuildContext context, String ruta) {
    Navigator.of(context).pop();
    context.go(ruta);
  }

  BoxDecoration? _decoracionActiva(ColorScheme colorScheme, bool estaActivo) {
    if (!estaActivo) return null;
    return BoxDecoration(
      color: MenuColores.fondoActivo(colorScheme),
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      border: Border(
        left: BorderSide(
          color: colorScheme.primary,
          width: AppDimensions.bordeIndicadorMenu,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final estaActivo = rutaActual == item.ruta;
    final ruta = item.ruta;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingS,
        vertical: AppDimensions.paddingXXS,
      ),
      decoration: _decoracionActiva(colorScheme, estaActivo),
      child: MenuListTileWidget(
        icono: item.icono ?? MenuConfig.iconoPorDefecto,
        titulo: item.titulo,
        color: MenuColores.texto(colorScheme, activo: estaActivo),
        resaltado: estaActivo,
        trailing: const MenuChevronWidget(),
        onTap: ruta == null ? null : () => _navegar(context, ruta),
      ),
    );
  }
}
