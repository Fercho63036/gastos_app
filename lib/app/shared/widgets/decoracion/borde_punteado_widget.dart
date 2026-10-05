import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/// Flutter no trae borde punteado; se dibuja sobre el hijo (p. ej. anulados).
class BordePunteadoWidget extends StatelessWidget {
  final Color color;
  final double radio;
  final Widget child;

  const BordePunteadoWidget({
    super.key,
    required this.color,
    required this.radio,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _BordePunteadoPainter(color: color, radio: radio),
      child: child,
    );
  }
}

class _BordePunteadoPainter extends CustomPainter {
  final Color color;
  final double radio;

  const _BordePunteadoPainter({required this.color, required this.radio});

  @override
  void paint(Canvas canvas, Size size) {
    final pincel = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppDimensions.bordeDelgado;
    final contorno = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radio)),
      );
    for (final metrica in contorno.computeMetrics()) {
      var distancia = 0.0;
      while (distancia < metrica.length) {
        final fin = distancia + AppDimensions.largoGuionBorde;
        canvas.drawPath(metrica.extractPath(distancia, fin), pincel);
        distancia = fin + AppDimensions.espacioGuionBorde;
      }
    }
  }

  @override
  bool shouldRepaint(_BordePunteadoPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radio != radio;
}
