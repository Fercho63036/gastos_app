/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:pull_to_refresh/pull_to_refresh.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/paginado/constants/base_main_list_strings.dart';

/************************ PIE CARGA PAGINADO WIDGET *************************/
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
