/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:provider/provider.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/utils/responsive_helper.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/widgets/seleccion/grupo_chips_seleccion_widget.dart';
import 'package:gastos_app/app/shared/widgets/textos/mensaje_centrado_widget.dart';

/********************************* FEATURE **********************************/
import '../../inicio/models/periodo_filtro.dart';
import '../constants/resumen_strings.dart';
import '../providers/resumen_provider.dart';
import '../widgets/grafico_barras_widget.dart';
import '../widgets/grafico_categorias_widget.dart';
import '../widgets/leyenda_categorias_widget.dart';

class ResumenPage extends StatefulWidget {
  const ResumenPage({super.key});

  @override
  State<ResumenPage> createState() => _ResumenPageState();
}

class _ResumenPageState extends State<ResumenPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<ResumenProvider>().cargar();
    });
  }

  /******************************** BUILD TITULO ********************************/
  Widget _buildTitulo(String texto) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimensions.paddingL,
        bottom: AppDimensions.paddingS,
      ),
      child: Text(texto, style: Theme.of(context).textTheme.titleMedium),
    );
  }

  /************************************ BUILD ************************************/
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ResumenProvider>();
    final error = provider.error;
    if (error != null) return MensajeCentradoWidget(mensaje: error);

    return SingleChildScrollView(
      padding: ResponsiveHelper.paddingAll(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GrupoChipsSeleccionWidget<PeriodoFiltro>(
            opciones: PeriodoFiltro.values,
            seleccionado: provider.periodoSeleccionado,
            etiquetaDe: (periodo) => periodo.etiqueta,
            onSeleccionar: provider.seleccionarPeriodo,
          ),
          if (provider.sinDatos && !provider.cargando)
            const Padding(
              padding: EdgeInsets.only(top: AppDimensions.paddingXL),
              child: MensajeCentradoWidget(
                mensaje: ResumenStrings.sinMovimientos,
              ),
            )
          else ...[
            _buildTitulo(ResumenStrings.porCategoria),
            GraficoCategoriasWidget(categorias: provider.categorias),
            const SizedBox(height: AppDimensions.paddingM),
            LeyendaCategoriasWidget(categorias: provider.categorias),
            _buildTitulo(ResumenStrings.porDia),
            GraficoBarrasWidget(puntos: provider.puntosBarras),
          ],
        ],
      ),
    );
  }
}
