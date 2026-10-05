import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/// Ícono dentro de un cuadro redondeado con fondo suave del color primario.
class IconoContenedorWidget extends StatelessWidget {
  final IconData icono;
  final Color color;
  final bool atenuado;

  const IconoContenedorWidget({
    super.key,
    required this.icono,
    required this.color,
    this.atenuado = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final colorIcono = atenuado
        ? colorScheme.onSurface.withValues(alpha: AppDimensions.opacidadAnulado)
        : color;

    return Container(
      width: AppDimensions.tamanoIconoCategoria,
      height: AppDimensions.tamanoIconoCategoria,
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(
          alpha: AppDimensions.opacidadPistaIcono,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Icon(icono, color: colorIcono, size: AppDimensions.iconL),
    );
  }
}
