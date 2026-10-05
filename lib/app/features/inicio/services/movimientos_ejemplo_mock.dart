import '../constants/inicio_constants.dart';
import '../constants/inicio_strings.dart';
import '../models/categoria_movimiento.dart';
import '../models/movimiento_model.dart';

/// Movimientos de ejemplo: los de la captura primero y luego otros generados
/// hacia atrás, día por día, para poder probar la carga por páginas.
class MovimientosEjemploMock {
  MovimientosEjemploMock._();

  static const List<int> _montosEjemploCentavos = [450, 1200, 350, 600, 900];

  static List<Movimiento> generar(DateTime hoy) {
    final ayer = hoy.subtract(const Duration(days: 1));
    return [
      ..._movimientosDeHoy(hoy),
      ..._generadosDelDia(hoy, 0),
      _cine(ayer),
      for (var dia = 1; dia <= InicioConstants.diasDeEjemploMock; dia++)
        ..._generadosDelDia(hoy.subtract(Duration(days: dia)), dia),
    ];
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
    const cantidad = InicioConstants.movimientosPorDiaMock;
    return [
      for (var orden = cantidad - 1; orden >= 0; orden--)
        _generado(fecha, diasAtras * cantidad + orden, orden),
    ];
  }

  static Movimiento _generado(DateTime fecha, int semilla, int orden) {
    const titulos = InicioStrings.titulosEjemploMock;
    const categorias = CategoriaMovimiento.values;
    final hora =
        InicioConstants.horaInicialMock +
        orden * InicioConstants.horasEntreMovimientosMock;
    return _crear(
      'generado_$semilla',
      titulos[semilla % titulos.length],
      categorias[semilla % categorias.length],
      _montosEjemploCentavos[semilla % _montosEjemploCentavos.length],
      DateTime(fecha.year, fecha.month, fecha.day, hora),
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
