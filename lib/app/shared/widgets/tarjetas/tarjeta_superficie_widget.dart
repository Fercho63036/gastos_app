import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/// Contenedor base con fondo de superficie y esquinas redondeadas.
class TarjetaSuperficieWidget extends StatelessWidget {
  final Widget child;

  const TarjetaSuperficieWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: child,
    );
  }
}
