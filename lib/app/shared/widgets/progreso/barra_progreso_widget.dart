/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/************************** BARRA PROGRESO WIDGET ***************************/
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
