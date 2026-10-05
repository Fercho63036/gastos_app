import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

import '../textos/titulo_subtitulo_widget.dart';
import 'tarjeta_superficie_widget.dart';

/// Nota informativa en tarjeta: ícono, título opcional y texto.
class NotaIconoWidget extends StatelessWidget {
  final IconData icono;
  final String texto;
  final String? titulo;

  const NotaIconoWidget({
    super.key,
    required this.icono,
    required this.texto,
    this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    final colorIcono = Theme.of(
      context,
    ).colorScheme.onSurface.withValues(alpha: AppDimensions.opacidadResaltada);

    return TarjetaSuperficieWidget(
      child: Row(
        spacing: AppDimensions.paddingSM,
        children: [
          Icon(icono, color: colorIcono, size: AppDimensions.iconS),
          Expanded(
            child: TituloSubtituloWidget(
              titulo: titulo,
              subtitulo: texto,
              tamanoSubtitulo: AppDimensions.fontS,
            ),
          ),
        ],
      ),
    );
  }
}
