import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/routes/route_names.dart';
import 'package:gastos_app/app/features/auth/providers/auth_provider.dart';
import 'package:gastos_app/app/shared/layout/constants/layout_strings.dart';
import 'package:gastos_app/app/shared/layout/utils/menu_colores.dart';
import 'package:gastos_app/app/shared/layout/widgets/drawer/dialogo_cerrar_sesion_widget.dart';
import 'package:gastos_app/app/shared/layout/widgets/drawer/menu_chevron_widget.dart';
import 'package:gastos_app/app/shared/layout/widgets/drawer/menu_list_tile_widget.dart';

class CerrarSesionTileWidget extends StatelessWidget {
  const CerrarSesionTileWidget({super.key});

  Future<void> _manejarCerrarSesion(BuildContext context) async {
    final authProvider = context.read<AuthProvider>();
    final confirmar = await showCupertinoDialog<bool>(
      context: context,
      builder: (_) => const DialogoCerrarSesionWidget(),
    );
    if (confirmar != true || !context.mounted) return;

    Navigator.of(context).pop();
    await authProvider.logout();
    if (context.mounted) context.go(RouteNames.auth);
  }

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
        onTap: () => _manejarCerrarSesion(context),
      ),
    );
  }
}
