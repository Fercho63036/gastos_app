/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/formato_strings.dart';
import 'package:gastos_app/app/core/utils/formato_helpers.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/constants/dominio_constants.dart';
import 'package:gastos_app/app/shared/models/edicion_movimiento_model.dart';
import 'package:gastos_app/app/shared/models/fila_resumen_model.dart';
import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/utils/resumen_helpers.dart';

/********************************* FEATURE **********************************/
import '../constants/movimientos_strings.dart';

/*************************** MOVIMIENTOS HELPERS ****************************/
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

  /************************** TEXTO FECHA AUTOMATICA **************************/
  static String textoFechaAutomatica(DateTime ahora) =>
      '${MovimientosStrings.fechaAutomatica}${FormatoStrings.separadorPunto}'
      '${FormatoHelpers.formatearFechaHora(ahora)}';

  static String textoSaldoDespues(int saldoCentavos) =>
      '${MovimientosStrings.saldoDespues}'
      '${FormatoHelpers.formatearMonto(saldoCentavos)}';

  static String tituloCodigo(Movimiento movimiento) =>
      '${MovimientosStrings.prefijoId}${movimiento.codigo}';

  /****************************** TEXTO REGISTRO ******************************/
  static String textoRegistro(Movimiento movimiento) =>
      '${MovimientosStrings.registradoEl}'
      '${FormatoHelpers.formatearFecha(movimiento.fecha)}'
      '${MovimientosStrings.aLas}${FormatoHelpers.formatearHora(movimiento.fecha)}'
      '${FormatoStrings.separadorPunto}${MovimientosStrings.noEditable}';

  /****************************** FECHA EDICION *******************************/
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
