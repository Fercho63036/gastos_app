import 'package:flutter_test/flutter_test.dart';

import 'package:gastos_app/app/shared/dto/api_claves.dart';
import 'package:gastos_app/app/shared/dto/movimiento_dto.dart';
import 'package:gastos_app/app/shared/dto/pagina_dto.dart';
import 'package:gastos_app/app/shared/dto/periodo_dto.dart';
import 'package:gastos_app/app/shared/dto/resumen_dto.dart';
import 'package:gastos_app/app/shared/models/borrador_movimiento_model.dart';
import 'package:gastos_app/app/shared/models/campo_edicion.dart';
import 'package:gastos_app/app/shared/models/categoria_movimiento.dart';
import 'package:gastos_app/app/shared/models/edicion_movimiento_model.dart';
import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/models/periodo_mes_model.dart';
import 'package:gastos_app/app/shared/models/resumen_mes_model.dart';

import 'package:gastos_app/app/features/auth/dto/sesion_dto.dart';
import 'package:gastos_app/app/features/auth/models/sesion_model.dart';

void main() {
  final fecha = DateTime(2026, 10, 5, 13, 20);

  test('movimiento: ida y vuelta por JSON', () {
    final movimiento = Movimiento(
      id: '7',
      codigo: 'G-0007',
      titulo: 'Almuerzo',
      categoria: CategoriaMovimiento.comida,
      montoCentavos: 2500,
      fecha: fecha,
      anulado: true,
      ediciones: [
        EdicionMovimiento(
          campo: CampoEdicion.estado,
          valorAnterior: 'activo',
          valorNuevo: 'anulado',
          fecha: fecha,
        ),
      ],
    );
    final json = MovimientoDto.aJson(movimiento);
    final leido = MovimientoDto.desdeJson(json);

    expect(json[ApiClaves.categoria], 'comida');
    expect(json[ApiClaves.fecha], fecha.toUtc().toIso8601String());
    expect(leido.id, '7');
    expect(leido.codigo, 'G-0007');
    expect(leido.fecha, fecha);
    expect(leido.anulado, isTrue);
    expect(leido.ediciones.single.campo, CampoEdicion.estado);
  });

  test('el id numérico del servidor se lee como texto', () {
    final json = MovimientoDto.aJson(
      Movimiento(
        id: '',
        titulo: 'x',
        categoria: CategoriaMovimiento.otros,
        montoCentavos: 1,
        fecha: fecha,
      ),
    )..[ApiClaves.id] = 42;
    expect(MovimientoDto.desdeJson(json).id, '42');
  });

  test('borrador y cambios solo envían lo necesario', () {
    final borrador = MovimientoDto.borradorAJson(
      const BorradorMovimiento(
        titulo: 'Trabajo',
        categoria: CategoriaMovimiento.entrada,
        montoCentavos: 20000,
        esEntrada: true,
      ),
    );
    expect(borrador.keys, isNot(contains(ApiClaves.id)));
    expect(borrador[ApiClaves.esEntrada], isTrue);
  });

  test('periodo, resumen y página', () {
    final periodo = PeriodoMes(
      inicio: fecha,
      arrastradoCentavos: 8500,
      montoMesCentavos: 190000,
      pisoCentavos: 5000,
    );
    expect(
      PeriodoDto.desdeJson(PeriodoDto.aJson(periodo)).saldoInicialCentavos,
      198500,
    );

    const resumen = ResumenMes(
      saldoCentavos: 1,
      gastableCentavos: 2,
      gastableTotalCentavos: 3,
      pisoCentavos: 4,
      entradasCentavos: 5,
    );
    final resumenLeido = ResumenDto.desdeJson(ResumenDto.aJson(resumen));
    expect(resumenLeido.gastableTotalCentavos, 3);

    final pagina = PaginaDto.desdeJson<int>({
      ApiClaves.datos: [
        {'n': 1},
        {'n': 2},
      ],
      ApiClaves.total: 9,
    }, (json) => json['n'] as int);
    expect(pagina.datos, [1, 2]);
    expect(pagina.total, 9);
  });

  test('sesión: ida y vuelta por JSON', () {
    const sesion = SesionModel(token: 'abc', correo: 'a@b.co', nombre: 'Ana');
    final leida = SesionDto.desdeJson(SesionDto.aJson(sesion));
    expect(leida.token, 'abc');
    expect(leida.correo, 'a@b.co');
    expect(leida.nombre, 'Ana');
  });
}
