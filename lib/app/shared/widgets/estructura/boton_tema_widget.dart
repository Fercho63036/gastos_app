/****************************** FLUTTER / DART ******************************/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:provider/provider.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/theme/app_colores.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/constants/formulario_strings.dart';
import 'package:gastos_app/app/shared/layout/providers/theme_provider.dart';

/********************************* FEATURE **********************************/
import 'circulo_fondo_widget.dart';

class BotonTemaWidget extends StatelessWidget {
  const BotonTemaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final temaProvider = context.watch<ThemeProvider>();

    return CirculoFondoWidget(
      child: IconButton(
        tooltip: FormularioStrings.cambiarTema,
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
