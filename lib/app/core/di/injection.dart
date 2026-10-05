import 'package:get_it/get_it.dart';

import 'package:gastos_app/app/core/routes/app_router.dart';
import 'package:gastos_app/app/features/auth/providers/auth_provider.dart';
import 'package:gastos_app/app/shared/layout/providers/theme_provider.dart';
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

  // Nivel 4: features
  getIt.registerLazySingleton<ExpensesProvider>(
    () => ExpensesProvider(ExpensesRepository()),
  );

  // Nivel 5: routing
  getIt.registerLazySingleton<AppRouter>(
    () => AppRouter(refrescarCon: getIt<AuthProvider>()),
  );
}
