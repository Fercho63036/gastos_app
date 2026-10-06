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
  final VoidCallback? onEditarPiso;

  /******************************** CONSTRUCTOR ********************************/
  const FilaGastablePisoWidget({
    super.key,
    required this.resumen,
    this.estilo,
    this.onEditarPiso,
  });

  /***************************** BUILD MÉTRICA ****************************/
  Widget _buildMetrica({
    required String etiqueta,
    required int montoCentavos,
    required bool esEditableConPiso,
  }) {
    final monto = FormatoHelpers.formatearMonto(montoCentavos);
    final colorAtenuado = estilo?.color?.withValues(
      alpha: AppColores.opacidadTextoAtenuado,
    ) ?? Colors.black.withValues(
      alpha: AppColores.opacidadTextoAtenuado,
    );

    Widget contenido = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Etiqueta con ícono opcional
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: AppDimensions.paddingXS,
          children: [
            Flexible(
              child: Text(
                etiqueta,
                style: estilo?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorAtenuado,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (esEditableConPiso)
              Icon(
                Icons.edit,
                size: AppDimensions.tamanoIconoEditar,
                color: colorAtenuado,
              ),
          ],
        ),
        SizedBox(height: AppDimensions.paddingXS),
        // Monto
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            monto,
            style: estilo?.copyWith(fontWeight: FontWeight.w700),
            maxLines: 1,
          ),
        ),
      ],
    );

    // Si es editable (Piso), envolver en InkWell
    if (esEditableConPiso && onEditarPiso != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onEditarPiso,
          borderRadius: BorderRadius.circular(
            AppDimensions.radiusMetricaTarjeta,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingMetricaTarjeta),
            child: contenido,
          ),
        ),
      );
    }

    // Si no es editable, solo con fondo y padding
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMetricaTarjeta),
      decoration: BoxDecoration(
        color: AppColores.fondoMetricaTarjeta,
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusMetricaTarjeta,
        ),
      ),
      child: contenido,
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
            etiqueta: InicioStrings.gastable,
            montoCentavos: resumen.gastableCentavos,
            esEditableConPiso: false,
          ),
        ),
        Expanded(
          child: _buildMetrica(
            etiqueta: InicioStrings.gastado,
            montoCentavos: resumen.gastadoCentavos,
            esEditableConPiso: false,
          ),
        ),
        Expanded(
          child: _buildMetrica(
            etiqueta: InicioStrings.piso,
            montoCentavos: resumen.pisoCentavos,
            esEditableConPiso: true,
          ),
        ),
      ],
    );
  }
}
