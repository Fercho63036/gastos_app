import 'package:get_it/get_it.dart';

import 'package:gastos_app/app/core/routes/app_router.dart';
import 'package:gastos_app/app/features/auth/providers/auth_provider.dart';
import 'package:gastos_app/app/features/inicio/providers/inicio_provider.dart';
import 'package:gastos_app/app/features/inicio/services/inicio_mock_service.dart';
import 'package:gastos_app/app/features/movimientos/providers/detalle_gasto_provider.dart';
import 'package:gastos_app/app/features/movimientos/providers/nueva_entrada_provider.dart';
import 'package:gastos_app/app/features/movimientos/providers/nuevo_gasto_provider.dart';
import 'package:gastos_app/app/features/periodo/providers/iniciar_mes_provider.dart';
import 'package:gastos_app/app/shared/layout/providers/theme_provider.dart';
import 'package:gastos_app/app/shared/services/movimientos_memoria_service.dart';
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

  // Nivel 3: autenticación (mock local)
  getIt.registerLazySingleton<AuthProvider>(
    () => AuthProvider(getIt<StorageService>()),
  );

  // Niveles 4 y 5: datos compartidos y features
  _registrarFeatures();

  // Nivel 6: routing
  getIt.registerLazySingleton<AppRouter>(
    () => AppRouter(refrescarCon: getIt<AuthProvider>()),
  );
}

void _registrarFeatures() {
  // Datos compartidos (en memoria hasta conectar SQLite)
  getIt.registerLazySingleton<MovimientosMemoriaService>(
    MovimientosMemoriaService.new,
  );
  getIt.registerLazySingleton<InicioProvider>(
    () => InicioProvider(InicioMockService(getIt<MovimientosMemoriaService>())),
  );
  getIt.registerLazySingleton<ExpensesProvider>(
    () => ExpensesProvider(ExpensesRepository()),
  );
  _registrarFormularios();
}

/// Providers por pantalla: `registerFactory` crea uno nuevo en cada apertura.
void _registrarFormularios() {
  getIt.registerFactory<NuevoGastoProvider>(
    () => NuevoGastoProvider(getIt<MovimientosMemoriaService>()),
  );
  getIt.registerFactory<NuevaEntradaProvider>(
    () => NuevaEntradaProvider(getIt<MovimientosMemoriaService>()),
  );
  getIt.registerFactoryParam<DetalleGastoProvider, String, void>(
    (id, _) => DetalleGastoProvider(getIt<MovimientosMemoriaService>(), id),
  );
  getIt.registerFactory<IniciarMesProvider>(
    () =>
        IniciarMesProvider(getIt<MovimientosMemoriaService>(), DateTime.now()),
  );
}
