/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/constants/app_duraciones.dart';

class ChipSeleccionWidget extends StatelessWidget {
  final String etiqueta;
  final bool seleccionado;
  final VoidCallback onTap;

  const ChipSeleccionWidget({
    super.key,
    required this.etiqueta,
    required this.seleccionado,
    required this.onTap,
  });

  /***************************** BUILD DECORACION *****************************/
  BoxDecoration _buildDecoracion(ColorScheme colorScheme) {
    return BoxDecoration(
      color: seleccionado ? colorScheme.onSurface : colorScheme.surface,
      borderRadius: BorderRadius.circular(AppDimensions.radiusPildora),
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

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppDuraciones.animacionNormal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingSM,
        ),
        decoration: _buildDecoracion(colorScheme),
        child: Text(
          etiqueta,
          style: TextStyle(
            color: seleccionado ? colorScheme.surface : colorScheme.onSurface,
            fontSize: AppDimensions.fontM,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
