import 'package:flutter_test/flutter_test.dart';

import 'package:gastos_app/app/core/utils/formato_helpers.dart';

import 'package:gastos_app/app/features/inicio/constants/inicio_constants.dart';
import 'package:gastos_app/app/features/inicio/models/categoria_movimiento.dart';
import 'package:gastos_app/app/features/inicio/models/movimiento_model.dart';
import 'package:gastos_app/app/features/inicio/models/periodo_filtro.dart';
import 'package:gastos_app/app/features/inicio/models/resumen_mes_model.dart';
import 'package:gastos_app/app/features/inicio/services/inicio_mock_service.dart';
import 'package:gastos_app/app/features/inicio/utils/inicio_helpers.dart';

Movimiento _movimiento(String id, DateTime fecha) => Movimiento(
  id: id,
  titulo: id,
  categoria: CategoriaMovimiento.comida,
  montoCentavos: 100,
  fecha: fecha,
);

void main() {
  final hoy = DateTime(2026, 10, 5, 15);

  test('porcentajeDisponible redondea y no pasa de 100', () {
    const resumen = ResumenMes(
      saldoCentavos: 124550,
      gastableCentavos: 119550,
      gastableTotalCentavos: 192800,
      pisoCentavos: 5000,
    );
    expect(InicioHelpers.porcentajeDisponible(resumen), 62);
    expect(InicioHelpers.porcentajeDisponible(ResumenMes.vacio), 0);
  });

  test('filtrarPorPeriodo', () {
    final movimientos = [
      _movimiento('hoy', DateTime(2026, 10, 5, 9)),
      _movimiento('ayer', DateTime(2026, 10, 4, 20)),
      _movimiento('mesPasado', DateTime(2026, 9, 30, 8)),
    ];
    final soloHoy = InicioHelpers.filtrarPorPeriodo(
      movimientos,
      PeriodoFiltro.hoy,
      hoy,
    );
    final delMes = InicioHelpers.filtrarPorPeriodo(
      movimientos,
      PeriodoFiltro.mes,
      hoy,
    );
    final semana = InicioHelpers.filtrarPorPeriodo(
      movimientos,
      PeriodoFiltro.semana,
      hoy,
    );
    expect(soloHoy.map((mov) => mov.id), ['hoy']);
    expect(delMes.map((mov) => mov.id), ['hoy', 'ayer']);
    expect(semana.length, 3);
  });

  test('el mock pagina por periodo', () async {
    final servicio = InicioMockService();
    final semana = await servicio.obtenerMovimientos(
      periodo: PeriodoFiltro.semana,
      pagina: 1,
    );
    expect(semana.datos.length, InicioConstants.movimientosPorPagina);
    expect(semana.total, greaterThan(InicioConstants.movimientosPorPagina));

    final soloHoy = await servicio.obtenerMovimientos(
      periodo: PeriodoFiltro.hoy,
      pagina: 1,
    );
    final inicioHoy = FormatoHelpers.soloDia(DateTime.now());
    expect(
      soloHoy.datos.every(
        (mov) => FormatoHelpers.soloDia(mov.fecha) == inicioHoy,
      ),
      isTrue,
    );
  });
}
