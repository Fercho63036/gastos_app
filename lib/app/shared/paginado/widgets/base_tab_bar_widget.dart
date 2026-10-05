import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/shared/paginado/models/base_tab_model.dart';
import 'package:gastos_app/app/shared/paginado/widgets/base_tab_item_widget.dart';

class BaseTabBarWidget<T> extends StatelessWidget {
  final List<BaseTab<T>> tabs;
  final int indiceSeleccionado;
  final ValueChanged<int> onTabChanged;
  final Widget? widgetFinal;

  const BaseTabBarWidget({
    super.key,
    required this.tabs,
    required this.indiceSeleccionado,
    required this.onTabChanged,
    this.widgetFinal,
  });

  List<Widget> _buildItems() {
    return [
      for (int indice = 0; indice < tabs.length; indice++) ...[
        BaseTabItemWidget(
          label: tabs[indice].label,
          icon: tabs[indice].icon,
          seleccionado: indiceSeleccionado == indice,
          onTap: () => onTabChanged(indice),
        ),
        if (indice < tabs.length - 1)
          const SizedBox(width: AppDimensions.paddingS),
      ],
    ];
  }

  BoxDecoration _buildDecoracion(ThemeData theme) {
    return BoxDecoration(
      color: theme.scaffoldBackgroundColor,
      border: Border(
        bottom: BorderSide(
          color: theme.colorScheme.onSurface.withValues(
            alpha: AppDimensions.opacidadBordeSutil,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final trailing = widgetFinal;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSM,
        vertical: AppDimensions.paddingS,
      ),
      decoration: _buildDecoracion(Theme.of(context)),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: _buildItems()),
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppDimensions.paddingBuscadorSuperior),
            trailing,
          ],
        ],
      ),
    );
  }
}
