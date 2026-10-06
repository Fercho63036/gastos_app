/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/**************************** DESPLEGABLE WIDGET ****************************/
class DesplegableWidget<T> extends StatelessWidget {
  final List<T> opciones;
  final T valor;
  final String Function(T opcion) etiquetaDe;
  final ValueChanged<T> onCambiar;

  const DesplegableWidget({
    super.key,
    required this.opciones,
    required this.valor,
    required this.etiquetaDe,
    required this.onCambiar,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: valor,
      isExpanded: true,
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: AppDimensions.fontL,
      ),
      items: [
        for (final opcion in opciones)
          DropdownMenuItem<T>(value: opcion, child: Text(etiquetaDe(opcion))),
      ],
      onChanged: (opcion) {
        if (opcion != null) onCambiar(opcion);
      },
    );
  }
}
