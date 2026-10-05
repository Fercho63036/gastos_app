import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/constants/formato_strings.dart';

/// Etiqueta arriba ("Motivo (opcional)"), el campo y una ayuda opcional abajo.
class CampoEtiquetadoWidget extends StatelessWidget {
  final String etiqueta;
  final String? etiquetaSecundaria;
  final String? ayuda;
  final Widget child;

  const CampoEtiquetadoWidget({
    super.key,
    required this.etiqueta,
    required this.child,
    this.etiquetaSecundaria,
    this.ayuda,
  });

  TextSpan _buildEtiqueta() {
    final secundaria = etiquetaSecundaria;
    return TextSpan(
      text: etiqueta,
      style: const TextStyle(fontWeight: FontWeight.w700),
      children: [
        if (secundaria != null)
          TextSpan(
            text: '${FormatoStrings.espacio}$secundaria',
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textoAyuda = ayuda;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppDimensions.paddingS,
      children: [
        Text.rich(
          _buildEtiqueta(),
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: AppDimensions.fontS,
          ),
        ),
        child,
        if (textoAyuda != null)
          Text(
            textoAyuda,
            style: TextStyle(
              color: colorScheme.onSurface.withValues(
                alpha: AppDimensions.opacidadResaltada,
              ),
              fontSize: AppDimensions.fontXS,
            ),
          ),
      ],
    );
  }
}
