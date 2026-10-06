/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/********************************** SHARED **********************************/
import 'chip_seleccion_widget.dart';

/*********************** GRUPO CHIPS SELECCION WIDGET ***********************/
class GrupoChipsSeleccionWidget<T> extends StatelessWidget {
  final List<T> opciones;
  final T seleccionado;
  final String Function(T opcion) etiquetaDe;
  final ValueChanged<T> onSeleccionar;

  const GrupoChipsSeleccionWidget({
    super.key,
    required this.opciones,
    required this.seleccionado,
    required this.etiquetaDe,
    required this.onSeleccionar,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppDimensions.paddingS,
      runSpacing: AppDimensions.paddingS,
      children: [
        for (final opcion in opciones)
          ChipSeleccionWidget(
            etiqueta: etiquetaDe(opcion),
            seleccionado: opcion == seleccionado,
            onTap: () => onSeleccionar(opcion),
          ),
      ],
    );
  }
}
