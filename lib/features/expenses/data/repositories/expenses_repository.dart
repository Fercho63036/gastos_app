import 'package:sqflite/sqflite.dart';

import 'package:gastos_app/core/database/database_helper.dart';
import 'package:gastos_app/features/expenses/data/models/expense.dart';

class ExpensesRepository {
  static const String tableName = 'expenses';

  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertExpense(Expense expense) async {
    final db = await DatabaseHelper.instance.database;
    return db.insert(tableName, expense.toMap()..remove('id'));
  }

  Future<List<Expense>> getExpenses() async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query(tableName, orderBy: 'date DESC');
    return rows.map(Expense.fromMap).toList();
  }

  Future<int> deleteExpense(int id) async {
    final db = await DatabaseHelper.instance.database;
    return db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
