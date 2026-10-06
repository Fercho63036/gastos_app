/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/config/app_config.dart';
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

class DrawerFooterWidget extends StatelessWidget {
  const DrawerFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Text(
          AppConfig.appName,
          style: TextStyle(
            fontSize: AppDimensions.fontS,
            color: colorScheme.onSurface.withValues(
              alpha: AppDimensions.opacidadInactivo,
            ),
          ),
        ),
      ),
    );
  }
}
