import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

class BotonContornoIconoWidget extends StatelessWidget {
  final String etiqueta;
  final IconData icono;
  final VoidCallback onPressed;

  const BotonContornoIconoWidget({
    super.key,
    required this.etiqueta,
    required this.icono,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icono, size: AppDimensions.iconM),
      label: Text(etiqueta),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(AppDimensions.alturaBotonAccion),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        textStyle: const TextStyle(
          fontSize: AppDimensions.fontL,
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
