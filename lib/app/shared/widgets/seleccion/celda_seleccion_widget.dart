/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/constants/app_duraciones.dart';

/************************** CELDA SELECCION WIDGET **************************/
class CeldaSeleccionWidget extends StatelessWidget {
  final IconData icono;
  final String etiqueta;
  final bool seleccionado;
  final VoidCallback onTap;

  const CeldaSeleccionWidget({
    super.key,
    required this.icono,
    required this.etiqueta,
    required this.seleccionado,
    required this.onTap,
  });

  BoxDecoration _buildDecoracion(ColorScheme colorScheme) {
    return BoxDecoration(
      color: seleccionado ? colorScheme.primary : colorScheme.surface,
      borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      border: Border.all(
        color: colorScheme.primary.withValues(
          alpha: AppDimensions.opacidadInactivo,
        ),
        width: AppDimensions.bordeDelgado,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = seleccionado ? colorScheme.onPrimary : colorScheme.onSurface;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppDuraciones.animacionNormal,
        decoration: _buildDecoracion(colorScheme),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppDimensions.paddingS,
          children: [
            Icon(icono, color: color, size: AppDimensions.iconM),
            Text(
              etiqueta,
              style: TextStyle(
                color: color,
                fontSize: AppDimensions.fontS,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
