import 'package:flutter/cupertino.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/routes/route_names.dart';

import 'package:gastos_app/app/shared/widgets/botones/boton_primario_widget.dart';

import '../../constants/auth_strings.dart';
import '../../models/credenciales_model.dart';
import '../../providers/auth_provider.dart';
import '../../utils/auth_helpers.dart';
import '../../utils/auth_mensajes.dart';
import '../campos/campo_correo_widget.dart';
import '../campos/campo_texto_auth_widget.dart';
import '../campos/campos_contrasena_confirmacion_widget.dart';

class FormularioRegistroWidget extends StatefulWidget {
  const FormularioRegistroWidget({super.key});

  @override
  State<FormularioRegistroWidget> createState() =>
      _FormularioRegistroWidgetState();
}

class _FormularioRegistroWidgetState extends State<FormularioRegistroWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _confirmarController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _contrasenaController.dispose();
    _confirmarController.dispose();
    super.dispose();
  }

  Future<void> _manejarRegistro() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final credenciales = CredencialesModel(
      correo: _correoController.text.trim(),
      contrasena: _contrasenaController.text,
    );
    await context.read<AuthProvider>().registrarUsuario(
      nombre: _nombreController.text.trim(),
      credenciales: credenciales,
    );
    if (!mounted) return;
    AuthMensajes.mostrar(context, AuthStrings.registroExitoso);
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
          CampoTextoAuthWidget(
            controller: _nombreController,
            etiqueta: AuthStrings.nombreCompleto,
            icono: CupertinoIcons.person,
            validator: AuthHelpers.validarNombre,
          ),
          CampoCorreoWidget(controller: _correoController),
          CamposContrasenaConfirmacionWidget(
            contrasenaController: _contrasenaController,
            confirmacionController: _confirmarController,
            etiquetaContrasena: AuthStrings.contrasena,
            etiquetaConfirmacion: AuthStrings.confirmarContrasena,
          ),
          const SizedBox(height: AppDimensions.paddingS),
          BotonPrimarioWidget(
            texto: AuthStrings.registrar,
            cargando: cargando,
            onPressed: _manejarRegistro,
          ),
        ],
      ),
    );
  }
}
