/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/********************************** SHARED **********************************/
import '../../models/fila_resumen_model.dart';

class FilaResumenWidget extends StatelessWidget {
  final FilaResumen fila;

  const FilaResumenWidget({super.key, required this.fila});

  TextStyle _buildEstilo(ColorScheme colorScheme) {
    return switch (fila.estilo) {
      EstiloFilaResumen.normal => TextStyle(
        color: colorScheme.onSurface.withValues(
          alpha: AppDimensions.opacidadResaltada,
        ),
        fontSize: AppDimensions.fontS,
      ),
      EstiloFilaResumen.destacado => TextStyle(
        color: colorScheme.onSurface,
        fontSize: AppDimensions.fontM,
        fontWeight: FontWeight.w800,
      ),
      EstiloFilaResumen.acento => TextStyle(
        color: colorScheme.primary,
        fontSize: AppDimensions.fontS,
        fontWeight: FontWeight.w700,
      ),
      EstiloFilaResumen.positivo => TextStyle(
        color: colorScheme.tertiary,
        fontSize: AppDimensions.fontS,
        fontWeight: FontWeight.w700,
      ),
      EstiloFilaResumen.negativo => TextStyle(
        color: colorScheme.error,
        fontSize: AppDimensions.fontS,
        fontWeight: FontWeight.w700,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final estilo = _buildEstilo(Theme.of(context).colorScheme);

    return Row(
      spacing: AppDimensions.paddingS,
      children: [
        Expanded(child: Text(fila.etiqueta, style: estilo)),
        Text(fila.valor, style: estilo),
      ],
    );
  }
}
