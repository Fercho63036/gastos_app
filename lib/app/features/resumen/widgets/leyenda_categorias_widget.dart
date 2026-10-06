/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/utils/formato_helpers.dart';

/********************************* FEATURE **********************************/
import '../models/categoria_totalizada_model.dart';

/************************* LEYENDA CATEGORIAS WIDGET *************************/
class LeyendaCategoriasWidget extends StatelessWidget {
  final List<CategoriaTotalizada> categorias;

  const LeyendaCategoriasWidget({super.key, required this.categorias});

  /********************************* BUILD FILA *********************************/
  Widget _buildFila(CategoriaTotalizada categoria) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingXS),
      child: Row(
        children: [
          Container(
            width: AppDimensions.tamanoPuntoLeyenda,
            height: AppDimensions.tamanoPuntoLeyenda,
            decoration: BoxDecoration(
              color: categoria.categoria.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppDimensions.paddingS),
          Expanded(child: Text(categoria.categoria.nombre)),
          Text(FormatoHelpers.formatearMonto(categoria.totalCentavos)),
        ],
      ),
    );
  }

  /************************************ BUILD ************************************/
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [for (final categoria in categorias) _buildFila(categoria)],
    );
  }
}
