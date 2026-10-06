/****************************** FLUTTER / DART ******************************/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/layout/constants/layout_strings.dart';
import 'package:gastos_app/app/shared/layout/utils/cerrar_sesion_helpers.dart';

class BotonCerrarSesionWidget extends StatelessWidget {
  /******************************** CONSTRUCTOR ********************************/
  const BotonCerrarSesionWidget({super.key});

  /************************************ BUILD ************************************/
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => CerrarSesionHelpers.manejarCerrarSesion(context),
        icon: Icon(CupertinoIcons.square_arrow_left, size: AppDimensions.iconS),
        label: const Text(LayoutStrings.cerrarSesion),
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.error,
          side: BorderSide(color: colorScheme.error),
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingSM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusTarjeta),
          ),
        ),
      ),
    );
  }
}
