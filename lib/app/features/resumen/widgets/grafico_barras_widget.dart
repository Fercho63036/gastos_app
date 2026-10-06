/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:fl_chart/fl_chart.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/theme/app_colores.dart';
import 'package:gastos_app/app/core/utils/formato_helpers.dart';

/********************************* FEATURE **********************************/
import '../models/punto_barra_model.dart';

/*************************** GRAFICO BARRAS WIDGET ****************************/
class GraficoBarrasWidget extends StatelessWidget {
  final List<PuntoBarra> puntos;

  const GraficoBarrasWidget({super.key, required this.puntos});

  /********************************** GRUPOS BARRAS *********************************/
  List<BarChartGroupData> _buildGrupos() {
    return [
      for (var indice = 0; indice < puntos.length; indice++)
        BarChartGroupData(
          x: indice,
          barRods: [
            BarChartRodData(
              toY: puntos[indice].totalCentavos / 100,
              color: AppColores.primario,
              width: AppDimensions.anchoBarraGrafico,
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusBarraGrafico,
              ),
            ),
          ],
        ),
    ];
  }

  /********************************* ETIQUETA EJE X *********************************/
  Widget _buildEtiquetaEjeX(double valor, TitleMeta meta) {
    final indice = valor.toInt();
    if (indice < 0 || indice >= puntos.length) return const SizedBox.shrink();
    final fecha = puntos[indice].fecha;
    return Padding(
      padding: const EdgeInsets.only(top: AppDimensions.paddingXS),
      child: Text(
        '${fecha.day}/${fecha.month}',
        style: const TextStyle(fontSize: AppDimensions.fontEtiquetaGrafico),
      ),
    );
  }

  /************************************ BUILD ************************************/
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.alturaGraficoBarras,
      child: BarChart(
        BarChartData(
          barGroups: _buildGrupos(),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: _buildEtiquetaEjeX,
              ),
            ),
          ),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final centavos = puntos[groupIndex].totalCentavos;
                return BarTooltipItem(
                  FormatoHelpers.formatearMonto(centavos),
                  const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
