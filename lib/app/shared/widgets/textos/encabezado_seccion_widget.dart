import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/// Título pequeño y espaciado para separar secciones de una lista.
class EncabezadoSeccionWidget extends StatelessWidget {
  final String texto;

  const EncabezadoSeccionWidget({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimensions.paddingS,
        bottom: AppDimensions.paddingXS,
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: colorScheme.onSurface.withValues(
            alpha: AppDimensions.opacidadResaltada,
          ),
          fontSize: AppDimensions.fontS,
          fontWeight: FontWeight.w700,
          letterSpacing: AppDimensions.espaciadoLetraSeccion,
        ),
      ),
    );
  }
}
