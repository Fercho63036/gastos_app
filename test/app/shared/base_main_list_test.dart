import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gastos_app/app/core/constants/app_duraciones.dart';
import 'package:gastos_app/app/shared/paginado/base_main_list.dart';

const _todos = ['Almuerzo', 'Taxi', 'Cine', 'Mercado'];

class _ListaPrueba extends BaseMainList<String> {
  const _ListaPrueba() : super(showAppBar: false);

  @override
  Future<PaginatedResponse<String>> loadData(int page, String search) async {
    final filtrados = _todos
        .where((item) => item.toLowerCase().contains(search.toLowerCase()))
        .toList();
    return PaginatedResponse(datos: filtrados, total: filtrados.length);
  }

  @override
  Widget buildItem(BuildContext context, String item) =>
      ListTile(title: Text(item));
}

void main() {
  Future<void> montar(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: _ListaPrueba())),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('muestra los items de la primera página', (tester) async {
    await montar(tester);
    for (final item in _todos) {
      expect(find.text(item), findsOneWidget);
    }
  });

  testWidgets('la búsqueda recarga la lista filtrada', (tester) async {
    await montar(tester);
    await tester.enterText(find.byType(TextField), 'taxi');
    await tester.pump(AppDuraciones.debounceBusqueda);
    await tester.pumpAndSettle();

    expect(find.text('Taxi'), findsOneWidget);
    expect(find.text('Almuerzo'), findsNothing);
  });
}
