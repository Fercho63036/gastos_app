import '../../constants/dominio_constants.dart';
import '../../constants/dominio_strings.dart';
import '../../models/categoria_movimiento.dart';
import '../../models/movimiento_model.dart';
import '../../models/periodo_mes_model.dart';

/// Movimientos de ejemplo: los de la captura primero y luego otros generados
/// hacia atrás, día por día, para poder probar la carga por páginas.
class MovimientosEjemploMock {
  MovimientosEjemploMock._();

  static const List<int> _montosEjemploCentavos = [450, 1200, 350, 600, 900];

  /// El periodo de ejemplo empieza el día del movimiento más antiguo.
  static PeriodoMes periodo(DateTime hoy) {
    final inicio = hoy.subtract(
      const Duration(days: DominioConstants.diasDeEjemploMock),
    );
    return PeriodoMes(
      inicio: DateTime(inicio.year, inicio.month, inicio.day),
      arrastradoCentavos: DominioConstants.arrastradoEjemploCentavos,
      montoMesCentavos: DominioConstants.montoMesEjemploCentavos,
      pisoCentavos: DominioConstants.pisoEjemploCentavos,
    );
  }

  /// Sin movimientos posteriores a [hoy]: no deben contar en un mes que se
  /// inicie ahora.
  static List<Movimiento> generar(DateTime hoy) {
    final ayer = hoy.subtract(const Duration(days: 1));
    final todos = [
      ..._movimientosDeHoy(hoy),
      ..._generadosDelDia(hoy, 0),
      _cine(ayer),
      for (var dia = 1; dia <= DominioConstants.diasDeEjemploMock; dia++)
        ..._generadosDelDia(hoy.subtract(Duration(days: dia)), dia),
    ];
    return todos.where((mov) => !mov.fecha.isAfter(hoy)).toList();
  }

  static List<Movimiento> _movimientosDeHoy(DateTime hoy) => [
    _crear(
      'almuerzo',
      'Almuerzo',
      CategoriaMovimiento.comida,
      2500,
      DateTime(hoy.year, hoy.month, hoy.day, 13, 20),
    ),
    _crear(
      'micro',
      'Micro a la U',
      CategoriaMovimiento.pasajes,
      300,
      DateTime(hoy.year, hoy.month, hoy.day, 7, 45),
    ),
    _crear(
      'cafe',
      'Café',
      CategoriaMovimiento.comida,
      800,
      DateTime(hoy.year, hoy.month, hoy.day, 10, 10),
      anulado: true,
    ),
  ];

  static Movimiento _cine(DateTime ayer) => _crear(
    'cine',
    'Cine',
    CategoriaMovimiento.diversion,
    4500,
    DateTime(ayer.year, ayer.month, ayer.day, 20, 30),
  );

  /// Del más tarde al más temprano, para que el día se lea de arriba abajo.
  static List<Movimiento> _generadosDelDia(DateTime fecha, int diasAtras) {
    const cantidad = DominioConstants.movimientosPorDiaMock;
    return [
      for (var orden = cantidad - 1; orden >= 0; orden--)
        _generado(fecha, diasAtras * cantidad + orden, orden),
    ];
  }

  static int _horaDe(int orden) =>
      DominioConstants.horaInicialMock +
      orden * DominioConstants.horasEntreMovimientosMock;

  static Movimiento _generado(DateTime fecha, int semilla, int orden) {
    const titulos = DominioStrings.titulosEjemploMock;
    const categorias = CategoriaMovimiento.deGasto;
    return _crear(
      'generado_$semilla',
      titulos[semilla % titulos.length],
      categorias[semilla % categorias.length],
      _montosEjemploCentavos[semilla % _montosEjemploCentavos.length],
      DateTime(fecha.year, fecha.month, fecha.day, _horaDe(orden)),
    );
  }

  static Movimiento _crear(
    String id,
    String titulo,
    CategoriaMovimiento categoria,
    int montoCentavos,
    DateTime fecha, {
    bool anulado = false,
  }) {
    return Movimiento(
      id: id,
      titulo: titulo,
      categoria: categoria,
      montoCentavos: montoCentavos,
      fecha: fecha,
      anulado: anulado,
    );
  }
}
