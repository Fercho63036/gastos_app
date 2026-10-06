/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/errors/app_exception.dart';
import 'package:gastos_app/app/core/routes/route_names.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/utils/mensajes_helpers.dart';
import 'package:gastos_app/app/shared/widgets/botones/boton_primario_widget.dart';
import 'package:gastos_app/app/shared/widgets/campos/campo_correo_widget.dart';

/********************************* FEATURE **********************************/
import '../../constants/auth_constants.dart';
import '../../constants/auth_strings.dart';
import '../../models/credenciales_model.dart';
import '../../providers/auth_provider.dart';
import '../../utils/auth_helpers.dart';
import '../campos/campo_contrasena_widget.dart';

class FormularioLoginWidget extends StatefulWidget {
  const FormularioLoginWidget({super.key});

  @override
  State<FormularioLoginWidget> createState() => _FormularioLoginWidgetState();
}

class _FormularioLoginWidgetState extends State<FormularioLoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();

  @override
  void dispose() {
    _correoController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  Future<void> _manejarIniciarSesion() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final credenciales = CredencialesModel(
      correo: _correoController.text.trim(),
      contrasena: _contrasenaController.text,
    );
    try {
      await context.read<AuthProvider>().iniciarSesion(credenciales);
      if (mounted) context.go(RouteNames.home);
    } on AppException catch (error) {
      if (mounted) MensajesHelpers.mostrar(context, error.mensaje);
    } on Exception catch (error) {
      debugPrint('[Login] $error');
      if (mounted) MensajesHelpers.mostrar(context, AuthStrings.ocurrioError);
    }
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
          CampoContrasenaWidget(
            controller: _contrasenaController,
            etiqueta: AuthStrings.contrasena,
            validator: (valor) => AuthHelpers.validarContrasena(
              valor,
              minimo: AuthConstants.longitudMinimaContrasenaLogin,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingS),
          BotonPrimarioWidget(
            texto: AuthStrings.iniciarSesion,
            cargando: cargando,
            onPressed: _manejarIniciarSesion,
          ),
        ],
      ),
    );
  }
}
