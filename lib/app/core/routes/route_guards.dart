/****************************** FLUTTER / DART ******************************/
import 'package:flutter/widgets.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:go_router/go_router.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/di/injection.dart';
import 'package:gastos_app/app/core/routes/route_names.dart';

/********************************* FEATURE **********************************/
import 'package:gastos_app/app/features/auth/providers/auth_provider.dart';

class RouteGuards {
  RouteGuards._();

  static String? authGuard(BuildContext context, GoRouterState state) {
    final autenticado = getIt<AuthProvider>().estaAutenticado;
    final esRutaPublica = RouteNames.publicas.contains(state.matchedLocation);

    if (!autenticado && !esRutaPublica) return RouteNames.auth;
    if (autenticado && esRutaPublica) return RouteNames.home;
    return null;
  }
}
