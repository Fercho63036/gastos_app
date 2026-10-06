/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:go_router/go_router.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/routes/route_names.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/widgets/botones/boton_contorno_icono_widget.dart';

/********************************* FEATURE **********************************/
import '../constants/perfil_strings.dart';

class AccionesPerfilWidget extends StatelessWidget {
  /******************************** CONSTRUCTOR ********************************/
  const AccionesPerfilWidget({super.key});

  /********************************** BOTON ANCHO **********************************/
  Widget _botonAncho({
    required String etiqueta,
    required IconData icono,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: BotonContornoIconoWidget(
        etiqueta: etiqueta,
        icono: icono,
        onPressed: onPressed,
      ),
    );
  }

  /************************************ BUILD ************************************/
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppDimensions.paddingS,
      children: [
        _botonAncho(
          etiqueta: PerfilStrings.editarDatos,
          icono: Icons.edit_outlined,
          onPressed: () => context.push(RouteNames.editarPerfil),
        ),
        _botonAncho(
          etiqueta: PerfilStrings.cambiarContrasena,
          icono: Icons.lock_reset_outlined,
          onPressed: () => context.push(RouteNames.recuperarPassword),
        ),
      ],
    );
  }
}
