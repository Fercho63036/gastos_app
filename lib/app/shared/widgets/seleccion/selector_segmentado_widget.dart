/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/constants/app_duraciones.dart';

/************************ SELECTOR SEGMENTADO WIDGET ************************/
class SelectorSegmentadoWidget<T> extends StatelessWidget {
  final List<T> opciones;
  final T seleccionado;
  final String Function(T opcion) etiquetaDe;
  final ValueChanged<T> onSeleccionar;

  const SelectorSegmentadoWidget({
    super.key,
    required this.opciones,
    required this.seleccionado,
    required this.etiquetaDe,
    required this.onSeleccionar,
  });

  Widget _buildSegmento(ColorScheme colorScheme, T opcion) {
    final activo = opcion == seleccionado;
    return Expanded(
      child: GestureDetector(
        onTap: () => onSeleccionar(opcion),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: AppDuraciones.animacionNormal,
          height: AppDimensions.alturaSegmento,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: activo ? colorScheme.primary : null,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          child: Text(
            etiquetaDe(opcion),
            style: TextStyle(
              color: activo ? colorScheme.onPrimary : colorScheme.onSurface,
              fontSize: AppDimensions.fontM,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingXS),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(
          color: colorScheme.primary.withValues(
            alpha: AppDimensions.opacidadInactivo,
          ),
        ),
      ),
      child: Row(
        children: [
          for (final opcion in opciones) _buildSegmento(colorScheme, opcion),
        ],
      ),
    );
  }
}
