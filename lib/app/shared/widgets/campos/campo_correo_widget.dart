/****************************** FLUTTER / DART ******************************/
import 'package:flutter/cupertino.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/constants/formulario_strings.dart';
import 'package:gastos_app/app/shared/utils/validadores_helpers.dart';

/********************************* FEATURE **********************************/
import 'campo_texto_base_widget.dart';

class CampoCorreoWidget extends StatelessWidget {
  final TextEditingController controller;

  const CampoCorreoWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CampoTextoBaseWidget(
      controller: controller,
      etiqueta: FormularioStrings.correoElectronico,
      icono: CupertinoIcons.mail,
      keyboardType: TextInputType.emailAddress,
      validator: ValidadoresHelpers.validarCorreo,
    );
  }
}
