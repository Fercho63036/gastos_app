/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:go_router/go_router.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/routes/route_names.dart';

/********************************* FEATURE **********************************/
import '../constants/auth_strings.dart';
import '../widgets/estructura/auth_encabezado_widget.dart';
import '../widgets/estructura/auth_tarjeta_layout_widget.dart';
import '../widgets/estructura/boton_crear_cuenta_widget.dart';
import '../widgets/estructura/separador_auth_widget.dart';
import '../widgets/formularios/formulario_login_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthTarjetaLayoutWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthEncabezadoWidget(
            titulo: AuthStrings.bienvenido,
            subtitulo: AuthStrings.iniciaSesion,
          ),
          const FormularioLoginWidget(),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => context.go(RouteNames.recuperarPassword),
              child: const Text(AuthStrings.olvidasteContrasena),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingS),
          const SeparadorAuthWidget(),
          const SizedBox(height: AppDimensions.paddingM),
          const BotonCrearCuentaWidget(),
        ],
      ),
    );
  }
}
