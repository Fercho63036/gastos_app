/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/************************* TITULO SUBTITULO WIDGET **************************/
class TituloSubtituloWidget extends StatelessWidget {
  final String? titulo;
  final String? subtitulo;
  final TextStyle estiloTitulo;
  final double tamanoSubtitulo;

  const TituloSubtituloWidget({
    super.key,
    this.titulo,
    this.subtitulo,
    this.estiloTitulo = const TextStyle(fontWeight: FontWeight.w700),
    this.tamanoSubtitulo = AppDimensions.fontXS,
  });

  @override
  Widget build(BuildContext context) {
    final textoTitulo = titulo;
    final textoSubtitulo = subtitulo;
    final colorSecundario = Theme.of(
      context,
    ).colorScheme.onSurface.withValues(alpha: AppDimensions.opacidadResaltada);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppDimensions.paddingXXS,
      children: [
        if (textoTitulo != null) Text(textoTitulo, style: estiloTitulo),
        if (textoSubtitulo != null)
          Text(
            textoSubtitulo,
            style: TextStyle(color: colorSecundario, fontSize: tamanoSubtitulo),
          ),
      ],
    );
  }
}
