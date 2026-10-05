import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

import '../../models/fila_resumen_model.dart';
import 'fila_resumen_widget.dart';

/// Tarjeta con borde y filas "etiqueta · valor" (p. ej. cálculo de saldo).
class TarjetaResumenWidget extends StatelessWidget {
  final List<FilaResumen> filas;

  const TarjetaResumenWidget({super.key, required this.filas});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final colorBorde = colorScheme.primary.withValues(
      alpha: AppDimensions.opacidadInactivo,
    );

    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(color: colorBorde),
      ),
      child: Column(
        spacing: AppDimensions.paddingS,
        children: [
          for (final fila in filas) ...[
            if (fila.divisorAntes)
              Divider(color: colorBorde, height: AppDimensions.alturaDivisor),
            FilaResumenWidget(fila: fila),
          ],
        ],
      ),
    );
  }
}
