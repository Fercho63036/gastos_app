import 'package:get_it/get_it.dart';

import 'package:gastos_app/app/core/database/app_database.dart';
import 'package:gastos_app/app/core/routes/app_router.dart';
import 'package:gastos_app/app/features/auth/providers/auth_provider.dart';
import 'package:gastos_app/app/features/auth/repositories/auth_local_repositorio.dart';
import 'package:gastos_app/app/features/auth/repositories/auth_repositorio.dart';
import 'package:gastos_app/app/features/inicio/providers/inicio_provider.dart';
import 'package:gastos_app/app/features/inicio/services/inicio_service.dart';
import 'package:gastos_app/app/features/movimientos/providers/detalle_gasto_provider.dart';
import 'package:gastos_app/app/features/movimientos/providers/nueva_entrada_provider.dart';
import 'package:gastos_app/app/features/movimientos/providers/nuevo_gasto_provider.dart';
import 'package:gastos_app/app/features/periodo/providers/iniciar_mes_provider.dart';
import 'package:gastos_app/app/shared/layout/providers/theme_provider.dart';
import 'package:gastos_app/app/shared/repositories/local/movimientos_local_repositorio.dart';
import 'package:gastos_app/app/shared/repositories/movimientos_repositorio.dart';
import 'package:gastos_app/app/shared/services/movimientos_service.dart';
import 'package:gastos_app/app/shared/services/movimientos_sqlite_almacen.dart';
import 'package:gastos_app/app/shared/services/storage_service.dart';
import 'package:gastos_app/features/expenses/data/repositories/expenses_repository.dart';
import 'package:gastos_app/features/expenses/presentation/providers/expenses_provider.dart';

final getIt = GetIt.instance;

Future<void> setupDependencias() async {
  // Nivel 1: core
  final storage = StorageService();
  await storage.init();
  getIt.registerSingleton<StorageService>(storage);

  // Nivel 2: providers globales
  getIt.registerLazySingleton<ThemeProvider>(
    () => ThemeProvider(getIt<StorageService>()),
  );

  // Nivel 3: repositorios (hoy locales; mañana, el backend)
  _registrarRepositorios();

  // Nivel 4: autenticación y datos
  getIt.registerLazySingleton<AuthProvider>(
    () => AuthProvider(getIt<AuthRepositorio>(), getIt<StorageService>()),
  );
  await _registrarDatos();

  // Nivel 5: features
  _registrarFeatures();

  // Nivel 6: routing
  getIt.registerLazySingleton<AppRouter>(
    () => AppRouter(refrescarCon: getIt<AuthProvider>()),
  );
}

/// Único punto que cambia al conectar el backend: registrar aquí las
/// implementaciones que llaman al API (ver `docs/api_contrato.md`).
void _registrarRepositorios() {
  getIt.registerLazySingleton<AuthRepositorio>(AuthLocalRepositorio.new);
  getIt.registerLazySingleton<MovimientosRepositorio>(
    () => MovimientosLocalRepositorio(
      MovimientosSqliteAlmacen(AppDatabase.instance),
    ),
  );
}

/// Se carga antes de mostrar la app para que Inicio arranque con el resumen.
Future<void> _registrarDatos() async {
  final movimientos = MovimientosService(getIt<MovimientosRepositorio>());
  await movimientos.cargar();
  getIt.registerSingleton<MovimientosService>(movimientos);
}

void _registrarFeatures() {
  getIt.registerLazySingleton<InicioProvider>(
    () => InicioProvider(InicioService(getIt<MovimientosService>())),
  );
  getIt.registerLazySingleton<ExpensesProvider>(
    () => ExpensesProvider(ExpensesRepository()),
  );
  _registrarFormularios();
}

/// Providers por pantalla: `registerFactory` crea uno nuevo en cada apertura.
void _registrarFormularios() {
  getIt.registerFactory<NuevoGastoProvider>(
    () => NuevoGastoProvider(getIt<MovimientosService>()),
  );
  getIt.registerFactory<NuevaEntradaProvider>(
    () => NuevaEntradaProvider(getIt<MovimientosService>()),
  );
  getIt.registerFactoryParam<DetalleGastoProvider, String, void>(
    (id, _) => DetalleGastoProvider(getIt<MovimientosService>(), id),
  );
  getIt.registerFactory<IniciarMesProvider>(
    () => IniciarMesProvider(getIt<MovimientosService>(), DateTime.now()),
  );
}
