import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gastos_app/core/theme/app_theme.dart';
import 'package:gastos_app/features/expenses/data/repositories/expenses_repository.dart';
import 'package:gastos_app/features/expenses/presentation/providers/expenses_provider.dart';
import 'package:gastos_app/features/expenses/presentation/screens/expenses_list_screen.dart';

class GastosApp extends StatelessWidget {
  const GastosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ExpensesProvider(ExpensesRepository()),
        ),
        // Futuras features agregan acá su propio ChangeNotifierProvider.
      ],
      child: MaterialApp(
        title: 'Gastos',
        theme: AppTheme.light,
        home: const ExpensesListScreen(),
      ),
    );
  }
}
