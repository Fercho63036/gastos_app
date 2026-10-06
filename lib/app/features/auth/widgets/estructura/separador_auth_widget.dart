/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/********************************* FEATURE **********************************/
import '../../constants/auth_strings.dart';

class SeparadorAuthWidget extends StatelessWidget {
  const SeparadorAuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingSM,
          ),
          child: Text(
            AuthStrings.separador,
            style: TextStyle(
              fontSize: AppDimensions.fontS,
              color: colorScheme.onSurface.withValues(
                alpha: AppDimensions.opacidadInactivo,
              ),
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
