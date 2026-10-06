/****************************** FLUTTER / DART ******************************/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:provider/provider.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/utils/responsive_helper.dart';

/********************************* FEATURE **********************************/
import 'package:gastos_app/app/features/auth/providers/auth_provider.dart';
import '../constants/perfil_strings.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final correo = context.watch<AuthProvider>().correoUsuario;

    return Center(
      child: Padding(
        padding: ResponsiveHelper.paddingAll(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              CupertinoIcons.person_crop_circle,
              size: AppDimensions.iconXL,
              color: colorScheme.primary,
            ),
            const SizedBox(height: AppDimensions.paddingSM),
            Text(PerfilStrings.titulo, style: textTheme.headlineSmall),
            const SizedBox(height: AppDimensions.paddingS),
            Text(PerfilStrings.sesionIniciadaComo, style: textTheme.bodySmall),
            Text(
              correo ?? PerfilStrings.sinCorreo,
              style: textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
