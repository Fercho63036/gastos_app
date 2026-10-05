import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/widgets/decoracion/icono_contenedor_widget.dart';
import 'package:gastos_app/app/shared/widgets/tarjetas/tarjeta_fila_widget.dart';

import '../../utils/inicio_helpers.dart';
import 'detalle_movimiento_widget.dart';

/// Un movimiento sobre la tarjeta en fila compartida; anulado = punteado.
class TarjetaMovimientoWidget extends StatelessWidget {
  final Movimiento movimiento;
  final VoidCallback? onTap;

  const TarjetaMovimientoWidget({
    super.key,
    required this.movimiento,
    this.onTap,
  });

  TextStyle _buildEstiloPrincipal(ColorScheme colorScheme) {
    final anulado = movimiento.anulado;
    return TextStyle(
      color: anulado
          ? colorScheme.onSurface.withValues(
              alpha: AppDimensions.opacidadAnulado,
            )
          : colorScheme.onSurface,
      fontSize: AppDimensions.fontL,
      fontWeight: FontWeight.w700,
      decoration: anulado ? TextDecoration.lineThrough : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final estiloPrincipal = _buildEstiloPrincipal(
      Theme.of(context).colorScheme,
    );

    return TarjetaFilaWidget(
      punteado: movimiento.anulado,
      onTap: onTap,
      inicio: IconoContenedorWidget(
        icono: movimiento.categoria.icono,
        color: movimiento.categoria.color,
        atenuado: movimiento.anulado,
      ),
      contenido: DetalleMovimientoWidget(
        movimiento: movimiento,
        estiloTitulo: estiloPrincipal,
      ),
      fin: Text(
        InicioHelpers.formatearMontoMovimiento(movimiento),
        style: estiloPrincipal,
      ),
    );
  }
}
