/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/theme/app_colores.dart';
import 'package:gastos_app/app/core/utils/formato_helpers.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/models/resumen_mes_model.dart';

/********************************* FEATURE **********************************/
import '../../constants/inicio_strings.dart';

class FilaGastablePisoWidget extends StatelessWidget {
  /******************************** PROPIEDADES ********************************/
  final ResumenMes resumen;
  final TextStyle? estilo;

  /******************************** CONSTRUCTOR ********************************/
  const FilaGastablePisoWidget({
    super.key,
    required this.resumen,
    this.estilo,
  });

  /***************************** BUILD METRICA ****************************/
  Widget _buildMetrica({
    required String etiqueta,
    required int montoCentavos,
  }) {
    final colorAtenuado = estilo?.color?.withValues(
      alpha: AppColores.opacidadTextoAtenuado,
    );

    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMetricaTarjeta),
      decoration: BoxDecoration(
        color: AppColores.fondoMetricaTarjeta,
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusMetricaTarjeta,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            etiqueta,
            style: estilo?.copyWith(
              fontWeight: FontWeight.w500,
              color: colorAtenuado,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppDimensions.paddingXS),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              FormatoHelpers.formatearMonto(montoCentavos),
              style: estilo?.copyWith(fontWeight: FontWeight.w700),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  /************************************ BUILD ************************************/
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppDimensions.espacioMetricas,
      children: [
        Expanded(
          child: _buildMetrica(
            etiqueta: InicioStrings.gastado,
            montoCentavos: resumen.gastadoCentavos,
          ),
        ),
        Expanded(
          child: _buildMetrica(
            etiqueta: InicioStrings.piso,
            montoCentavos: resumen.pisoCentavos,
          ),
        ),
      ],
    );
  }
}
