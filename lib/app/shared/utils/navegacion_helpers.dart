import 'package:flutter/widgets.dart';

import 'package:go_router/go_router.dart';

import 'package:gastos_app/app/core/routes/route_names.dart';

class NavegacionHelpers {
  NavegacionHelpers._();

  /// Vuelve atrás; si se llegó con `go` (p. ej. desde el menú) no hay a dónde
  /// volver y se va a Inicio.
  static void volver(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(RouteNames.home);
    }
  }
}
