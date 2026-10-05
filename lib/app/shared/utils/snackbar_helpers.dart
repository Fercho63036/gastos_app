import 'package:flutter/material.dart';

class SnackbarHelpers {
  SnackbarHelpers._();

  /// Reemplaza el snackbar visible para no encolar mensajes repetidos.
  static void mostrar(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mensaje)));
  }
}
