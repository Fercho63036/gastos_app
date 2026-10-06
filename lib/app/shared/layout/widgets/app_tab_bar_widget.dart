/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/layout/config/tab_bar_config.dart';
import 'package:gastos_app/app/shared/layout/widgets/tab_bar_item_widget.dart';

class AppTabBarWidget extends StatelessWidget {
  final String rutaActual;
  final ValueChanged<String> onTabSeleccionado;

  const AppTabBarWidget({
    super.key,
    required this.rutaActual,
    required this.onTabSeleccionado,
  });

  BoxDecoration _decoracion(ThemeData theme, bool esModoOscuro) {
    final colorScheme = theme.colorScheme;
    return BoxDecoration(
      color: theme.bottomAppBarTheme.color ?? colorScheme.surface,
      border: Border(
        top: BorderSide(
          color: colorScheme.outlineVariant,
          width: AppDimensions.bordeDelgado,
        ),
      ),
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(AppDimensions.radiusXL),
      ),
      boxShadow: [
        BoxShadow(
          color: colorScheme.shadow.withValues(
            alpha: esModoOscuro
                ? AppDimensions.opacidadSombraOscura
                : AppDimensions.opacidadMuySutil,
          ),
          blurRadius: AppDimensions.desenfoqueSombra,
          offset: const Offset(0, AppDimensions.desplazamientoSombra),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final esModoOscuro = theme.brightness == Brightness.dark;
    final indiceActivo = TabBarConfig.obtenerIndiceActivo(rutaActual);
    const items = TabBarConfig.items;

    return Container(
      decoration: _decoracion(theme, esModoOscuro),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: AppDimensions.alturaTabBar,
          child: Row(
            children: [
              for (var indice = 0; indice < items.length; indice++)
                Expanded(
                  child: TabBarItemWidget(
                    item: items[indice],
                    estaActivo: indice == indiceActivo,
                    onTap: () => onTabSeleccionado(items[indice].ruta),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
