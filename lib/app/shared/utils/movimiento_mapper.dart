import 'package:gastos_app/app/core/constants/database_constants.dart';

import '../constants/dominio_strings.dart';
import '../models/campo_edicion.dart';
import '../models/categoria_movimiento.dart';
import '../models/edicion_movimiento_model.dart';
import '../models/movimiento_model.dart';
import '../models/periodo_mes_model.dart';
import 'codigo_helpers.dart';

typedef Fila = Map<String, Object?>;

/// Conversión pura entre filas de SQLite y modelos del dominio.
class MovimientoMapper {
  MovimientoMapper._();

  static int _aEntero(bool valor) =>
      valor ? DatabaseConstants.verdadero : DatabaseConstants.falso;

  static bool _aBool(Object? valor) => valor == DatabaseConstants.verdadero;

  static DateTime _aFecha(Object? valor) => DateTime.parse(valor as String);

  /// El código ("G-0007" o "E-0008") sale del id autoincremental.
  static String codigoDe(int id, {required bool esEntrada}) =>
      CodigoHelpers.formatear(
        esEntrada ? DominioStrings.prefijoEntrada : DominioStrings.prefijoGasto,
        id,
      );

  static Movimiento conId(Movimiento movimiento, int id) => movimiento.copyWith(
    id: id.toString(),
    codigo: codigoDe(id, esEntrada: movimiento.esEntrada),
  );

  /// Sin la columna id: SQLite la asigna al insertar.
  static Fila aFila(Movimiento movimiento) => {
    DatabaseConstants.colTitulo: movimiento.titulo,
    DatabaseConstants.colCategoria: movimiento.categoria.name,
    DatabaseConstants.colMontoCentavos: movimiento.montoCentavos,
    DatabaseConstants.colFecha: movimiento.fecha.toIso8601String(),
    DatabaseConstants.colAnulado: _aEntero(movimiento.anulado),
    DatabaseConstants.colEsEntrada: _aEntero(movimiento.esEntrada),
  };

  static Movimiento desdeFila(Fila fila, List<EdicionMovimiento> ediciones) {
    final id = fila[DatabaseConstants.colId] as int;
    final esEntrada = _aBool(fila[DatabaseConstants.colEsEntrada]);
    return Movimiento(
      id: id.toString(),
      codigo: codigoDe(id, esEntrada: esEntrada),
      titulo: fila[DatabaseConstants.colTitulo] as String,
      categoria: CategoriaMovimiento.values.byName(
        fila[DatabaseConstants.colCategoria] as String,
      ),
      montoCentavos: fila[DatabaseConstants.colMontoCentavos] as int,
      fecha: _aFecha(fila[DatabaseConstants.colFecha]),
      anulado: _aBool(fila[DatabaseConstants.colAnulado]),
      esEntrada: esEntrada,
      ediciones: ediciones,
    );
  }

  static Fila edicionAFila(int movimientoId, EdicionMovimiento edicion) => {
    DatabaseConstants.colMovimientoId: movimientoId,
    DatabaseConstants.colCampo: edicion.campo.name,
    DatabaseConstants.colValorAnterior: edicion.valorAnterior,
    DatabaseConstants.colValorNuevo: edicion.valorNuevo,
    DatabaseConstants.colFecha: edicion.fecha.toIso8601String(),
  };

  static EdicionMovimiento edicionDesdeFila(Fila fila) => EdicionMovimiento(
    campo: CampoEdicion.values.byName(
      fila[DatabaseConstants.colCampo] as String,
    ),
    valorAnterior: fila[DatabaseConstants.colValorAnterior] as String,
    valorNuevo: fila[DatabaseConstants.colValorNuevo] as String,
    fecha: _aFecha(fila[DatabaseConstants.colFecha]),
  );

  static Fila periodoAFila(PeriodoMes periodo) => {
    DatabaseConstants.colInicio: periodo.inicio.toIso8601String(),
    DatabaseConstants.colArrastradoCentavos: periodo.arrastradoCentavos,
    DatabaseConstants.colMontoMesCentavos: periodo.montoMesCentavos,
    DatabaseConstants.colPisoCentavos: periodo.pisoCentavos,
  };

  static PeriodoMes periodoDesdeFila(Fila fila) => PeriodoMes(
    inicio: _aFecha(fila[DatabaseConstants.colInicio]),
    arrastradoCentavos: fila[DatabaseConstants.colArrastradoCentavos] as int,
    montoMesCentavos: fila[DatabaseConstants.colMontoMesCentavos] as int,
    pisoCentavos: fila[DatabaseConstants.colPisoCentavos] as int,
  );
}
