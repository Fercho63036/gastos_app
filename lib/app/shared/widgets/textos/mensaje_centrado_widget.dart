import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/utils/responsive_helper.dart';

/// Mensaje centrado a pantalla completa (errores, estados vacíos).
class MensajeCentradoWidget extends StatelessWidget {
  final String mensaje;

  const MensajeCentradoWidget({super.key, required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: ResponsiveHelper.paddingAll(context),
        child: Text(mensaje, textAlign: TextAlign.center),
      ),
    );
  }
}
