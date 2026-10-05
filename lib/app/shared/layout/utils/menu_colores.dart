import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/theme/app_colores.dart';

/// Colores compartidos por los items del Drawer (tile, expandible, logout).
class MenuColores {
  MenuColores._();

  static Color inactivo(ColorScheme colorScheme) =>
      colorScheme.onSurface.withValues(alpha: AppDimensions.opacidadSecundaria);

  static Color chevron(ColorScheme colorScheme) =>
      inactivo(colorScheme).withValues(alpha: AppDimensions.opacidadInactivo);

  static Color fondoActivo(ColorScheme colorScheme) =>
      colorScheme.primary.withValues(alpha: AppDimensions.opacidadSutil);

  static Color texto(ColorScheme colorScheme, {required bool activo}) =>
      activo ? colorScheme.primary : inactivo(colorScheme);

  /// La barra inferior es violeta en ambos modos; el `primary` no contrasta.
  static Color textoTab({required bool activo}) => activo
      ? AppColores.textoBarra
      : AppColores.textoBarra.withValues(
          alpha: AppDimensions.opacidadSecundaria,
        );
}
