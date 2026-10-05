import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:gastos_app/app/shared/models/estado_movimiento.dart';
import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/utils/navegacion_helpers.dart';
import 'package:gastos_app/app/shared/utils/snackbar_helpers.dart';
import 'package:gastos_app/app/shared/widgets/estructura/pagina_formulario_widget.dart';
import 'package:gastos_app/app/shared/widgets/formularios/campo_etiquetado_widget.dart';
import 'package:gastos_app/app/shared/widgets/formularios/campo_texto_widget.dart';
import 'package:gastos_app/app/shared/widgets/seleccion/selector_segmentado_widget.dart';
import 'package:gastos_app/app/shared/widgets/tarjetas/nota_icono_widget.dart';
import 'package:gastos_app/app/shared/widgets/textos/mensaje_centrado_widget.dart';

import '../constants/movimientos_strings.dart';
import '../providers/detalle_gasto_provider.dart';
import '../utils/movimientos_helpers.dart';
import '../widgets/detalle/fila_monto_categoria_widget.dart';
import '../widgets/detalle/historial_ediciones_widget.dart';

class DetalleGastoPage extends StatelessWidget {
  const DetalleGastoPage({super.key});

  void _guardar(BuildContext context, DetalleGastoProvider provider) {
    final error = provider.guardarCambios();
    SnackbarHelpers.mostrar(
      context,
      error ?? MovimientosStrings.cambiosGuardados,
    );
    if (error == null) NavegacionHelpers.volver(context);
  }

  List<Widget> _buildCampos(DetalleGastoProvider provider, Movimiento gasto) {
    return [
      NotaIconoWidget(
        icono: CupertinoIcons.lock,
        titulo: MovimientosHelpers.tituloCodigo(gasto),
        texto: MovimientosHelpers.textoRegistro(gasto),
      ),
      FilaMontoCategoriaWidget(
        montoController: provider.montoController,
        categoria: provider.categoria,
        onCategoria: provider.seleccionarCategoria,
      ),
      CampoEtiquetadoWidget(
        etiqueta: MovimientosStrings.descripcion,
        child: CampoTextoWidget(controller: provider.descripcionController),
      ),
      CampoEtiquetadoWidget(
        etiqueta: MovimientosStrings.estado,
        ayuda: MovimientosStrings.ayudaAnulado,
        child: SelectorSegmentadoWidget<EstadoMovimiento>(
          opciones: EstadoMovimiento.values,
          seleccionado: provider.estado,
          etiquetaDe: (estado) => estado.etiqueta,
          onSeleccionar: provider.seleccionarEstado,
        ),
      ),
      HistorialEdicionesWidget(ediciones: gasto.ediciones),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DetalleGastoProvider>();
    final gasto = provider.gasto;
    if (gasto == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const MensajeCentradoWidget(
          mensaje: MovimientosStrings.gastoNoEncontrado,
        ),
      );
    }

    return PaginaFormularioWidget(
      titulo: MovimientosStrings.detalleGasto,
      textoBoton: MovimientosStrings.guardarCambios,
      onConfirmar: () => _guardar(context, provider),
      children: _buildCampos(provider, gasto),
    );
  }
}
