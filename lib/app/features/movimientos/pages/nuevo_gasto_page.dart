import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:gastos_app/app/core/constants/formato_strings.dart';

import 'package:gastos_app/app/shared/models/categoria_movimiento.dart';
import 'package:gastos_app/app/shared/utils/navegacion_helpers.dart';
import 'package:gastos_app/app/shared/utils/snackbar_helpers.dart';
import 'package:gastos_app/app/shared/widgets/estructura/pagina_formulario_widget.dart';
import 'package:gastos_app/app/shared/widgets/formularios/campo_etiquetado_widget.dart';
import 'package:gastos_app/app/shared/widgets/formularios/campo_monto_grande_widget.dart';
import 'package:gastos_app/app/shared/widgets/formularios/campo_texto_widget.dart';
import 'package:gastos_app/app/shared/widgets/seleccion/cuadricula_seleccion_widget.dart';

import '../constants/movimientos_strings.dart';
import '../providers/nuevo_gasto_provider.dart';
import '../utils/movimientos_helpers.dart';
import '../widgets/formulario/nota_fecha_automatica_widget.dart';

class NuevoGastoPage extends StatelessWidget {
  const NuevoGastoPage({super.key});

  Future<void> _guardar(
    BuildContext context,
    NuevoGastoProvider provider,
  ) async {
    final error = await provider.guardar();
    if (!context.mounted) return;
    SnackbarHelpers.mostrar(
      context,
      error ?? MovimientosStrings.gastoRegistrado,
    );
    if (error == null) NavegacionHelpers.volver(context);
  }

  Widget _buildCategorias(NuevoGastoProvider provider) {
    return CampoEtiquetadoWidget(
      etiqueta: MovimientosStrings.categoria,
      child: CuadriculaSeleccionWidget<CategoriaMovimiento>(
        opciones: CategoriaMovimiento.deGasto,
        seleccionado: provider.categoria,
        etiquetaDe: (categoria) => categoria.nombre,
        iconoDe: (categoria) => categoria.icono,
        onSeleccionar: provider.seleccionarCategoria,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NuevoGastoProvider>();

    return PaginaFormularioWidget(
      titulo: MovimientosStrings.nuevoGasto,
      textoBoton: MovimientosStrings.guardarGasto,
      onConfirmar: () => _guardar(context, provider),
      cargando: provider.guardando,
      children: [
        CampoMontoGrandeWidget(
          etiqueta: MovimientosStrings.monto,
          prefijo: FormatoStrings.moneda,
          colorPrefijo: Theme.of(context).colorScheme.primary,
          controller: provider.montoController,
          hint: MovimientosStrings.hintMonto,
          subtitulo: MovimientosHelpers.textoSaldoDespues(
            provider.saldoDespuesCentavos,
          ),
        ),
        CampoEtiquetadoWidget(
          etiqueta: MovimientosStrings.descripcion,
          child: CampoTextoWidget(
            controller: provider.descripcionController,
            hint: MovimientosStrings.hintDescripcion,
          ),
        ),
        _buildCategorias(provider),
        const NotaFechaAutomaticaWidget(),
      ],
    );
  }
}
