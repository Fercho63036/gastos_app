import 'package:flutter/foundation.dart';

import 'package:gastos_app/features/expenses/data/models/expense.dart';
import 'package:gastos_app/features/expenses/data/repositories/expenses_repository.dart';

class ExpensesProvider extends ChangeNotifier {
  ExpensesProvider(this._repository);

  final ExpensesRepository _repository;

  List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;

  Future<void> loadExpenses() async {
    _expenses = await _repository.getExpenses();
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await _repository.insertExpense(expense);
    await loadExpenses();
  }

  Future<void> removeExpense(int id) async {
    await _repository.deleteExpense(id);
    await loadExpenses();
  }
}
