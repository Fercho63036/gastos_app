/****************************** FLUTTER / DART ******************************/
import 'package:flutter/cupertino.dart';

/********************************* FEATURE **********************************/
import '../../constants/auth_strings.dart';
import '../../utils/auth_helpers.dart';
import 'campo_texto_auth_widget.dart';

class CampoNombreWidget extends StatelessWidget {
  final TextEditingController controller;

  const CampoNombreWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CampoTextoAuthWidget(
      controller: controller,
      etiqueta: AuthStrings.nombreCompleto,
      icono: CupertinoIcons.person,
      validator: AuthHelpers.validarNombre,
    );
  }
}
