/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/errors/app_exception.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/utils/mensajes_helpers.dart';
import 'package:gastos_app/app/shared/widgets/botones/boton_primario_widget.dart';
import 'package:gastos_app/app/shared/widgets/campos/campo_correo_widget.dart';
import 'package:gastos_app/app/shared/widgets/campos/campo_nombre_widget.dart';

/********************************* FEATURE **********************************/
import '../../../auth/providers/auth_provider.dart';
import '../../constants/perfil_strings.dart';

class FormularioEditarPerfilWidget extends StatefulWidget {
  const FormularioEditarPerfilWidget({super.key});

  @override
  State<FormularioEditarPerfilWidget> createState() =>
      _FormularioEditarPerfilWidgetState();
}

class _FormularioEditarPerfilWidgetState
    extends State<FormularioEditarPerfilWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreController;
  late final TextEditingController _correoController;

  @override
  void initState() {
    super.initState();
    final authProvider = context.read<AuthProvider>();
    _nombreController = TextEditingController(
      text: authProvider.nombreUsuario ?? '',
    );
    _correoController = TextEditingController(
      text: authProvider.correoUsuario ?? '',
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  Future<void> _manejarGuardar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    try {
      await context.read<AuthProvider>().actualizarDatos(
        nombre: _nombreController.text.trim(),
        correo: _correoController.text.trim(),
      );
    } on AppException catch (error) {
      if (mounted) MensajesHelpers.mostrar(context, error.mensaje);
      return;
    }
    if (!mounted) return;
    MensajesHelpers.mostrar(context, PerfilStrings.datosActualizados);
    context.pop();
  }

  Widget _buildBotonGuardar(bool cargando) {
    return BotonPrimarioWidget(
      texto: PerfilStrings.guardarCambios,
      cargando: cargando,
      onPressed: _manejarGuardar,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cargando = context.watch<AuthProvider>().cargando;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CampoNombreWidget(controller: _nombreController),
          CampoCorreoWidget(controller: _correoController),
          const SizedBox(height: AppDimensions.paddingS),
          _buildBotonGuardar(cargando),
        ],
      ),
    );
  }
}
