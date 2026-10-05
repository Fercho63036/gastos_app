import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/constants/app_duraciones.dart';

class AuthMensajes {
  AuthMensajes._();

  static void mostrar(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        behavior: SnackBarBehavior.floating,
        duration: AppDuraciones.snackBar,
        margin: const EdgeInsets.all(AppDimensions.paddingL),
      ),
    );
  }
}
