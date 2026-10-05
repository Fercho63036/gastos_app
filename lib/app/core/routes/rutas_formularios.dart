import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:gastos_app/app/core/di/injection.dart';
import 'package:gastos_app/app/core/routes/route_names.dart';
import 'package:gastos_app/app/features/movimientos/pages/detalle_gasto_page.dart';
import 'package:gastos_app/app/features/movimientos/pages/nueva_entrada_page.dart';
import 'package:gastos_app/app/features/movimientos/pages/nuevo_gasto_page.dart';
import 'package:gastos_app/app/features/movimientos/providers/detalle_gasto_provider.dart';
import 'package:gastos_app/app/features/movimientos/providers/nueva_entrada_provider.dart';
import 'package:gastos_app/app/features/movimientos/providers/nuevo_gasto_provider.dart';
import 'package:gastos_app/app/features/periodo/pages/iniciar_mes_page.dart';
import 'package:gastos_app/app/features/periodo/providers/iniciar_mes_provider.dart';

/// Pantallas de formulario a pantalla completa (sin tabs ni drawer); cada
/// una crea su provider al abrirse y lo libera al cerrarse.
class RutasFormularios {
  RutasFormularios._();

  static List<RouteBase> get rutas => [
    GoRoute(
      path: RouteNames.nuevoGasto,
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<NuevoGastoProvider>(),
        child: const NuevoGastoPage(),
      ),
    ),
    GoRoute(
      path: RouteNames.detalleGasto,
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<DetalleGastoProvider>(
          param1: state.pathParameters[RouteNames.parametroId] ?? '',
        ),
        child: const DetalleGastoPage(),
      ),
    ),
    GoRoute(
      path: RouteNames.nuevaEntrada,
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<NuevaEntradaProvider>(),
        child: const NuevaEntradaPage(),
      ),
    ),
    GoRoute(
      path: RouteNames.iniciarMes,
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<IniciarMesProvider>(),
        child: const IniciarMesPage(),
      ),
    ),
  ];
}
