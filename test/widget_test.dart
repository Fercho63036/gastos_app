import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gastos_app/core/widgets/empty_state.dart';

void main() {
  testWidgets('EmptyState shows the given message', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EmptyState(message: 'Todavía no registraste ningún gasto'),
        ),
      ),
    );

    expect(find.text('Todavía no registraste ningún gasto'), findsOneWidget);
  });
}
