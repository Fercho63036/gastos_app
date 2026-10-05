import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/shared/paginado/constants/base_main_list_strings.dart';

/// Pie de la lista que se muestra al llegar al final mientras carga más.
class PieCargaPaginadoWidget extends StatelessWidget {
  final String textoSinMas;

  const PieCargaPaginadoWidget({
    super.key,
    this.textoSinMas = BaseMainListStrings.sinMasElementos,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ClassicFooter(
      idleText: BaseMainListStrings.deslizaParaCargarMas,
      canLoadingText: BaseMainListStrings.sueltaParaCargarMas,
      loadingText: BaseMainListStrings.cargandoMas,
      noDataText: textoSinMas,
      failedText: BaseMainListStrings.reintentarCarga,
      textStyle: TextStyle(
        color: colorScheme.onSurface.withValues(
          alpha: AppDimensions.opacidadSecundaria,
        ),
        fontSize: AppDimensions.fontS,
      ),
    );
  }
}
