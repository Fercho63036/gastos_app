/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

class BotonContornoIconoWidget extends StatelessWidget {
  /******************************** PROPIEDADES ********************************/
  final String etiqueta;
  final IconData icono;
  final VoidCallback onPressed;

  /******************************** CONSTRUCTOR ********************************/
  const BotonContornoIconoWidget({
    super.key,
    required this.etiqueta,
    required this.icono,
    required this.onPressed,
  });

  /************************************ BUILD ************************************/
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icono, size: AppDimensions.iconS),
      label: Text(etiqueta),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(AppDimensions.alturaBotonAccion),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingS,
          vertical: AppDimensions.paddingXS,
        ),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        textStyle: const TextStyle(
          fontSize: AppDimensions.fontM,
          fontWeight: FontWeight.w700,
        ),
        side: BorderSide(
          color: colorScheme.primary.withValues(
            alpha: AppDimensions.opacidadInactivo,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusTarjeta),
        ),
      ),
    );
  }
}
