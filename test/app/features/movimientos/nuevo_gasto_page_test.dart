import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:gastos_app/app/shared/models/categoria_movimiento.dart';

import 'package:gastos_app/app/features/movimientos/constants/movimientos_strings.dart';
import 'package:gastos_app/app/features/movimientos/pages/nuevo_gasto_page.dart';
import 'package:gastos_app/app/features/movimientos/providers/nuevo_gasto_provider.dart';

import '../../../helpers/movimientos_almacen_fake.dart';
import '../../../helpers/movimientos_servicio_prueba.dart';

void main() {
  testWidgets('registra el gasto en el servicio compartido', (tester) async {
    final almacen = MovimientosAlmacenFake();
    final servicio = servicioDePrueba(almacen);
    final router = GoRouter(
      initialLocation: '/nuevo',
      routes: [
        GoRoute(path: '/', builder: (_, _) => const SizedBox()),
        GoRoute(
          path: '/nuevo',
          builder: (_, _) => ChangeNotifierProvider(
            create: (_) => NuevoGastoProvider(servicio),
            child: const NuevoGastoPage(),
          ),
        ),
      ],
    );
    await tester.pumpWidget(MaterialApp.router(routerConfig: router));

    final campos = find.byType(TextField);
    await tester.enterText(campos.at(0), '2500');
    await tester.enterText(campos.at(1), 'Almuerzo');
    await tester.tap(find.text(CategoriaMovimiento.pasajes.nombre));
    await tester.tap(find.text(MovimientosStrings.guardarGasto));
    await tester.pumpAndSettle();

    final gasto = almacen.guardados.single;
    expect(gasto.titulo, 'Almuerzo');
    expect(gasto.montoCentavos, 2500);
    expect(gasto.categoria, CategoriaMovimiento.pasajes);
    expect(servicio.resumen.saldoCentavos, -2500);
  });
}
