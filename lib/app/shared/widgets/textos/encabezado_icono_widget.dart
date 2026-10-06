/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/********************************** SHARED **********************************/
import '../decoracion/icono_contenedor_widget.dart';
import 'titulo_subtitulo_widget.dart';

/************************* ENCABEZADO ICONO WIDGET **************************/
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
