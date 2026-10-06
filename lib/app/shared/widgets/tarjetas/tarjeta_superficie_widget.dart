/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/************************ TARJETA SUPERFICIE WIDGET *************************/
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
