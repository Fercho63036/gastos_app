import 'package:flutter_test/flutter_test.dart';

import 'package:gastos_app/app/shared/models/categoria_movimiento.dart';
import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/models/periodo_mes_model.dart';
import 'package:gastos_app/app/shared/utils/ediciones_helpers.dart';
import 'package:gastos_app/app/shared/utils/saldo_helpers.dart';

Movimiento _mov(
  String id,
  int monto, {
  DateTime? fecha,
  bool anulado = false,
  bool esEntrada = false,
}) => Movimiento(
  id: id,
  titulo: id,
  categoria: CategoriaMovimiento.comida,
  montoCentavos: monto,
  fecha: fecha ?? DateTime(2026, 10, 5),
  anulado: anulado,
  esEntrada: esEntrada,
);

void main() {
  final periodo = PeriodoMes(
    inicio: DateTime(2026, 10, 1),
    arrastradoCentavos: 8500,
    montoMesCentavos: 120000,
    pisoCentavos: 5000,
  );

  test('el saldo ignora anulados y movimientos de antes del periodo', () {
    final resumen = SaldoHelpers.calcular(periodo, [
      _mov('almuerzo', 2500),
      _mov('anulado', 800, anulado: true),
      _mov('viejo', 9999, fecha: DateTime(2026, 9, 30)),
      _mov('recarga', 20000, esEntrada: true),
    ]);
    expect(resumen.saldoCentavos, 128500 + 20000 - 2500);
    expect(resumen.gastableCentavos, resumen.saldoCentavos - 5000);
    expect(resumen.gastableTotalCentavos, 128500 + 20000 - 5000);
  });

  test('diferencias arma el historial solo de lo que cambió', () {
    final original = _mov('Almuerzo U', 2000);
    final editado = original.copyWith(titulo: 'Almuerzo', montoCentavos: 2500);
    final cambios = EdicionesHelpers.diferencias(
      original,
      editado,
      DateTime(2026, 10, 5, 13, 45),
    );
    expect(cambios.map(EdicionesHelpers.describir), [
      'Monto: Bs 20,00 → Bs 25,00',
      'Descripción: “Almuerzo U” → “Almuerzo”',
    ]);
  });
}
