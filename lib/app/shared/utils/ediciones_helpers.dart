/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/utils/formato_helpers.dart';

/********************************** SHARED **********************************/
import '../constants/dominio_strings.dart';
import '../models/campo_edicion.dart';
import '../models/categoria_movimiento.dart';
import '../models/edicion_movimiento_model.dart';
import '../models/estado_movimiento.dart';
import '../models/movimiento_model.dart';

/**************************** EDICIONES HELPERS *****************************/
class EdicionesHelpers {
  EdicionesHelpers._();

  static String _entreComillas(String texto) =>
      '${DominioStrings.comillaApertura}$texto${DominioStrings.comillaCierre}';

  /******************************* VALOR CRUDO ********************************/
  static String valorCrudo(Movimiento movimiento, CampoEdicion campo) =>
      switch (campo) {
        CampoEdicion.monto => movimiento.montoCentavos.toString(),
        CampoEdicion.descripcion => movimiento.titulo,
        CampoEdicion.categoria => movimiento.categoria.name,
        CampoEdicion.estado => movimiento.estado.name,
      };

  /***************************** FORMATEAR VALOR ******************************/
  static String formatearValor(CampoEdicion campo, String valor) =>
      switch (campo) {
        CampoEdicion.monto => _formatearMonto(valor),
        CampoEdicion.descripcion => _entreComillas(valor),
        CampoEdicion.categoria => _nombreCategoria(valor),
        CampoEdicion.estado => _etiquetaEstado(valor),
      };

  static String _formatearMonto(String valor) {
    final centavos = int.tryParse(valor);
    return centavos == null ? valor : FormatoHelpers.formatearMonto(centavos);
  }

  static String _nombreCategoria(String valor) {
    for (final categoria in CategoriaMovimiento.values) {
      if (categoria.name == valor) return categoria.nombre;
    }
    return valor;
  }

  static String _etiquetaEstado(String valor) {
    for (final estado in EstadoMovimiento.values) {
      if (estado.name == valor) return estado.etiqueta;
    }
    return valor;
  }

  static List<EdicionMovimiento> diferencias(
    Movimiento original,
    Movimiento editado,
    DateTime fecha,
  ) {
    return [
      for (final campo in CampoEdicion.values)
        if (valorCrudo(original, campo) != valorCrudo(editado, campo))
          EdicionMovimiento(
            campo: campo,
            valorAnterior: valorCrudo(original, campo),
            valorNuevo: valorCrudo(editado, campo),
            fecha: fecha,
          ),
    ];
  }

  /******************************* HAY CAMBIOS ********************************/
  static bool hayCambios(Movimiento original, Movimiento editado) =>
      CampoEdicion.values.any(
        (campo) => valorCrudo(original, campo) != valorCrudo(editado, campo),
      );

  /******************************** DESCRIBIR *********************************/
  static String describir(EdicionMovimiento edicion) =>
      '${edicion.campo.etiqueta}${DominioStrings.separadorCampo}'
      '${formatearValor(edicion.campo, edicion.valorAnterior)}'
      '${DominioStrings.flechaCambio}'
      '${formatearValor(edicion.campo, edicion.valorNuevo)}';
}
