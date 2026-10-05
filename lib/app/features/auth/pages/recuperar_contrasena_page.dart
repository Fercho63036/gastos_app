import 'package:flutter/material.dart';

import '../constants/auth_strings.dart';
import '../widgets/estructura/auth_encabezado_widget.dart';
import '../widgets/estructura/auth_tarjeta_layout_widget.dart';
import '../widgets/estructura/volver_login_widget.dart';
import '../widgets/formularios/formulario_recuperar_widget.dart';

class RecuperarContrasenaPage extends StatelessWidget {
  const RecuperarContrasenaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthTarjetaLayoutWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthEncabezadoWidget(
            titulo: AuthStrings.recuperarTitulo,
            subtitulo: AuthStrings.recuperarSubtitulo,
          ),
          FormularioRecuperarWidget(),
          VolverLoginWidget(),
        ],
      ),
    );
  }
}
