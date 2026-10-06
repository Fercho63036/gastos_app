/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/utils/responsive_helper.dart';

/************************* MENSAJE CENTRADO WIDGET **************************/
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
