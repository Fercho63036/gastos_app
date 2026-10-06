/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/utils/monto_input_formatter.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/models/categoria_movimiento.dart';
import 'package:gastos_app/app/shared/widgets/formularios/campo_etiquetado_widget.dart';
import 'package:gastos_app/app/shared/widgets/formularios/campo_texto_widget.dart';
import 'package:gastos_app/app/shared/widgets/seleccion/desplegable_widget.dart';

/********************************* FEATURE **********************************/
import '../../constants/movimientos_strings.dart';

/*********************** FILA MONTO CATEGORIA WIDGET ************************/
class FilaMontoCategoriaWidget extends StatelessWidget {
  final TextEditingController montoController;
  final CategoriaMovimiento categoria;
  final ValueChanged<CategoriaMovimiento> onCategoria;

  const FilaMontoCategoriaWidget({
    super.key,
    required this.montoController,
    required this.categoria,
    required this.onCategoria,
  });

  Widget _buildMonto() {
    return CampoEtiquetadoWidget(
      etiqueta: MovimientosStrings.montoBs,
      child: CampoTextoWidget(
        controller: montoController,
        keyboardType: TextInputType.number,
        inputFormatters: const [MontoInputFormatter()],
        estilo: const TextStyle(
          fontSize: AppDimensions.fontL,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildCategoria() {
    return CampoEtiquetadoWidget(
      etiqueta: MovimientosStrings.categoria,
      child: DesplegableWidget<CategoriaMovimiento>(
        opciones: CategoriaMovimiento.deGasto,
        valor: categoria,
        etiquetaDe: (opcion) => opcion.nombre,
        onCambiar: onCategoria,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppDimensions.paddingSM,
      children: [
        Expanded(child: _buildMonto()),
        Expanded(child: _buildCategoria()),
      ],
    );
  }
}
