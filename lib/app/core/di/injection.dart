/**************************** PAQUETES EXTERNOS *****************************/
import 'package:get_it/get_it.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/database/app_database.dart';
import 'package:gastos_app/app/core/routes/app_router.dart';

/********************************* FEATURE **********************************/
import 'package:gastos_app/app/features/auth/providers/auth_provider.dart';
import 'package:gastos_app/app/features/auth/repositories/auth_local_repositorio.dart';
import 'package:gastos_app/app/features/auth/repositories/auth_repositorio.dart';
import 'package:gastos_app/app/features/inicio/providers/inicio_provider.dart';
import 'package:gastos_app/app/features/inicio/services/inicio_service.dart';
import 'package:gastos_app/app/features/movimientos/providers/detalle_gasto_provider.dart';
import 'package:gastos_app/app/features/movimientos/providers/nueva_entrada_provider.dart';
import 'package:gastos_app/app/features/movimientos/providers/nuevo_gasto_provider.dart';
import 'package:gastos_app/app/features/periodo/providers/iniciar_mes_provider.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/layout/providers/theme_provider.dart';
import 'package:gastos_app/app/shared/repositories/local/movimientos_local_repositorio.dart';
import 'package:gastos_app/app/shared/repositories/movimientos_repositorio.dart';
import 'package:gastos_app/app/shared/services/movimientos_service.dart';
import 'package:gastos_app/app/shared/services/movimientos_sqlite_almacen.dart';
import 'package:gastos_app/app/shared/services/storage_service.dart';

/********************************* FEATURE **********************************/
import 'package:gastos_app/features/expenses/data/repositories/expenses_repository.dart';
import 'package:gastos_app/features/expenses/presentation/providers/expenses_provider.dart';

final getIt = GetIt.instance;

Future<void> setupDependencias() async {
  /****************************** NIVEL 1: CORE *******************************/
  final storage = StorageService();
  await storage.init();
  getIt.registerSingleton<StorageService>(storage);

  /******************************* NIVEL 2: PROVIDERS GLOBALES ********************************/
  getIt.registerLazySingleton<ThemeProvider>(
    () => ThemeProvider(getIt<StorageService>()),
  );

  /***************************** NIVEL 3: REPOSITORIOS ****************************/
  _registrarRepositorios();

  /**************************** NIVEL 4: AUTENTICACION Y DATOS ********************************/
  getIt.registerLazySingleton<AuthProvider>(
    () => AuthProvider(getIt<AuthRepositorio>(), getIt<StorageService>()),
  );
  await _registrarDatos();

  /**************************** NIVEL 5: FEATURES *****************************/
  _registrarFeatures();

  /******************************** NIVEL 6: ROUTING ***************************************/
  getIt.registerLazySingleton<AppRouter>(
    () => AppRouter(refrescarCon: getIt<AuthProvider>()),
  );
}

/************************** REGISTRAR REPOSITORIOS **************************/
void _registrarRepositorios() {
  getIt.registerLazySingleton<AuthRepositorio>(AuthLocalRepositorio.new);
  getIt.registerLazySingleton<MovimientosRepositorio>(
    () => MovimientosLocalRepositorio(
      MovimientosSqliteAlmacen(AppDatabase.instance),
    ),
  );
}

/***************************** REGISTRAR DATOS ******************************/
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

/************************** REGISTRAR FORMULARIOS ***************************/
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
