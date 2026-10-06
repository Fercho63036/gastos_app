/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:go_router/go_router.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/routes/route_names.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/constants/comun_strings.dart';

class RutaNoEncontradaPage extends StatelessWidget {
  final Uri ruta;

  const RutaNoEncontradaPage({super.key, required this.ruta});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text(ComunStrings.error)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppDimensions.paddingM,
          children: [
            Icon(
              Icons.error_outline,
              size: AppDimensions.iconXL,
              color: theme.colorScheme.error,
            ),
            Text(
              ComunStrings.rutaNoEncontrada,
              style: theme.textTheme.headlineSmall,
            ),
            Text('$ruta'),
            FilledButton(
              onPressed: () => context.go(RouteNames.home),
              child: const Text(ComunStrings.irAlInicio),
            ),
          ],
        ),
      ),
    );
  }
}
