import 'package:flutter_test/flutter_test.dart';

import 'package:gastos_app/app/shared/utils/agrupacion_helpers.dart';

void main() {
  test('agruparPorDia ordena por día y respeta el orden interno', () {
    final fechas = [
      DateTime(2026, 9, 30, 8),
      DateTime(2026, 10, 5, 9),
      DateTime(2026, 10, 4, 20),
      DateTime(2026, 10, 5, 7),
    ];
    final grupos = AgrupacionHelpers.agruparPorDia(fechas, (fecha) => fecha);

    expect(grupos.map((grupo) => grupo.fecha.day), [5, 4, 30]);
    expect(grupos.first.items.map((fecha) => fecha.hour), [9, 7]);
  });
}
