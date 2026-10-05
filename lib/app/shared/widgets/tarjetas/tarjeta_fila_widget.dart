import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

import '../decoracion/borde_punteado_widget.dart';

/// Tarjeta en fila: [inicio] · [contenido] expandido · [fin].
/// Con [punteado] pierde el fondo y se marca con borde punteado.
class TarjetaFilaWidget extends StatelessWidget {
  final Widget inicio;
  final Widget contenido;
  final Widget fin;
  final bool punteado;
  final VoidCallback? onTap;

  const TarjetaFilaWidget({
    super.key,
    required this.inicio,
    required this.contenido,
    required this.fin,
    this.punteado = false,
    this.onTap,
  });

  Widget _buildFila(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: punteado ? null : colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusTarjeta),
      ),
      child: Row(
        spacing: AppDimensions.paddingM,
        children: [
          inicio,
          Expanded(child: contenido),
          fin,
        ],
      ),
    );
  }

  Widget _buildBorde(ColorScheme colorScheme) {
    final fila = _buildFila(colorScheme);
    if (!punteado) return fila;
    return BordePunteadoWidget(
      color: colorScheme.primary.withValues(
        alpha: AppDimensions.opacidadInactivo,
      ),
      radio: AppDimensions.radiusTarjeta,
      child: fila,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tarjeta = _buildBorde(Theme.of(context).colorScheme);
    if (onTap == null) return tarjeta;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: tarjeta,
    );
  }
}
