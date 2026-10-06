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

  Widget _buildValor(
    String etiqueta,
    int montoCentavos,
    CrossAxisAlignment alineacion,
  ) {
    final monto = FormatoHelpers.formatearMonto(montoCentavos);
    return Column(
      crossAxisAlignment: alineacion,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          etiqueta,
          style: estilo?.copyWith(fontWeight: FontWeight.w500),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          monto,
          style: estilo,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildValor(
            InicioStrings.gastable,
            resumen.gastableCentavos,
            CrossAxisAlignment.start,
          ),
        ),
        Expanded(
          child: _buildValor(
            InicioStrings.gastado,
            resumen.gastadoCentavos,
            CrossAxisAlignment.center,
          ),
        ),
        Expanded(
          child: _buildValor(
            InicioStrings.piso,
            resumen.pisoCentavos,
            CrossAxisAlignment.end,
          ),
        ),
      ],
    );
  }
}
