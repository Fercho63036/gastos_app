import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

import 'package:gastos_app/app/shared/models/edicion_movimiento_model.dart';
import 'package:gastos_app/app/shared/utils/ediciones_helpers.dart';
import 'package:gastos_app/app/shared/widgets/listas/item_linea_tiempo_widget.dart';
import 'package:gastos_app/app/shared/widgets/textos/encabezado_seccion_widget.dart';

import '../../constants/movimientos_strings.dart';
import '../../utils/movimientos_helpers.dart';

/// Lista de cambios guardados; no se muestra si no hay ninguno.
class HistorialEdicionesWidget extends StatelessWidget {
  final List<EdicionMovimiento> ediciones;

  const HistorialEdicionesWidget({super.key, required this.ediciones});

  @override
  Widget build(BuildContext context) {
    if (ediciones.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppDimensions.paddingS,
      children: [
        const EncabezadoSeccionWidget(
          texto: MovimientosStrings.historialEdiciones,
        ),
        for (final edicion in ediciones)
          ItemLineaTiempoWidget(
            titulo: EdicionesHelpers.describir(edicion),
            subtitulo: MovimientosHelpers.fechaEdicion(edicion),
          ),
      ],
    );
  }
}
