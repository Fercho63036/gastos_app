/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:go_router/go_router.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/routes/route_names.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/widgets/estructura/encabezado_formulario_widget.dart';
import 'package:gastos_app/app/shared/widgets/estructura/tarjeta_layout_widget.dart';

/********************************* FEATURE **********************************/
import '../constants/auth_strings.dart';
import '../widgets/estructura/volver_login_widget.dart';
import '../widgets/formularios/formulario_recuperar_widget.dart';

class RecuperarContrasenaPage extends StatelessWidget {
  const RecuperarContrasenaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TarjetaLayoutWidget(
      mostrarBotonVolver: true,
      onVolver: () => context.go(RouteNames.auth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EncabezadoFormularioWidget(
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
