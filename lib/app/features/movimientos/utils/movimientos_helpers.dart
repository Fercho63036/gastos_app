import 'package:gastos_app/app/core/constants/formato_strings.dart';
import 'package:gastos_app/app/core/utils/formato_helpers.dart';

import 'package:gastos_app/app/shared/constants/dominio_constants.dart';
import 'package:gastos_app/app/shared/models/edicion_movimiento_model.dart';
import 'package:gastos_app/app/shared/models/fila_resumen_model.dart';
import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/utils/resumen_helpers.dart';

import '../constants/movimientos_strings.dart';

/// Validaciones y textos de las pantallas de gasto y entrada.
class MovimientosHelpers {
  MovimientosHelpers._();

  static String? validarMonto(int montoCentavos) =>
      montoCentavos < DominioConstants.montoMinimoCentavos
      ? MovimientosStrings.montoInvalido
      : null;

  static String? validarGasto(int montoCentavos, String descripcion) {
    if (descripcion.trim().isEmpty) return MovimientosStrings.descripcionVacia;
    return validarMonto(montoCentavos);
  }

  /// "Fecha y hora automáticas · 05/10/2026 13:20".
  static String textoFechaAutomatica(DateTime ahora) =>
      '${MovimientosStrings.fechaAutomatica}${FormatoStrings.separadorPunto}'
      '${FormatoHelpers.formatearFechaHora(ahora)}';

  static String textoSaldoDespues(int saldoCentavos) =>
      '${MovimientosStrings.saldoDespues}'
      '${FormatoHelpers.formatearMonto(saldoCentavos)}';

  static String tituloCodigo(Movimiento movimiento) =>
      '${MovimientosStrings.prefijoId}${movimiento.codigo}';

  /// "Registrado el 05/10/2026 a las 13:20 · no editable".
  static String textoRegistro(Movimiento movimiento) =>
      '${MovimientosStrings.registradoEl}'
      '${FormatoHelpers.formatearFecha(movimiento.fecha)}'
      '${MovimientosStrings.aLas}${FormatoHelpers.formatearHora(movimiento.fecha)}'
      '${FormatoStrings.separadorPunto}${MovimientosStrings.noEditable}';

  /// "05/10/2026 · 13:45".
  static String fechaEdicion(EdicionMovimiento edicion) =>
      '${FormatoHelpers.formatearFecha(edicion.fecha)}'
      '${FormatoStrings.separadorPunto}${FormatoHelpers.formatearHora(edicion.fecha)}';

  static List<FilaResumen> filasResumenEntrada(
    int saldoCentavos,
    int entradaCentavos,
  ) {
    return [
      FilaResumen(
        etiqueta: MovimientosStrings.saldoActual,
        valor: FormatoHelpers.formatearMonto(saldoCentavos),
      ),
      FilaResumen(
        etiqueta: MovimientosStrings.entrada,
        valor:
            '${FormatoStrings.signoPositivo}'
            '${FormatoHelpers.formatearMonto(entradaCentavos)}',
        estilo: EstiloFilaResumen.positivo,
      ),
      FilaResumen(
        etiqueta: MovimientosStrings.nuevoSaldo,
        valor: FormatoHelpers.formatearMonto(
          ResumenHelpers.saldoDespuesDeEntrada(saldoCentavos, entradaCentavos),
        ),
        estilo: EstiloFilaResumen.destacado,
        divisorAntes: true,
      ),
    ];
  }
}
