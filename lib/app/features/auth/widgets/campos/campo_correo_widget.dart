/****************************** FLUTTER / DART ******************************/
import 'package:flutter/cupertino.dart';

/********************************* FEATURE **********************************/
import '../../constants/auth_strings.dart';
import '../../utils/auth_helpers.dart';
import 'campo_texto_auth_widget.dart';

class CampoCorreoWidget extends StatelessWidget {
  final TextEditingController controller;

  const CampoCorreoWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CampoTextoAuthWidget(
      controller: controller,
      etiqueta: AuthStrings.correoElectronico,
      icono: CupertinoIcons.mail,
      keyboardType: TextInputType.emailAddress,
      validator: AuthHelpers.validarCorreo,
    );
  }
}
