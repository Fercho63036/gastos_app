/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/********************************* FEATURE **********************************/
import '../constants/perfil_strings.dart';

class DatosUsuarioWidget extends StatelessWidget {
  /******************************** PROPIEDADES ********************************/
  final String? nombre;
  final String? correo;

  /******************************** CONSTRUCTOR ********************************/
  const DatosUsuarioWidget({super.key, this.nombre, this.correo});

  /************************************ BUILD ************************************/
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final nombreUsuario = nombre;

    return Column(
      children: [
        if (nombreUsuario != null && nombreUsuario.isNotEmpty) ...[
          Text(nombreUsuario, style: textTheme.headlineSmall),
          const SizedBox(height: AppDimensions.paddingXS),
        ],
        Text(
          correo ?? PerfilStrings.sinCorreo,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withValues(
              alpha: AppDimensions.opacidadInactivo,
            ),
          ),
        ),
      ],
    );
  }
}
