import 'package:flutter_test/flutter_test.dart';

import 'package:gastos_app/app/core/constants/database_constants.dart';
import 'package:gastos_app/app/core/database/migraciones_database.dart';

Map<String, Object?> _fila(String campo, String anterior, String nuevo) => {
  DatabaseConstants.colId: 1,
  DatabaseConstants.colCampo: campo,
  DatabaseConstants.colValorAnterior: anterior,
  DatabaseConstants.colValorNuevo: nuevo,
};

void main() {
  void comprobar(
    Map<String, Object?> v1,
    String campo,
    String anterior,
    String nuevo,
  ) {
    final v2 = MigracionesDatabase.edicionACruda(v1);
    expect(v2[DatabaseConstants.colCampo], campo);
    expect(v2[DatabaseConstants.colValorAnterior], anterior);
    expect(v2[DatabaseConstants.colValorNuevo], nuevo);
  }

  test('convierte cada campo de v1 a valores crudos', () {
    comprobar(
      _fila('Monto', 'Bs 1.245,50', 'Bs 25,00'),
      'monto',
      '124550',
      '2500',
    );
    comprobar(
      _fila('Descripción', '“Almuerzo”', '“Cena”'),
      'descripcion',
      'Almuerzo',
      'Cena',
    );
    comprobar(
      _fila('Categoría', 'Comida', 'Diversión'),
      'categoria',
      'comida',
      'diversion',
    );
    comprobar(
      _fila('Estado', 'Activo', 'Anulado'),
      'estado',
      'activo',
      'anulado',
    );
  });

  test('una fila ya migrada no se toca', () {
    final cruda = _fila('monto', '100', '200');
    expect(identical(MigracionesDatabase.edicionACruda(cruda), cruda), isTrue);
  });
}
