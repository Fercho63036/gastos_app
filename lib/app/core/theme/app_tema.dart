import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/theme/app_colores.dart';

class AppTema {
  AppTema._();

  static ThemeData get temaClaro {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColores.primario,
      primary: AppColores.primario,
      secondary: AppColores.secundario,
      tertiary: AppColores.exito,
      surface: AppColores.superficieClara,
      error: AppColores.peligro,
    );
    return _construirTema(
      colorScheme: colorScheme,
      fondo: AppColores.fondoClaro,
      borde: AppColores.bordeClaro,
    );
  }

  static ThemeData get temaOscuro {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColores.primario,
      brightness: Brightness.dark,
      primary: AppColores.primarioOscuro,
      secondary: AppColores.secundarioOscuro,
      tertiary: AppColores.exitoOscuro,
      surface: AppColores.superficieOscura,
      error: AppColores.peligro,
    );
    return _construirTema(
      colorScheme: colorScheme,
      fondo: AppColores.fondoOscuro,
      borde: AppColores.bordeOscuro,
    );
  }

  static ThemeData _construirTema({
    required ColorScheme colorScheme,
    required Color fondo,
    required Color borde,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: fondo,
      cardColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColores.barra,
        foregroundColor: AppColores.textoBarra,
        iconTheme: const IconThemeData(color: AppColores.textoBarra),
        actionsIconTheme: const IconThemeData(color: AppColores.textoBarra),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: AppDimensions.elevacionAppBar,
        scrolledUnderElevation: AppDimensions.elevacionAppBar,
      ),
      bottomAppBarTheme: BottomAppBarThemeData(color: AppColores.barra),
      drawerTheme: DrawerThemeData(backgroundColor: colorScheme.surface),
      inputDecorationTheme: _construirInputs(colorScheme, borde),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(AppDimensions.alturaBoton),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
        ),
      ),
    );
  }

  static InputDecorationTheme _construirInputs(
    ColorScheme colorScheme,
    Color borde,
  ) {
    OutlineInputBorder bordeCon(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      borderSide: BorderSide(color: color),
    );

    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSM,
        vertical: AppDimensions.paddingM,
      ),
      enabledBorder: bordeCon(borde),
      focusedBorder: bordeCon(colorScheme.primary),
      errorBorder: bordeCon(colorScheme.error),
      focusedErrorBorder: bordeCon(colorScheme.error),
    );
  }
}
