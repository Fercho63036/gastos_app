import 'package:flutter/cupertino.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/routes/route_names.dart';

import '../../constants/auth_strings.dart';
import '../../models/credenciales_model.dart';
import '../../providers/auth_provider.dart';
import '../../utils/auth_mensajes.dart';
import '../campos/boton_primario_widget.dart';
import '../campos/campo_correo_widget.dart';
import '../campos/campos_contrasena_confirmacion_widget.dart';

class FormularioRecuperarWidget extends StatefulWidget {
  const FormularioRecuperarWidget({super.key});

  @override
  State<FormularioRecuperarWidget> createState() =>
      _FormularioRecuperarWidgetState();
}

class _FormularioRecuperarWidgetState extends State<FormularioRecuperarWidget> {
  final _formKey = GlobalKey<FormState>();
  final _correoController = TextEditingController();
  final _nuevaController = TextEditingController();
  final _repetirController = TextEditingController();

  @override
  void dispose() {
    _correoController.dispose();
    _nuevaController.dispose();
    _repetirController.dispose();
    super.dispose();
  }

  Future<void> _manejarRecuperar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final credenciales = CredencialesModel(
      correo: _correoController.text.trim(),
      contrasena: _nuevaController.text,
    );
    await context.read<AuthProvider>().recuperarContrasena(credenciales);
    if (!mounted) return;
    AuthMensajes.mostrar(context, AuthStrings.recuperarExitoso);
    context.go(RouteNames.auth);
  }

  @override
  Widget build(BuildContext context) {
    final cargando = context.watch<AuthProvider>().cargando;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CampoCorreoWidget(controller: _correoController),
          CamposContrasenaConfirmacionWidget(
            contrasenaController: _nuevaController,
            confirmacionController: _repetirController,
            etiquetaContrasena: AuthStrings.nuevaContrasena,
            etiquetaConfirmacion: AuthStrings.repetirContrasena,
          ),
          const SizedBox(height: AppDimensions.paddingS),
          BotonPrimarioWidget(
            texto: AuthStrings.cambiarContrasena,
            cargando: cargando,
            onPressed: _manejarRecuperar,
          ),
        ],
      ),
    );
  }
}
