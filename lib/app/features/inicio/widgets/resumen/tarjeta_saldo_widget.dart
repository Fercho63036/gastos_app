/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/constants/formato_strings.dart';
import 'package:gastos_app/app/core/theme/app_colores.dart';
import 'package:gastos_app/app/core/utils/formato_helpers.dart';
import 'package:gastos_app/app/core/utils/responsive_helper.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/models/resumen_mes_model.dart';
import 'package:gastos_app/app/shared/widgets/progreso/barra_progreso_widget.dart';

/********************************* FEATURE **********************************/
import '../../constants/inicio_strings.dart';
import '../../utils/inicio_helpers.dart';
import 'fila_gastable_piso_widget.dart';
import 'monto_inicial_widget.dart';

class TarjetaSaldoWidget extends StatelessWidget {
  /******************************** PROPIEDADES ********************************/
  final ResumenMes resumen;
  final VoidCallback? onEditarPiso;

  /******************************** CONSTRUCTOR ********************************/
  const TarjetaSaldoWidget({
    super.key,
    required this.resumen,
    this.onEditarPiso,
  });

  /********************************* DECORACION *********************************/
  static final BoxDecoration _decoracion = BoxDecoration(
    color: AppColores.tarjetaSaldo,
    borderRadius: BorderRadius.circular(AppDimensions.radiusTarjetaSaldo),
  );

  /******************************** ESTILO BASE *********************************/
  TextStyle? _buildEstiloBase(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColores.textoTarjetaSaldo,
      fontWeight: FontWeight.w600,
    );
  }

  /******************************** ESTILO SALDO *********************************/
  TextStyle? _buildEstiloSaldo(BuildContext context, TextStyle? estiloBase) {
    return estiloBase?.copyWith(
      fontSize: ResponsiveHelper.fontSize(context, AppDimensions.fontSaldo),
      fontWeight: FontWeight.w800,
    );
  }

  /****************************** TEXTO PORCENTAJE *******************************/
  String _buildTextoPorcentaje() {
    final porcentaje = InicioHelpers.porcentajeDisponible(resumen);
    return '$porcentaje${FormatoStrings.porcentaje} '
        '${InicioStrings.gastableDisponible}';
  }

  /************************************ BUILD ************************************/
  @override
  Widget build(BuildContext context) {
    final estiloBase = _buildEstiloBase(context);

    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingSM),
      decoration: _decoracion,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppDimensions.paddingS,
        children: [
          Text(InicioStrings.teQuedaEsteMes, style: estiloBase),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              FormatoHelpers.formatearMonto(resumen.saldoCentavos),
              style: _buildEstiloSaldo(context, estiloBase),
            ),
          ),
          MontoInicialWidget(
            montoInicialCentavos: resumen.montoInicialCentavos,
            estilo: estiloBase,
          ),
          FilaGastablePisoWidget(
            resumen: resumen,
            estilo: estiloBase,
            onEditarPiso: onEditarPiso,
          ),
          BarraProgresoWidget(
            fraccion: InicioHelpers.fraccionDisponible(resumen),
            color: AppColores.textoTarjetaSaldo,
            colorFondo: AppColores.pistaProgresoSaldo,
          ),
          Text(
            _buildTextoPorcentaje(),
            style: estiloBase?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
