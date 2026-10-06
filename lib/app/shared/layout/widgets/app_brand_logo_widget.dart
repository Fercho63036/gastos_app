/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/config/app_config.dart';
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

class AppBrandLogoWidget extends StatelessWidget {
  final double width;
  final double height;

  const AppBrandLogoWidget({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final esModoOscuro = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      child: Image.asset(
        esModoOscuro ? AppConfig.logoOscuro : AppConfig.logoClaro,
        width: width,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}
