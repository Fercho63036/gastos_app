class Expense {
  final int? id;
  final String title;
  final double amount;
  final DateTime date;

  const Expense({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  factory Expense.fromMap(Map<String, Object?> map) {
    return Expense(
      id: map['id'] as int?,
      title: map['title'] as String,
      amount: map['amount'] as double,
      date: DateTime.parse(map['date'] as String),
    );
  }
}
