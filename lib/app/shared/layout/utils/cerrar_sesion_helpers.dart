/****************************** FLUTTER / DART ******************************/
import 'package:flutter/cupertino.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/routes/route_names.dart';

/********************************* FEATURE **********************************/
import 'package:gastos_app/app/features/auth/providers/auth_provider.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/layout/widgets/drawer/dialogo_cerrar_sesion_widget.dart';

class CerrarSesionHelpers {
  CerrarSesionHelpers._();

  /*************************** MANEJAR CERRAR SESION ***************************/
  static Future<void> manejarCerrarSesion(
    BuildContext context, {
    bool popAntes = false,
  }) async {
    final authProvider = context.read<AuthProvider>();
    final confirmar = await showCupertinoDialog<bool>(
      context: context,
      builder: (_) => const DialogoCerrarSesionWidget(),
    );
    if (confirmar != true || !context.mounted) return;
    if (popAntes) Navigator.of(context).pop();
    await authProvider.logout();
    if (context.mounted) context.go(RouteNames.auth);
  }
}
