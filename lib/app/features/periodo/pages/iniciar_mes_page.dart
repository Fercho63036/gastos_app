/****************************** FLUTTER / DART ******************************/
import 'package:flutter/cupertino.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:provider/provider.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/utils/formato_helpers.dart';
import 'package:gastos_app/app/core/utils/monto_input_formatter.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/utils/navegacion_helpers.dart';
import 'package:gastos_app/app/shared/utils/snackbar_helpers.dart';
import 'package:gastos_app/app/shared/widgets/estructura/pagina_formulario_widget.dart';
import 'package:gastos_app/app/shared/widgets/formularios/campo_etiquetado_widget.dart';
import 'package:gastos_app/app/shared/widgets/formularios/campo_texto_widget.dart';
import 'package:gastos_app/app/shared/widgets/tarjetas/tarjeta_etiqueta_valor_widget.dart';
import 'package:gastos_app/app/shared/widgets/tarjetas/tarjeta_resumen_widget.dart';
import 'package:gastos_app/app/shared/widgets/textos/encabezado_icono_widget.dart';

/********************************* FEATURE **********************************/
import '../constants/periodo_strings.dart';
import '../providers/iniciar_mes_provider.dart';

class IniciarMesPage extends StatelessWidget {
  const IniciarMesPage({super.key});

  static const TextStyle _estiloMontoMes = TextStyle(
    fontSize: AppDimensions.fontPrefijoMonto,
    fontWeight: FontWeight.w800,
  );

  Future<void> _iniciar(
    BuildContext context,
    IniciarMesProvider provider,
  ) async {
    final error = await provider.iniciar();
    if (!context.mounted) return;
    SnackbarHelpers.mostrar(context, error ?? PeriodoStrings.mesIniciado);
    if (error == null) NavegacionHelpers.volver(context);
  }

  Widget _buildCampoMonto(
    String etiqueta,
    TextEditingController controller, {
    TextStyle? estilo,
    String? ayuda,
  }) {
    return CampoEtiquetadoWidget(
      etiqueta: etiqueta,
      ayuda: ayuda,
      child: CampoTextoWidget(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: const [MontoInputFormatter()],
        estilo: estilo,
      ),
    );
  }

  Widget _buildArrastre(IniciarMesProvider provider) {
    return TarjetaEtiquetaValorWidget(
      titulo: PeriodoStrings.saldoArrastra,
      subtitulo: provider.textoSobrante,
      valor: FormatoHelpers.formatearMonto(provider.arrastradoCentavos),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<IniciarMesProvider>();

    return PaginaFormularioWidget(
      titulo: PeriodoStrings.iniciarMes,
      textoBoton: PeriodoStrings.iniciarMes,
      onConfirmar: () => _iniciar(context, provider),
      cargando: provider.guardando,
      children: [
        EncabezadoIconoWidget(
          icono: CupertinoIcons.calendar,
          titulo: provider.tituloMes,
          subtitulo: PeriodoStrings.inicioManual,
        ),
        _buildArrastre(provider),
        _buildCampoMonto(
          PeriodoStrings.montoMesBs,
          provider.montoController,
          estilo: _estiloMontoMes,
        ),
        _buildCampoMonto(
          PeriodoStrings.pisoBs,
          provider.pisoController,
          ayuda: PeriodoStrings.ayudaPiso,
        ),
        TarjetaResumenWidget(filas: provider.filasResumen),
      ],
    );
  }
}
