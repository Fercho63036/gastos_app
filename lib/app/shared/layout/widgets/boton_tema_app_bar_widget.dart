/****************************** FLUTTER / DART ******************************/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:provider/provider.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/layout/constants/layout_strings.dart';
import 'package:gastos_app/app/shared/layout/providers/theme_provider.dart';

class BotonTemaAppBarWidget extends StatelessWidget {
  const BotonTemaAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final temaProvider = context.watch<ThemeProvider>();
    final esModoOscuro = temaProvider.temaOscuro;

    return IconButton(
      icon: Icon(esModoOscuro ? CupertinoIcons.sun_max : CupertinoIcons.moon),
      iconSize: AppDimensions.iconM,
      tooltip: esModoOscuro
          ? LayoutStrings.modoClaro
          : LayoutStrings.modoOscuro,
      onPressed: temaProvider.cambiarTema,
    );
  }
}
