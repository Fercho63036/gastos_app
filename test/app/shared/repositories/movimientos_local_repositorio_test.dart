import 'package:flutter_test/flutter_test.dart';

import 'package:gastos_app/app/shared/models/borrador_movimiento_model.dart';
import 'package:gastos_app/app/shared/models/categoria_movimiento.dart';
import 'package:gastos_app/app/shared/repositories/local/movimientos_local_repositorio.dart';

import '../../../helpers/movimientos_almacen_fake.dart';

void main() {
  late DateTime ahora;
  late MovimientosLocalRepositorio repositorio;

  setUp(() {
    ahora = DateTime(2026, 10, 1, 9);
    repositorio = MovimientosLocalRepositorio(
      MovimientosAlmacenFake(),
      ahora: () => ahora,
    );
  });

  Future<void> registrar(DateTime fecha) async {
    ahora = fecha;
    await repositorio.registrarMovimiento(
      const BorradorMovimiento(
        titulo: 'Gasto',
        categoria: CategoriaMovimiento.comida,
        montoCentavos: 100,
      ),
    );
  }

  test(
    'lista desde una fecha y pagina del más reciente al más antiguo',
    () async {
      await registrar(DateTime(2026, 9, 30));
      await registrar(DateTime(2026, 10, 2));
      await registrar(DateTime(2026, 10, 3));

      final primera = await repositorio.listarMovimientos(
        desde: DateTime(2026, 10),
        pagina: 1,
        porPagina: 1,
      );
      final segunda = await repositorio.listarMovimientos(
        desde: DateTime(2026, 10),
        pagina: 2,
        porPagina: 1,
      );
      expect(primera.total, 2);
      expect(primera.datos.single.fecha, DateTime(2026, 10, 3));
      expect(segunda.datos.single.fecha, DateTime(2026, 10, 2));
    },
  );

  test('el resumen ignora lo anterior al mes iniciado', () async {
    await registrar(DateTime(2026, 9, 30));
    ahora = DateTime(2026, 10, 1);
    final periodo = await repositorio.iniciarMes(
      montoMesCentavos: 1000,
      pisoCentavos: 200,
    );
    await registrar(DateTime(2026, 10, 2));

    final resumen = await repositorio.obtenerResumen();
    expect(periodo.arrastradoCentavos, -100);
    expect(resumen.saldoCentavos, 800);
    expect(resumen.gastableCentavos, 600);
  });
}
