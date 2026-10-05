import 'package:flutter/cupertino.dart';

import 'package:gastos_app/app/shared/layout/constants/layout_strings.dart';

/// Devuelve `true` al confirmar y `false` al cancelar.
class DialogoCerrarSesionWidget extends StatelessWidget {
  const DialogoCerrarSesionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text(LayoutStrings.cerrarSesionTitulo),
      content: const Text(LayoutStrings.cerrarSesionContenido),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(LayoutStrings.cancelar),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(LayoutStrings.aceptar),
        ),
      ],
    );
  }
}
