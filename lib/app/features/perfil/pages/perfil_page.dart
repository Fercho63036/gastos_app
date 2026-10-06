/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:provider/provider.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/utils/responsive_helper.dart';

/********************************* FEATURE **********************************/
import 'package:gastos_app/app/features/auth/providers/auth_provider.dart';
import '../widgets/acciones_perfil_widget.dart';
import '../widgets/avatar_iniciales_widget.dart';
import '../widgets/boton_cerrar_sesion_widget.dart';
import '../widgets/datos_usuario_widget.dart';

class PerfilPage extends StatelessWidget {
  /******************************** CONSTRUCTOR ********************************/
  const PerfilPage({super.key});

  /************************************ BUILD ************************************/
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return SingleChildScrollView(
      padding: ResponsiveHelper.paddingAll(context),
      child: Column(
        children: [
          const SizedBox(height: AppDimensions.paddingL),
          AvatarInicialesWidget(
            nombre: authProvider.nombreUsuario,
            correo: authProvider.correoUsuario,
          ),
          const SizedBox(height: AppDimensions.paddingM),
          DatosUsuarioWidget(
            nombre: authProvider.nombreUsuario,
            correo: authProvider.correoUsuario,
          ),
          const SizedBox(height: AppDimensions.paddingXL),
          const AccionesPerfilWidget(),
          const SizedBox(height: AppDimensions.paddingXXL),
          const BotonCerrarSesionWidget(),
        ],
      ),
    );
  }
}
