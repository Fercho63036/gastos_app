import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

import '../decoracion/icono_contenedor_widget.dart';
import 'titulo_subtitulo_widget.dart';

/// Encabezado de página: ícono en contenedor, título grande y subtítulo.
class EncabezadoIconoWidget extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String subtitulo;

  const EncabezadoIconoWidget({
    super.key,
    required this.icono,
    required this.titulo,
    required this.subtitulo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppDimensions.paddingSM,
      children: [
        IconoContenedorWidget(
          icono: icono,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        Expanded(
          child: TituloSubtituloWidget(
            titulo: titulo,
            subtitulo: subtitulo,
            estiloTitulo: const TextStyle(
              fontSize: AppDimensions.fontTituloEncabezado,
              fontWeight: FontWeight.w800,
            ),
            tamanoSubtitulo: AppDimensions.fontS,
          ),
        ),
      ],
    );
  }
}
