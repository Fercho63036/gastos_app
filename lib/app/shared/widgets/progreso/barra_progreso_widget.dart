import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/// Barra de progreso en forma de píldora; sin colores usa los del tema.
class BarraProgresoWidget extends StatelessWidget {
  final double fraccion;
  final Color? color;
  final Color? colorFondo;

  const BarraProgresoWidget({
    super.key,
    required this.fraccion,
    this.color,
    this.colorFondo,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.radiusPildora),
      child: LinearProgressIndicator(
        value: fraccion,
        minHeight: AppDimensions.alturaBarraProgreso,
        backgroundColor: colorFondo,
        color: color,
      ),
    );
  }
}
