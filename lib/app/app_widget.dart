/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:provider/provider.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/config/app_config.dart';
import 'package:gastos_app/app/core/di/injection.dart';
import 'package:gastos_app/app/core/routes/app_router.dart';
import 'package:gastos_app/app/core/theme/app_tema.dart';

/********************************* FEATURE **********************************/
import 'package:gastos_app/app/features/auth/providers/auth_provider.dart';
import 'package:gastos_app/app/features/inicio/providers/inicio_provider.dart';
import 'package:gastos_app/app/features/resumen/providers/resumen_provider.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/layout/providers/theme_provider.dart';

/********************************* FEATURE **********************************/
import 'package:gastos_app/features/expenses/presentation/providers/expenses_provider.dart';

class GastosApp extends StatelessWidget {
  const GastosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: getIt<ThemeProvider>()),
        ChangeNotifierProvider.value(value: getIt<AuthProvider>()),
        ChangeNotifierProvider.value(value: getIt<ExpensesProvider>()),
        ChangeNotifierProvider.value(value: getIt<InicioProvider>()),
        ChangeNotifierProvider.value(value: getIt<ResumenProvider>()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, temaProvider, _) => MaterialApp.router(
          title: AppConfig.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTema.temaClaro,
          darkTheme: AppTema.temaOscuro,
          themeMode: temaProvider.themeMode,
          routerConfig: getIt<AppRouter>().config,
        ),
      ),
    );
  }
}
