import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gastos_app/core/widgets/empty_state.dart';
import 'package:gastos_app/features/expenses/presentation/providers/expenses_provider.dart';

class ExpensesListScreen extends StatefulWidget {
  const ExpensesListScreen({super.key});

  @override
  State<ExpensesListScreen> createState() => _ExpensesListScreenState();
}

class _ExpensesListScreenState extends State<ExpensesListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpensesProvider>().loadExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gastos')),
      body: Consumer<ExpensesProvider>(
        builder: (context, provider, _) {
          if (provider.expenses.isEmpty) {
            return const EmptyState(
              message: 'Todavía no registraste ningún gasto',
              icon: Icons.receipt_long_outlined,
            );
          }

          return ListView.builder(
            itemCount: provider.expenses.length,
            itemBuilder: (context, index) {
              final expense = provider.expenses[index];
              return ListTile(
                title: Text(expense.title),
                subtitle: Text(expense.date.toString()),
                trailing: Text(expense.amount.toStringAsFixed(2)),
              );
            },
          );
        },
      ),
    );
  }
}
