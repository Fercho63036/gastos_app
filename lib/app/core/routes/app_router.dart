/****************************** FLUTTER / DART ******************************/
import 'package:flutter/widgets.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:go_router/go_router.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/routes/route_guards.dart';
import 'package:gastos_app/app/core/routes/route_names.dart';
import 'package:gastos_app/app/core/routes/ruta_no_encontrada_page.dart';
import 'package:gastos_app/app/core/routes/rutas_formularios.dart';

/********************************* FEATURE **********************************/
import 'package:gastos_app/app/features/auth/pages/login_page.dart';
import 'package:gastos_app/app/features/auth/pages/recuperar_contrasena_page.dart';
import 'package:gastos_app/app/features/auth/pages/registrar_page.dart';
import 'package:gastos_app/app/features/inicio/pages/inicio_page.dart';
import 'package:gastos_app/app/features/perfil/pages/perfil_page.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/layout/main_layout.dart';

class AppRouter {
  final GoRouter config;

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();

  /******************************** APP ROUTER ********************************/
  AppRouter({required Listenable refrescarCon})
    : config = GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: RouteNames.auth,
        refreshListenable: refrescarCon,
        redirect: RouteGuards.authGuard,
        routes: [
          GoRoute(
            path: RouteNames.auth,
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: RouteNames.registro,
            builder: (context, state) => const RegistrarPage(),
          ),
          GoRoute(
            path: RouteNames.recuperarPassword,
            builder: (context, state) => const RecuperarContrasenaPage(),
          ),
          ...RutasFormularios.rutas,
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) => MainLayout(child: child),
            routes: [
              GoRoute(
                path: RouteNames.home,
                builder: (context, state) => const InicioPage(),
              ),
              GoRoute(
                path: RouteNames.perfil,
                builder: (context, state) => const PerfilPage(),
              ),
            ],
          ),
        ],
        errorBuilder: (context, state) => RutaNoEncontradaPage(ruta: state.uri),
      );
}
