/****************************** FLUTTER / DART ******************************/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:provider/provider.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/theme/app_colores.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/layout/providers/theme_provider.dart';

/********************************* FEATURE **********************************/
import '../../constants/auth_strings.dart';

class BotonTemaAuthWidget extends StatelessWidget {
  const BotonTemaAuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final temaProvider = context.watch<ThemeProvider>();

    return Material(
      color: AppColores.negro.withValues(
        alpha: AppDimensions.opacidadSombraOscura,
      ),
      shape: const CircleBorder(),
      child: IconButton(
        tooltip: AuthStrings.cambiarTema,
        iconSize: AppDimensions.iconS,
        color: AppColores.blanco,
        icon: Icon(
          temaProvider.temaOscuro
              ? CupertinoIcons.sun_max_fill
              : CupertinoIcons.moon_fill,
        ),
        onPressed: temaProvider.cambiarTema,
      ),
    );
  }
}
