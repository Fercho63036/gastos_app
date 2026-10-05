import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

import 'package:gastos_app/app/shared/constants/comun_strings.dart';
import 'package:gastos_app/app/shared/utils/snackbar_helpers.dart';
import 'package:gastos_app/app/shared/widgets/botones/boton_contorno_icono_widget.dart';

import '../../constants/inicio_strings.dart';

class BotonesAccionWidget extends StatelessWidget {
  const BotonesAccionWidget({super.key});

  void _mostrarProximamente(BuildContext context) =>
      SnackbarHelpers.mostrar(context, ComunStrings.proximamente);

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppDimensions.paddingM,
      children: [
        Expanded(
          child: BotonContornoIconoWidget(
            etiqueta: InicioStrings.gasto,
            icono: Icons.remove_circle_outline,
            onPressed: () => _mostrarProximamente(context),
          ),
        ),
        Expanded(
          child: BotonContornoIconoWidget(
            etiqueta: InicioStrings.entrada,
            icono: Icons.add_circle_outline,
            onPressed: () => _mostrarProximamente(context),
          ),
        ),
      ],
    );
  }
}
