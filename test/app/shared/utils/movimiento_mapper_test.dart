import 'package:flutter_test/flutter_test.dart';

import 'package:gastos_app/app/core/constants/database_constants.dart';

import 'package:gastos_app/app/shared/models/categoria_movimiento.dart';
import 'package:gastos_app/app/shared/models/edicion_movimiento_model.dart';
import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/models/periodo_mes_model.dart';
import 'package:gastos_app/app/shared/utils/movimiento_mapper.dart';

void main() {
  final fecha = DateTime(2026, 10, 5, 13, 20);

  test('movimiento: ida y vuelta conserva los datos y arma el código', () {
    final entrada = Movimiento(
      id: '',
      titulo: 'Mesada',
      categoria: CategoriaMovimiento.entrada,
      montoCentavos: 20000,
      fecha: fecha,
      esEntrada: true,
    );
    final fila = {
      ...MovimientoMapper.aFila(entrada),
      DatabaseConstants.colId: 7,
    };
    final edicion = EdicionMovimiento(
      campo: 'Monto',
      valorAnterior: 'Bs 1,00',
      valorNuevo: 'Bs 2,00',
      fecha: fecha,
    );
    final leido = MovimientoMapper.desdeFila(fila, [edicion]);

    expect(leido.id, '7');
    expect(leido.codigo, 'E-0007');
    expect(leido.titulo, 'Mesada');
    expect(leido.categoria, CategoriaMovimiento.entrada);
    expect(leido.montoCentavos, 20000);
    expect(leido.fecha, fecha);
    expect(leido.esEntrada, isTrue);
    expect(leido.anulado, isFalse);
    expect(leido.ediciones.single.valorNuevo, 'Bs 2,00');
  });

  test('edición y periodo: ida y vuelta', () {
    final edicion = EdicionMovimiento(
      campo: 'Estado',
      valorAnterior: 'Activo',
      valorNuevo: 'Anulado',
      fecha: fecha,
    );
    final edicionLeida = MovimientoMapper.edicionDesdeFila(
      MovimientoMapper.edicionAFila(3, edicion),
    );
    expect(edicionLeida.campo, 'Estado');
    expect(edicionLeida.fecha, fecha);

    final periodo = PeriodoMes(
      inicio: fecha,
      arrastradoCentavos: 8500,
      montoMesCentavos: 190000,
      pisoCentavos: 5000,
    );
    final periodoLeido = MovimientoMapper.periodoDesdeFila(
      MovimientoMapper.periodoAFila(periodo),
    );
    expect(periodoLeido.inicio, fecha);
    expect(periodoLeido.saldoInicialCentavos, 198500);
    expect(periodoLeido.pisoCentavos, 5000);
  });
}
