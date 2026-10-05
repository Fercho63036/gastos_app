import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

import 'chip_seleccion_widget.dart';

/// Chips de selección única para cualquier lista de opciones (p. ej. un enum).
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
