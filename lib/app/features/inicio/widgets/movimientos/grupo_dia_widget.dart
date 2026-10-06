/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/utils/formato_helpers.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/models/grupo_dia_model.dart';
import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/widgets/textos/encabezado_seccion_widget.dart';

/********************************* FEATURE **********************************/
import 'tarjeta_movimiento_widget.dart';

class GrupoDiaWidget extends StatelessWidget {
  final GrupoDia<Movimiento> grupo;
  final ValueChanged<Movimiento> onSeleccionar;

  const GrupoDiaWidget({
    super.key,
    required this.grupo,
    required this.onSeleccionar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingSM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppDimensions.paddingSM,
        children: [
          EncabezadoSeccionWidget(
            texto: FormatoHelpers.formatearEncabezadoDia(
              grupo.fecha,
              DateTime.now(),
            ),
          ),
          for (final movimiento in grupo.items)
            TarjetaMovimientoWidget(
              movimiento: movimiento,
              onTap: () => onSeleccionar(movimiento),
            ),
        ],
      ),
    );
  }
}
