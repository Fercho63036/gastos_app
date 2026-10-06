/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

class SnackbarHelpers {
  SnackbarHelpers._();

  /********************************* MOSTRAR **********************************/
  static void mostrar(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mensaje)));
  }
}
