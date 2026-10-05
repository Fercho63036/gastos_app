import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

import '../tarjetas/tarjeta_superficie_widget.dart';
import '../textos/titulo_subtitulo_widget.dart';

/// Ítem de historial: punto de color, título y subtítulo (p. ej. fecha).
class ItemLineaTiempoWidget extends StatelessWidget {
  final String titulo;
  final String subtitulo;

  const ItemLineaTiempoWidget({
    super.key,
    required this.titulo,
    required this.subtitulo,
  });

  @override
  Widget build(BuildContext context) {
    return TarjetaSuperficieWidget(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppDimensions.paddingSM,
        children: [
          Container(
            width: AppDimensions.tamanoPuntoLinea,
            height: AppDimensions.tamanoPuntoLinea,
            margin: const EdgeInsets.only(top: AppDimensions.paddingXS),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: TituloSubtituloWidget(titulo: titulo, subtitulo: subtitulo),
          ),
        ],
      ),
    );
  }
}
