/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/theme/app_colores.dart';

/**************************** CIRCULO FONDO WIDGET ****************************/
class CirculoFondoWidget extends StatelessWidget {
  final Widget child;

  const CirculoFondoWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColores.negro.withValues(
        alpha: AppDimensions.opacidadSombraOscura,
      ),
      shape: const CircleBorder(),
      child: child,
    );
  }
}
