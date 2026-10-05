import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/routes/route_names.dart';
import 'package:gastos_app/app/core/utils/responsive_helper.dart';

import 'package:gastos_app/app/shared/constants/comun_strings.dart';
import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/utils/snackbar_helpers.dart';
import 'package:gastos_app/app/shared/widgets/seleccion/grupo_chips_seleccion_widget.dart';
import 'package:gastos_app/app/shared/widgets/textos/mensaje_centrado_widget.dart';

import '../models/periodo_filtro.dart';
import '../providers/inicio_provider.dart';
import '../widgets/acciones/botones_accion_widget.dart';
import '../widgets/movimientos/lista_movimientos_widget.dart';
import '../widgets/resumen/tarjeta_saldo_widget.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  /// Las entradas aún no tienen pantalla de detalle.
  void _abrirMovimiento(Movimiento movimiento) {
    if (movimiento.esEntrada) {
      SnackbarHelpers.mostrar(context, ComunStrings.proximamente);
      return;
    }
    context.push(RouteNames.detalleGastoDe(movimiento.id));
  }

  Widget _buildCabeceraFija(InicioProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TarjetaSaldoWidget(resumen: provider.resumen),
        const SizedBox(height: AppDimensions.paddingM),
        BotonesAccionWidget(
          onGasto: () => context.push(RouteNames.nuevoGasto),
          onEntrada: () => context.push(RouteNames.nuevaEntrada),
        ),
        const SizedBox(height: AppDimensions.paddingL),
        GrupoChipsSeleccionWidget<PeriodoFiltro>(
          opciones: PeriodoFiltro.values,
          seleccionado: provider.periodoSeleccionado,
          etiquetaDe: (periodo) => periodo.etiqueta,
          onSeleccionar: provider.seleccionarPeriodo,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<InicioProvider>().cargar();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<InicioProvider>();
    final error = provider.error;
    if (error != null) return MensajeCentradoWidget(mensaje: error);

    final padding = ResponsiveHelper.paddingAll(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: padding.copyWith(bottom: AppDimensions.paddingM),
          child: _buildCabeceraFija(provider),
        ),
        Expanded(
          child: ListaMovimientosWidget(
            key: ValueKey(provider.periodoSeleccionado),
            grupos: provider.gruposVisibles,
            hayMas: provider.hayMas,
            onRefrescar: provider.cargar,
            onCargarMas: provider.cargarMas,
            onSeleccionar: _abrirMovimiento,
          ),
        ),
      ],
    );
  }
}
