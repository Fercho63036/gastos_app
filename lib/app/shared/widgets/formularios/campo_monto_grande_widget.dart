import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/utils/monto_input_formatter.dart';

/// Tarjeta con un monto grande editable: "[prefijo] 25,00" y un subtítulo.
class CampoMontoGrandeWidget extends StatelessWidget {
  final String etiqueta;
  final String prefijo;
  final Color colorPrefijo;
  final TextEditingController controller;
  final String hint;
  final String? subtitulo;

  const CampoMontoGrandeWidget({
    super.key,
    required this.etiqueta,
    required this.prefijo,
    required this.colorPrefijo,
    required this.controller,
    required this.hint,
    this.subtitulo,
  });

  Widget _buildCampo(ColorScheme colorScheme) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: AppDimensions.anchoMinimoMonto,
      ),
      child: IntrinsicWidth(
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: const [MontoInputFormatter()],
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: AppDimensions.fontMontoGrande,
            fontWeight: FontWeight.w800,
          ),
          decoration: InputDecoration.collapsed(hintText: hint),
        ),
      ),
    );
  }

  Widget _buildFilaMonto(ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppDimensions.paddingM,
      children: [
        Text(
          prefijo,
          style: TextStyle(
            color: colorPrefijo,
            fontSize: AppDimensions.fontPrefijoMonto,
            fontWeight: FontWeight.w700,
          ),
        ),
        Flexible(child: _buildCampo(colorScheme)),
      ],
    );
  }

  TextStyle _buildEstiloSecundario(ColorScheme colorScheme) => TextStyle(
    color: colorScheme.onSurface.withValues(
      alpha: AppDimensions.opacidadResaltada,
    ),
    fontSize: AppDimensions.fontXS,
  );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textoSubtitulo = subtitulo;
    final estiloSecundario = _buildEstiloSecundario(colorScheme);

    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusTarjetaSaldo),
      ),
      child: Column(
        spacing: AppDimensions.paddingS,
        children: [
          Text(
            etiqueta,
            style: estiloSecundario.copyWith(
              fontSize: AppDimensions.fontS,
              fontWeight: FontWeight.w600,
            ),
          ),
          _buildFilaMonto(colorScheme),
          if (textoSubtitulo != null)
            Text(textoSubtitulo, style: estiloSecundario),
        ],
      ),
    );
  }
}
