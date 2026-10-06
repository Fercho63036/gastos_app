/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/widgets/botones/boton_contorno_icono_widget.dart';

/********************************* FEATURE **********************************/
import '../../constants/inicio_strings.dart';

class BotonesAccionWidget extends StatelessWidget {
  final VoidCallback onGasto;
  final VoidCallback onEntrada;

  const BotonesAccionWidget({
    super.key,
    required this.onGasto,
    required this.onEntrada,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppDimensions.paddingM,
      children: [
        Expanded(
          child: BotonContornoIconoWidget(
            etiqueta: InicioStrings.gasto,
            icono: Icons.remove_circle_outline,
            onPressed: onGasto,
          ),
        ),
        Expanded(
          child: BotonContornoIconoWidget(
            etiqueta: InicioStrings.entrada,
            icono: Icons.add_circle_outline,
            onPressed: onEntrada,
          ),
        ),
      ],
    );
  }
}
