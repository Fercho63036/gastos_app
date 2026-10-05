import 'package:gastos_app/app/core/utils/formato_helpers.dart';

import '../constants/dominio_strings.dart';
import '../models/edicion_movimiento_model.dart';
import '../models/movimiento_model.dart';

/// Compara dos versiones de un movimiento y arma su historial de cambios.
class EdicionesHelpers {
  EdicionesHelpers._();

  static String _entreComillas(String texto) =>
      '${DominioStrings.comillaApertura}$texto${DominioStrings.comillaCierre}';

  /// (campo, antes, después) ya formateados para el historial.
  static List<(String, String, String)> _comparaciones(
    Movimiento original,
    Movimiento editado,
  ) {
    const monto = FormatoHelpers.formatearMonto;
    return [
      (
        DominioStrings.campoMonto,
        monto(original.montoCentavos),
        monto(editado.montoCentavos),
      ),
      (
        DominioStrings.campoDescripcion,
        _entreComillas(original.titulo),
        _entreComillas(editado.titulo),
      ),
      (
        DominioStrings.campoCategoria,
        original.categoria.nombre,
        editado.categoria.nombre,
      ),
      (
        DominioStrings.campoEstado,
        original.estado.etiqueta,
        editado.estado.etiqueta,
      ),
    ];
  }

  /// Si el texto formateado cambió, hubo edición en ese campo.
  static List<EdicionMovimiento> diferencias(
    Movimiento original,
    Movimiento editado,
    DateTime fecha,
  ) {
    return [
      for (final (campo, anterior, nuevo) in _comparaciones(original, editado))
        if (anterior != nuevo)
          EdicionMovimiento(
            campo: campo,
            valorAnterior: anterior,
            valorNuevo: nuevo,
            fecha: fecha,
          ),
    ];
  }

  /// "Monto: Bs 20,00 → Bs 25,00".
  static String describir(EdicionMovimiento edicion) =>
      '${edicion.campo}${DominioStrings.separadorCampo}'
      '${edicion.valorAnterior}${DominioStrings.flechaCambio}'
      '${edicion.valorNuevo}';
}
