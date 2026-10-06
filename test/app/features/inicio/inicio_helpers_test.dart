import 'package:flutter_test/flutter_test.dart';

import 'package:gastos_app/app/core/utils/formato_helpers.dart';

import 'package:gastos_app/app/shared/models/categoria_movimiento.dart';
import 'package:gastos_app/app/shared/models/resumen_mes_model.dart';

import 'package:gastos_app/app/features/inicio/constants/inicio_constants.dart';
import 'package:gastos_app/app/features/inicio/models/periodo_filtro.dart';
import 'package:gastos_app/app/features/inicio/services/inicio_service.dart';

import 'package:gastos_app/app/features/inicio/utils/inicio_helpers.dart';

import '../../../helpers/movimientos_almacen_fake.dart';
import '../../../helpers/movimientos_servicio_prueba.dart';

void main() {
  final hoy = DateTime(2026, 10, 5, 15);

  test('porcentajeDisponible redondea y no pasa de 100', () {
    const resumen = ResumenMes(
      saldoCentavos: 124550,
      gastableCentavos: 119550,
      gastableTotalCentavos: 192800,
      pisoCentavos: 5000,
      entradasCentavos: 0,
      gastadoCentavos: 68250,
      montoInicialCentavos: 197800,
    );
    expect(InicioHelpers.porcentajeDisponible(resumen), 62);
    expect(InicioHelpers.porcentajeDisponible(ResumenMes.vacio), 0);
  });

  test('desdeDePeriodo', () {
    expect(
      InicioHelpers.desdeDePeriodo(PeriodoFiltro.hoy, hoy),
      DateTime(2026, 10, 5),
    );
    expect(
      InicioHelpers.desdeDePeriodo(PeriodoFiltro.semana, hoy),
      DateTime(2026, 9, 29),
    );
    expect(
      InicioHelpers.desdeDePeriodo(PeriodoFiltro.mes, hoy),
      DateTime(2026, 10),
    );
  });

  test('pagina por periodo solo lo registrado', () async {
    final datos = servicioDePrueba(MovimientosAlmacenFake());
    final servicio = InicioService(datos);
    final vacio = await servicio.obtenerMovimientos(
      periodo: PeriodoFiltro.hoy,
      pagina: 1,
    );
    expect(vacio.total, 0);

    const cantidad = InicioConstants.movimientosPorPagina + 1;
    for (var numero = 0; numero < cantidad; numero++) {
      await datos.registrarGasto(
        titulo: 'Gasto $numero',
        categoria: CategoriaMovimiento.comida,
        montoCentavos: 100,
      );
    }
    final hoy = await servicio.obtenerMovimientos(
      periodo: PeriodoFiltro.hoy,
      pagina: 1,
    );
    expect(hoy.datos.length, InicioConstants.movimientosPorPagina);
    expect(hoy.total, cantidad);
    final inicioHoy = FormatoHelpers.soloDia(DateTime.now());
    expect(
      hoy.datos.every((mov) => FormatoHelpers.soloDia(mov.fecha) == inicioHoy),
      isTrue,
    );
  });
}
