import 'package:flutter_test/flutter_test.dart';

import 'package:gastos_app/app/shared/models/campo_edicion.dart';
import 'package:gastos_app/app/shared/models/categoria_movimiento.dart';
import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/utils/ediciones_helpers.dart';

void main() {
  final fecha = DateTime(2026, 10, 5, 13, 45);
  final original = Movimiento(
    id: '1',
    titulo: 'Almuerzo',
    categoria: CategoriaMovimiento.comida,
    montoCentavos: 2000,
    fecha: DateTime(2026, 10, 5, 13, 20),
  );

  test('diferencias guarda claves y valores crudos', () {
    final editado = original.copyWith(
      montoCentavos: 2500,
      categoria: CategoriaMovimiento.pasajes,
      anulado: true,
    );
    final cambios = EdicionesHelpers.diferencias(original, editado, fecha);

    expect(cambios.map((cambio) => cambio.campo), [
      CampoEdicion.monto,
      CampoEdicion.categoria,
      CampoEdicion.estado,
    ]);
    expect(cambios.first.valorAnterior, '2000');
    expect(cambios.first.valorNuevo, '2500');
    expect(cambios[1].valorNuevo, 'pasajes');
    expect(cambios.last.valorNuevo, 'anulado');
  });

  test('describir formatea igual que antes', () {
    final cambios = EdicionesHelpers.diferencias(
      original,
      original.copyWith(
        montoCentavos: 2500,
        titulo: 'Cena',
        categoria: CategoriaMovimiento.pasajes,
        anulado: true,
      ),
      fecha,
    );
    expect(cambios.map(EdicionesHelpers.describir), [
      'Monto: Bs 20,00 → Bs 25,00',
      'Descripción: “Almuerzo” → “Cena”',
      'Categoría: Comida → Pasajes',
      'Estado: Activo → Anulado',
    ]);
  });

  test('hayCambios', () {
    expect(EdicionesHelpers.hayCambios(original, original), isFalse);
    expect(
      EdicionesHelpers.hayCambios(original, original.copyWith(titulo: 'x')),
      isTrue,
    );
  });
}
