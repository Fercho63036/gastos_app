/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/********************************* FEATURE **********************************/
import '../../constants/auth_constants.dart';
import '../../utils/auth_helpers.dart';
import 'campo_contrasena_widget.dart';

/****************** CAMPOS CONTRASENA CONFIRMACION WIDGET *******************/
class CamposContrasenaConfirmacionWidget extends StatelessWidget {
  final TextEditingController contrasenaController;
  final TextEditingController confirmacionController;
  final String etiquetaContrasena;
  final String etiquetaConfirmacion;

  const CamposContrasenaConfirmacionWidget({
    super.key,
    required this.contrasenaController,
    required this.confirmacionController,
    required this.etiquetaContrasena,
    required this.etiquetaConfirmacion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CampoContrasenaWidget(
          controller: contrasenaController,
          etiqueta: etiquetaContrasena,
          validator: (valor) => AuthHelpers.validarContrasena(
            valor,
            minimo: AuthConstants.longitudMinimaContrasenaRegistro,
          ),
        ),
        CampoContrasenaWidget(
          controller: confirmacionController,
          etiqueta: etiquetaConfirmacion,
          validator: (valor) =>
              AuthHelpers.validarConfirmacion(valor, contrasenaController.text),
        ),
      ],
    );
  }
}
