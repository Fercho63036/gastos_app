/****************************** FLUTTER / DART ******************************/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/routes/route_names.dart';

/********************************* FEATURE **********************************/
import 'package:gastos_app/app/features/auth/providers/auth_provider.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/layout/constants/layout_strings.dart';
import 'package:gastos_app/app/shared/layout/widgets/drawer/dialogo_cerrar_sesion_widget.dart';

class BotonCerrarSesionWidget extends StatelessWidget {
  /******************************** CONSTRUCTOR ********************************/
  const BotonCerrarSesionWidget({super.key});

  /****************************** MANEJAR CERRAR SESION ******************************/
  Future<void> _manejarCerrarSesion(BuildContext context) async {
    final authProvider = context.read<AuthProvider>();
    final confirmar = await showCupertinoDialog<bool>(
      context: context,
      builder: (_) => const DialogoCerrarSesionWidget(),
    );
    if (confirmar != true || !context.mounted) return;

    await authProvider.logout();
    if (context.mounted) context.go(RouteNames.auth);
  }

  /************************************ BUILD ************************************/
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _manejarCerrarSesion(context),
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
