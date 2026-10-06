/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/utils/formato_helpers.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/models/resumen_mes_model.dart';

/********************************* FEATURE **********************************/
import '../../constants/inicio_strings.dart';

class FilaGastablePisoWidget extends StatelessWidget {
  final ResumenMes resumen;
  final TextStyle? estilo;

  const FilaGastablePisoWidget({super.key, required this.resumen, this.estilo});

  @override
  Widget build(BuildContext context) {
    final gastable = FormatoHelpers.formatearMonto(resumen.gastableCentavos);
    final piso = FormatoHelpers.formatearMonto(resumen.pisoCentavos);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${InicioStrings.gastable}: $gastable', style: estilo),
        Text('${InicioStrings.piso}: $piso', style: estilo),
      ],
    );
  }
}
