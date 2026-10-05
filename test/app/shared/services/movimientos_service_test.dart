import 'package:flutter_test/flutter_test.dart';

import 'package:gastos_app/app/shared/models/categoria_movimiento.dart';
import 'package:gastos_app/app/shared/services/movimientos_service.dart';

import '../../../helpers/movimientos_almacen_fake.dart';

void main() {
  late DateTime ahora;
  late MovimientosAlmacenFake almacen;
  late MovimientosService servicio;
  late int avisos;

  setUp(() async {
    ahora = DateTime(2026, 10, 5, 13, 20);
    almacen = MovimientosAlmacenFake();
    servicio = MovimientosService(almacen, ahora: () => ahora);
    await servicio.cargar();
    avisos = 0;
    servicio.addListener(() => avisos++);
  });

  Future<void> registrarAlmuerzo() => servicio.registrarGasto(
    titulo: 'Almuerzo',
    categoria: CategoriaMovimiento.comida,
    montoCentavos: 2500,
  );

  test('sin nada registrado arranca vacío y sin mes', () {
    expect(servicio.movimientos, isEmpty);
    expect(servicio.mesIniciado, isFalse);
    expect(servicio.resumen.saldoCentavos, 0);
  });

  test('registrar un gasto lo persiste, baja el saldo y avisa', () async {
    await registrarAlmuerzo();
    final gasto = servicio.movimientos.first;
    expect(gasto.codigo, 'G-0001');
    expect(almacen.guardados.single.id, gasto.id);
    expect(servicio.resumen.saldoCentavos, -2500);
    expect(avisos, 1);
  });

  test('una entrada sube el saldo', () async {
    final entrada = await servicio.registrarEntrada(
      titulo: 'Trabajo',
      montoCentavos: 20000,
    );
    expect(entrada.codigo, 'E-0001');
    expect(servicio.resumen.saldoCentavos, 20000);
  });

  test('al reabrir la app recupera lo guardado', () async {
    await registrarAlmuerzo();
    await servicio.iniciarMes(montoMesCentavos: 190000, pisoCentavos: 5000);

    final reabierto = MovimientosService(almacen, ahora: () => ahora);
    await reabierto.cargar();
    expect(reabierto.movimientos.single.titulo, 'Almuerzo');
    expect(reabierto.resumen.saldoCentavos, servicio.resumen.saldoCentavos);
  });

  test('actualizar persiste el historial y anular devuelve el saldo', () async {
    await registrarAlmuerzo();
    final original = servicio.movimientos.first;
    final cambio = await servicio.actualizar(original.copyWith(anulado: true));
    expect(cambio, isTrue);
    expect(servicio.buscar(original.id)?.ediciones.length, 1);
    expect(almacen.guardados.single.anulado, isTrue);
    expect(servicio.resumen.saldoCentavos, 0);
    expect(
      await servicio.actualizar(original.copyWith(anulado: true)),
      isFalse,
    );
  });

  test('iniciar mes arrastra el saldo actual', () async {
    await servicio.registrarEntrada(titulo: 'Sobrante', montoCentavos: 8500);
    ahora = ahora.add(const Duration(minutes: 1));
    await servicio.iniciarMes(montoMesCentavos: 120000, pisoCentavos: 5000);
    expect(servicio.periodoActual?.arrastradoCentavos, 8500);
    expect(servicio.resumen.saldoCentavos, 128500);
    expect(almacen.periodos.length, 1);
  });
}
