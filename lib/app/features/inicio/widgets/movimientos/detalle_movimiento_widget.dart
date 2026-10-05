import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/constants/formato_strings.dart';
import 'package:gastos_app/app/core/theme/app_colores.dart';
import 'package:gastos_app/app/core/utils/formato_helpers.dart';

import 'package:gastos_app/app/shared/constants/dominio_strings.dart';
import 'package:gastos_app/app/shared/models/movimiento_model.dart';

/// Título y "Categoría · hora" (más "Anulado" si corresponde).
class DetalleMovimientoWidget extends StatelessWidget {
  final Movimiento movimiento;
  final TextStyle? estiloTitulo;

  const DetalleMovimientoWidget({
    super.key,
    required this.movimiento,
    this.estiloTitulo,
  });

  TextSpan _buildSubtitulo() {
    final subtitulo =
        '${movimiento.categoria.nombre}${FormatoStrings.separadorPunto}'
        '${FormatoHelpers.formatearHora(movimiento.fecha)}';
    return TextSpan(
      text: subtitulo,
      children: [
        if (movimiento.anulado)
          const TextSpan(
            text: '${FormatoStrings.separadorPunto}${DominioStrings.anulado}',
            style: TextStyle(
              color: AppColores.alertaAnulado,
              fontWeight: FontWeight.w700,
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final estiloSubtitulo = TextStyle(
      color: colorScheme.onSurface.withValues(
        alpha: AppDimensions.opacidadSecundaria,
      ),
      fontSize: AppDimensions.fontS,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppDimensions.paddingXS,
      children: [
        Text(movimiento.titulo, style: estiloTitulo),
        Text.rich(_buildSubtitulo(), style: estiloSubtitulo),
      ],
    );
  }
}
