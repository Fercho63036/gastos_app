/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:fl_chart/fl_chart.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/********************************* FEATURE **********************************/
import '../models/categoria_totalizada_model.dart';

/************************* GRAFICO CATEGORIAS WIDGET *************************/
class GraficoCategoriasWidget extends StatelessWidget {
  final List<CategoriaTotalizada> categorias;

  const GraficoCategoriasWidget({super.key, required this.categorias});

  /********************************** SECCIONES *********************************/
  List<PieChartSectionData> _buildSecciones() {
    final total = categorias.fold<int>(
      0,
      (suma, categoria) => suma + categoria.totalCentavos,
    );
    return [
      for (final categoria in categorias)
        PieChartSectionData(
          value: categoria.totalCentavos.toDouble(),
          color: categoria.categoria.color,
          radius: AppDimensions.radioPorcionGraficoCircular,
          title: total == 0
              ? ''
              : '${(categoria.totalCentavos * 100 / total).round()}%',
        ),
    ];
  }

  /************************************ BUILD ************************************/
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.alturaGraficoCircular,
      child: PieChart(
        PieChartData(
          sections: _buildSecciones(),
          centerSpaceRadius: AppDimensions.radioCentroGraficoCircular,
          sectionsSpace: AppDimensions.espacioPorcionGraficoCircular,
        ),
      ),
    );
  }
}
