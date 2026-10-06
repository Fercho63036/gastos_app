/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/utils/responsive_helper.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/models/grupo_dia_model.dart';
import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/paginado/widgets/lista_paginada_scroll_widget.dart';

/********************************* FEATURE **********************************/
import '../../constants/inicio_strings.dart';
import 'grupo_dia_widget.dart';

/************************* LISTA MOVIMIENTOS WIDGET *************************/
class ListaMovimientosWidget extends StatelessWidget {
  final List<GrupoDia<Movimiento>> grupos;
  final bool hayMas;
  final Future<void> Function() onRefrescar;
  final Future<void> Function() onCargarMas;
  final ValueChanged<Movimiento> onSeleccionar;

  const ListaMovimientosWidget({
    super.key,
    required this.grupos,
    required this.hayMas,
    required this.onRefrescar,
    required this.onCargarMas,
    required this.onSeleccionar,
  });

  @override
  Widget build(BuildContext context) {
    final espacioLateral = ResponsiveHelper.spacing(
      context,
      AppDimensions.paddingM,
    );

    return ListaPaginadaScrollWidget<GrupoDia<Movimiento>>(
      items: grupos,
      itemBuilder: (context, grupo) =>
          GrupoDiaWidget(grupo: grupo, onSeleccionar: onSeleccionar),
      hayMas: hayMas,
      onRefrescar: onRefrescar,
      onCargarMas: onCargarMas,
      mensajeVacio: InicioStrings.sinMovimientos,
      textoSinMas: InicioStrings.sinMasMovimientos,
      padding: EdgeInsets.symmetric(horizontal: espacioLateral),
    );
  }
}
