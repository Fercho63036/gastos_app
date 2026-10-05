import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/constants/formato_strings.dart';

import 'package:gastos_app/app/shared/utils/navegacion_helpers.dart';
import 'package:gastos_app/app/shared/utils/snackbar_helpers.dart';
import 'package:gastos_app/app/shared/widgets/estructura/pagina_formulario_widget.dart';
import 'package:gastos_app/app/shared/widgets/formularios/campo_etiquetado_widget.dart';
import 'package:gastos_app/app/shared/widgets/formularios/campo_monto_grande_widget.dart';
import 'package:gastos_app/app/shared/widgets/formularios/campo_texto_widget.dart';
import 'package:gastos_app/app/shared/widgets/tarjetas/tarjeta_resumen_widget.dart';

import '../constants/movimientos_strings.dart';
import '../providers/nueva_entrada_provider.dart';
import '../widgets/formulario/nota_fecha_automatica_widget.dart';

class NuevaEntradaPage extends StatelessWidget {
  const NuevaEntradaPage({super.key});

  Future<void> _registrar(
    BuildContext context,
    NuevaEntradaProvider provider,
  ) async {
    final error = await provider.registrar();
    if (!context.mounted) return;
    SnackbarHelpers.mostrar(
      context,
      error ?? MovimientosStrings.entradaRegistrada,
    );
    if (error == null) NavegacionHelpers.volver(context);
  }

  Widget _buildMotivo(NuevaEntradaProvider provider) {
    return CampoEtiquetadoWidget(
      etiqueta: MovimientosStrings.motivo,
      etiquetaSecundaria: MovimientosStrings.opcional,
      child: CampoTextoWidget(
        controller: provider.motivoController,
        hint: MovimientosStrings.hintMotivo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NuevaEntradaProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    return PaginaFormularioWidget(
      titulo: MovimientosStrings.nuevaEntrada,
      textoBoton: MovimientosStrings.registrarEntrada,
      onConfirmar: () => _registrar(context, provider),
      cargando: provider.guardando,
      children: [
        const Text(
          MovimientosStrings.introEntrada,
          style: TextStyle(fontSize: AppDimensions.fontS),
        ),
        CampoMontoGrandeWidget(
          etiqueta: MovimientosStrings.montoEntrada,
          prefijo: '${FormatoStrings.signoPositivo}${FormatoStrings.moneda}',
          colorPrefijo: colorScheme.tertiary,
          controller: provider.montoController,
          hint: MovimientosStrings.hintMonto,
        ),
        _buildMotivo(provider),
        const NotaFechaAutomaticaWidget(),
        TarjetaResumenWidget(filas: provider.filasResumen),
      ],
    );
  }
}
