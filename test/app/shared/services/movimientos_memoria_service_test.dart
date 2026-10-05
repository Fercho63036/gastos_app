import 'package:flutter_test/flutter_test.dart';

import 'package:gastos_app/app/shared/models/categoria_movimiento.dart';
import 'package:gastos_app/app/shared/services/movimientos_memoria_service.dart';

void main() {
  late DateTime ahora;
  late MovimientosMemoriaService servicio;
  late int avisos;

  setUp(() {
    ahora = DateTime(2026, 10, 5, 13, 20);
    servicio = MovimientosMemoriaService(ahora: () => ahora);
    avisos = 0;
    servicio.addListener(() => avisos++);
  });

  test('registrar un gasto baja el saldo y avisa', () {
    final saldoAntes = servicio.resumen.saldoCentavos;
    final gasto = servicio.registrarGasto(
      titulo: 'Almuerzo',
      categoria: CategoriaMovimiento.comida,
      montoCentavos: 2500,
    );
    expect(servicio.movimientos.first.id, gasto.id);
    expect(gasto.codigo, startsWith('G-'));
    expect(servicio.resumen.saldoCentavos, saldoAntes - 2500);
    expect(avisos, 1);
  });

  test('una entrada sube el saldo', () {
    final saldoAntes = servicio.resumen.saldoCentavos;
    servicio.registrarEntrada(titulo: 'Trabajo', montoCentavos: 20000);
    expect(servicio.resumen.saldoCentavos, saldoAntes + 20000);
  });

  test('actualizar guarda el historial y anular devuelve el saldo', () {
    final original = servicio.movimientos.first;
    final saldoAntes = servicio.resumen.saldoCentavos;
    final cambio = servicio.actualizar(original.copyWith(anulado: true));
    final guardado = servicio.buscar(original.id);
    expect(cambio, isTrue);
    expect(guardado?.ediciones.length, 1);
    expect(servicio.resumen.saldoCentavos, saldoAntes + original.montoCentavos);
    expect(servicio.actualizar(original.copyWith(anulado: true)), isFalse);
  });

  test('iniciar mes arrastra el saldo actual', () {
    final saldoAntes = servicio.resumen.saldoCentavos;
    ahora = ahora.add(const Duration(minutes: 1));
    servicio.iniciarMes(montoMesCentavos: 120000, pisoCentavos: 5000);
    expect(servicio.periodoActual.arrastradoCentavos, saldoAntes);
    expect(servicio.resumen.saldoCentavos, saldoAntes + 120000);
  });
}
