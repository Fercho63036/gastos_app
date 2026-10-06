/****************************** FLUTTER / DART ******************************/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/layout/constants/layout_strings.dart';
import 'package:gastos_app/app/shared/layout/utils/cerrar_sesion_helpers.dart';
import 'package:gastos_app/app/shared/layout/utils/menu_colores.dart';
import 'package:gastos_app/app/shared/layout/widgets/drawer/menu_chevron_widget.dart';
import 'package:gastos_app/app/shared/layout/widgets/drawer/menu_list_tile_widget.dart';

class CerrarSesionTileWidget extends StatelessWidget {
  const CerrarSesionTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingS,
        vertical: AppDimensions.paddingXXS,
      ),
      child: MenuListTileWidget(
        icono: CupertinoIcons.square_arrow_left,
        titulo: LayoutStrings.cerrarSesion,
        color: MenuColores.inactivo(colorScheme),
        trailing: const MenuChevronWidget(),
        onTap: () => CerrarSesionHelpers.manejarCerrarSesion(
          context,
          popAntes: true,
        ),
      ),
    );
  }
}
