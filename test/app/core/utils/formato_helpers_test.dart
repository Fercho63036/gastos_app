import 'package:flutter_test/flutter_test.dart';

import 'package:gastos_app/app/core/utils/formato_helpers.dart';

void main() {
  final hoy = DateTime(2026, 10, 5, 15);

  test('formatearMonto usa punto de miles y coma decimal', () {
    expect(FormatoHelpers.formatearMonto(124550), 'Bs 1.245,50');
    expect(FormatoHelpers.formatearMonto(300), 'Bs 3,00');
    expect(FormatoHelpers.formatearMonto(123456789), 'Bs 1.234.567,89');
  });

  test('formatearHora rellena con ceros', () {
    expect(FormatoHelpers.formatearHora(DateTime(2026, 1, 1, 7, 5)), '07:05');
  });

  test('fraccion y porcentaje se limitan entre 0 y 100', () {
    expect(FormatoHelpers.fraccion(5, 0), 0);
    expect(FormatoHelpers.fraccion(15, 10), 1);
    expect(FormatoHelpers.porcentaje(FormatoHelpers.fraccion(1, 4)), 25);
  });

  test('formatearEncabezadoDia marca hoy y ayer', () {
    expect(FormatoHelpers.formatearEncabezadoDia(hoy, hoy), 'HOY · LUN 5 OCT');
    expect(
      FormatoHelpers.formatearEncabezadoDia(DateTime(2026, 10, 4), hoy),
      'AYER · DOM 4 OCT',
    );
    expect(
      FormatoHelpers.formatearEncabezadoDia(DateTime(2026, 9, 30), hoy),
      'MIE 30 SEP',
    );
  });
}
