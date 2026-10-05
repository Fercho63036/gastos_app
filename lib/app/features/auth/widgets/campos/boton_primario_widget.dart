import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

class BotonPrimarioWidget extends StatelessWidget {
  final String texto;
  final bool cargando;
  final VoidCallback onPressed;

  const BotonPrimarioWidget({
    super.key,
    required this.texto,
    required this.onPressed,
    this.cargando = false,
  });

  @override
  Widget build(BuildContext context) {
    if (cargando) {
      return const SizedBox(
        height: AppDimensions.alturaBoton,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return FilledButton(
      onPressed: onPressed,
      child: Text(
        texto,
        style: const TextStyle(
          fontSize: AppDimensions.fontL,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
