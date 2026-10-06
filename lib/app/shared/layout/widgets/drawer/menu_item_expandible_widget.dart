/****************************** FLUTTER / DART ******************************/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/constants/app_duraciones.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/layout/config/menu_config.dart';
import 'package:gastos_app/app/shared/layout/models/menu_item_model.dart';
import 'package:gastos_app/app/shared/layout/utils/menu_colores.dart';
import 'package:gastos_app/app/shared/layout/widgets/drawer/menu_chevron_widget.dart';
import 'package:gastos_app/app/shared/layout/widgets/drawer/menu_item_tile_widget.dart';
import 'package:gastos_app/app/shared/layout/widgets/drawer/menu_list_tile_widget.dart';

class MenuItemExpandibleWidget extends StatelessWidget {
  final MenuItem item;
  final String rutaActual;
  final bool estaExpandido;
  final VoidCallback onToggle;

  const MenuItemExpandibleWidget({
    super.key,
    required this.item,
    required this.rutaActual,
    required this.estaExpandido,
    required this.onToggle,
  });

  Widget _buildCabecera(ColorScheme colorScheme, bool subActivo) {
    return MenuListTileWidget(
      icono: item.icono ?? MenuConfig.iconoPorDefecto,
      titulo: item.titulo,
      color: MenuColores.texto(colorScheme, activo: subActivo),
      resaltado: subActivo,
      onTap: onToggle,
      trailing: AnimatedRotation(
        turns: estaExpandido
            ? AppDimensions.rotacionChevronExpandido
            : AppDimensions.rotacionChevronColapsado,
        duration: AppDuraciones.animacionNormal,
        child: const MenuChevronWidget(icono: CupertinoIcons.chevron_down),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final subActivo = item.subItems.any((sub) => sub.ruta == rutaActual);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingS,
            vertical: AppDimensions.paddingXXS,
          ),
          child: _buildCabecera(colorScheme, subActivo),
        ),
        AnimatedCrossFade(
          duration: AppDuraciones.animacionNormal,
          crossFadeState: estaExpandido
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: _SubItemsWidget(item: item, rutaActual: rutaActual),
          secondChild: const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _SubItemsWidget extends StatelessWidget {
  final MenuItem item;
  final String rutaActual;

  const _SubItemsWidget({required this.item, required this.rutaActual});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppDimensions.paddingM),
      child: Column(
        children: [
          for (final sub in item.subItems)
            MenuItemTileWidget(item: sub, rutaActual: rutaActual),
        ],
      ),
    );
  }
}
