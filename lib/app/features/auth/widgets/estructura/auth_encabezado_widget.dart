import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/shared/layout/widgets/app_brand_logo_widget.dart';

class AuthEncabezadoWidget extends StatelessWidget {
  final String titulo;
  final String subtitulo;

  const AuthEncabezadoWidget({
    super.key,
    required this.titulo,
    required this.subtitulo,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        const SizedBox(height: AppDimensions.paddingS),
        const AppBrandLogoWidget(
          width: AppDimensions.tamanoLogoAuth,
          height: AppDimensions.tamanoLogoAuth,
        ),
        const SizedBox(height: AppDimensions.paddingS),
        Text(
          titulo,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.paddingXS),
        Text(
          subtitulo,
          style: textTheme.bodyMedium?.copyWith(
            color: textTheme.bodySmall?.color,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.paddingL),
      ],
    );
  }
}
