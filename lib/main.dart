import 'package:flutter/material.dart';

import 'package:gastos_app/app/app_widget.dart';
import 'package:gastos_app/app/core/di/injection.dart';
import 'package:gastos_app/app/features/auth/providers/auth_provider.dart';
import 'package:gastos_app/app/shared/constants/comun_strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await setupDependencias();
    getIt<AuthProvider>().verificarSesion();
    runApp(const GastosApp());
  } catch (error, stackTrace) {
    debugPrint('[main] Error en bootstrap: $error\n$stackTrace');
    runApp(const _ErrorArranqueApp());
  }
}

class _ErrorArranqueApp extends StatelessWidget {
  const _ErrorArranqueApp();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text(ComunStrings.errorArranque))),
    );
  }
}
