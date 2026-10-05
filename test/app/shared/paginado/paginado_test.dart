import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gastos_app/app/shared/paginado/models/paginated_response_model.dart';
import 'package:gastos_app/app/shared/paginado/utils/paginacion_mixin.dart';
import 'package:gastos_app/app/shared/paginado/utils/paginado_helpers.dart';

class _ProviderFalso extends ChangeNotifier with PaginacionMixin<int> {
  final List<int> fuente = List.generate(10, (indice) => indice);
  bool fallar = false;
  final List<int> paginasPedidas = [];

  @override
  Future<PaginatedResponse<int>> obtenerPagina(int pagina) async {
    paginasPedidas.add(pagina);
    if (fallar) throw StateError('fallo de prueba');
    return PaginatedResponse(
      datos: PaginadoHelpers.paginar(fuente, pagina, 4),
      total: fuente.length,
    );
  }
}

void main() {
  test('paginar devuelve el tramo de cada página', () {
    final numeros = List.generate(10, (indice) => indice);
    expect(PaginadoHelpers.paginar(numeros, 1, 4), [0, 1, 2, 3]);
    expect(PaginadoHelpers.paginar(numeros, 3, 4), [8, 9]);
    expect(PaginadoHelpers.paginar(numeros, 4, 4), isEmpty);
    expect(PaginadoHelpers.paginar(numeros, 0, 4), isEmpty);
  });

  test('cargarMas concatena páginas hasta que no hay más', () async {
    final provider = _ProviderFalso();
    provider.reiniciarPaginacion(await provider.obtenerPagina(1));
    expect(provider.hayMas, isTrue);

    await provider.cargarMas();
    await provider.cargarMas();
    expect(provider.items, provider.fuente);
    expect(provider.hayMas, isFalse);

    await provider.cargarMas();
    expect(provider.paginasPedidas, [1, 2, 3]);
  });

  test('si cargarMas falla la página no avanza', () async {
    final provider = _ProviderFalso();
    provider.reiniciarPaginacion(await provider.obtenerPagina(1));

    provider.fallar = true;
    await expectLater(provider.cargarMas(), throwsStateError);
    expect(provider.items, [0, 1, 2, 3]);

    provider.fallar = false;
    await provider.cargarMas();
    expect(provider.paginasPedidas.last, 2);
    expect(provider.items.length, 8);
  });
}
