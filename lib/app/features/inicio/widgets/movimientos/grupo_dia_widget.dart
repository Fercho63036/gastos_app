import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/utils/formato_helpers.dart';

import 'package:gastos_app/app/shared/models/grupo_dia_model.dart';
import 'package:gastos_app/app/shared/widgets/textos/encabezado_seccion_widget.dart';

import '../../models/movimiento_model.dart';
import 'tarjeta_movimiento_widget.dart';

class GrupoDiaWidget extends StatelessWidget {
  final GrupoDia<Movimiento> grupo;

  const GrupoDiaWidget({super.key, required this.grupo});

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
            TarjetaMovimientoWidget(movimiento: movimiento),
        ],
      ),
    );
  }
}
