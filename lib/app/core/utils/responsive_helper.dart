import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

class ResponsiveHelper {
  ResponsiveHelper._();

  static const double breakpointTablet = 600.0;
  static const double breakpointDesktop = 1024.0;

  static const double _escalaTablet = 1.15;
  static const double _escalaDesktop = 1.3;

  static const int columnasMovil = 1;
  static const int columnasTablet = 2;
  static const int columnasDesktop = 3;

  static double anchoPantalla(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  static double altoPantalla(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  static bool isMobile(BuildContext context) =>
      anchoPantalla(context) < breakpointTablet;

  static bool isTablet(BuildContext context) {
    final screenWidth = anchoPantalla(context);
    return screenWidth >= breakpointTablet && screenWidth < breakpointDesktop;
  }

  static bool isDesktop(BuildContext context) =>
      anchoPantalla(context) >= breakpointDesktop;

  static double _escala(BuildContext context) {
    if (isDesktop(context)) return _escalaDesktop;
    if (isTablet(context)) return _escalaTablet;
    return 1.0;
  }

  static double fontSize(BuildContext context, double base) =>
      base * _escala(context);

  static double spacing(BuildContext context, double base) =>
      base * _escala(context);

  static EdgeInsets paddingAll(BuildContext context) =>
      EdgeInsets.all(spacing(context, AppDimensions.paddingM));

  static EdgeInsets paddingHorizontal(BuildContext context) =>
      EdgeInsets.symmetric(
        horizontal: isMobile(context)
            ? AppDimensions.paddingXL
            : AppDimensions.paddingXXL,
      );

  static int columnCount(BuildContext context) {
    if (isDesktop(context)) return columnasDesktop;
    if (isTablet(context)) return columnasTablet;
    return columnasMovil;
  }

  static double fraccionAlto(BuildContext context, double fraccion) =>
      altoPantalla(context) * fraccion;
}
