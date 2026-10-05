import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/constants/app_duraciones.dart';

class BaseTabItemWidget extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool seleccionado;
  final VoidCallback onTap;

  const BaseTabItemWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.seleccionado,
    required this.onTap,
  });

  BoxDecoration _buildDecoracion(ColorScheme colorScheme) {
    final colorPrimario = colorScheme.primary;
    return BoxDecoration(
      color: seleccionado
          ? colorPrimario.withValues(alpha: AppDimensions.opacidadSeleccion)
          : colorScheme.surface,
      borderRadius: BorderRadius.circular(AppDimensions.radiusPildora),
      border: Border.all(
        color: seleccionado
            ? colorPrimario.withValues(alpha: AppDimensions.opacidadInactivo)
            : colorScheme.onSurface.withValues(
                alpha: AppDimensions.opacidadBordeTab,
              ),
        width: AppDimensions.bordeTab,
      ),
    );
  }

  Color _buildColorEtiqueta(ColorScheme colorScheme) {
    if (seleccionado) return colorScheme.primary;
    return colorScheme.onSurface.withValues(
      alpha: AppDimensions.opacidadSecundaria,
    );
  }

  Widget _buildContenido(Color colorEtiqueta) {
    final iconoTab = icon;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (iconoTab != null) ...[
          Icon(iconoTab, size: AppDimensions.iconXS, color: colorEtiqueta),
          const SizedBox(width: AppDimensions.paddingTabIcono),
        ],
        Text(
          label,
          style: TextStyle(
            color: colorEtiqueta,
            fontWeight: seleccionado ? FontWeight.w700 : FontWeight.w500,
            fontSize: AppDimensions.fontS,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppDuraciones.animacionNormal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingTabHorizontal,
          vertical: AppDimensions.paddingTabVertical,
        ),
        decoration: _buildDecoracion(colorScheme),
        child: _buildContenido(_buildColorEtiqueta(colorScheme)),
      ),
    );
  }
}
