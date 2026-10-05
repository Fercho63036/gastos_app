import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

class MenuSeccionHeaderWidget extends StatelessWidget {
  final String titulo;

  const MenuSeccionHeaderWidget({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.paddingM,
        AppDimensions.paddingM,
        AppDimensions.paddingM,
        AppDimensions.paddingXS,
      ),
      child: Text(
        titulo.toUpperCase(),
        style: TextStyle(
          fontSize: AppDimensions.fontXS,
          fontWeight: FontWeight.w600,
          letterSpacing: AppDimensions.espaciadoLetraSeccion,
          color: colorScheme.onSurface.withValues(
            alpha: AppDimensions.opacidadSecundaria,
          ),
        ),
      ),
    );
  }
}
