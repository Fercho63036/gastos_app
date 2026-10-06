/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/********************************** SHARED **********************************/
import '../textos/titulo_subtitulo_widget.dart';
import 'tarjeta_superficie_widget.dart';

/********************** TARJETA ETIQUETA VALOR WIDGET ***********************/
class TarjetaEtiquetaValorWidget extends StatelessWidget {
  final String titulo;
  final String valor;
  final String? subtitulo;

  const TarjetaEtiquetaValorWidget({
    super.key,
    required this.titulo,
    required this.valor,
    this.subtitulo,
  });

  @override
  Widget build(BuildContext context) {
    return TarjetaSuperficieWidget(
      child: Row(
        spacing: AppDimensions.paddingS,
        children: [
          Expanded(
            child: TituloSubtituloWidget(titulo: titulo, subtitulo: subtitulo),
          ),
          Text(
            valor,
            style: const TextStyle(
              fontSize: AppDimensions.fontL,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
