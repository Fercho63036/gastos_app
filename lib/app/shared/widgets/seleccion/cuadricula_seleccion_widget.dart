/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/utils/responsive_helper.dart';

/********************************** SHARED **********************************/
import 'celda_seleccion_widget.dart';

/*********************** CUADRICULA SELECCION WIDGET ************************/
class CuadriculaSeleccionWidget<T> extends StatelessWidget {
  final List<T> opciones;
  final T seleccionado;
  final String Function(T opcion) etiquetaDe;
  final IconData Function(T opcion) iconoDe;
  final ValueChanged<T> onSeleccionar;

  const CuadriculaSeleccionWidget({
    super.key,
    required this.opciones,
    required this.seleccionado,
    required this.etiquetaDe,
    required this.iconoDe,
    required this.onSeleccionar,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: opciones.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveHelper.columnasCuadricula(context),
        mainAxisExtent: AppDimensions.alturaCeldaSeleccion,
        mainAxisSpacing: AppDimensions.paddingS,
        crossAxisSpacing: AppDimensions.paddingS,
      ),
      itemBuilder: (context, indice) {
        final opcion = opciones[indice];
        return CeldaSeleccionWidget(
          icono: iconoDe(opcion),
          etiqueta: etiquetaDe(opcion),
          seleccionado: opcion == seleccionado,
          onTap: () => onSeleccionar(opcion),
        );
      },
    );
  }
}
