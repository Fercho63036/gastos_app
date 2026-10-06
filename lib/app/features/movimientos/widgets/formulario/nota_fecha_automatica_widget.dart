/****************************** FLUTTER / DART ******************************/
import 'package:flutter/cupertino.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/widgets/tarjetas/nota_icono_widget.dart';

/********************************* FEATURE **********************************/
import '../../utils/movimientos_helpers.dart';

/*********************** NOTA FECHA AUTOMATICA WIDGET ***********************/
class NotaFechaAutomaticaWidget extends StatelessWidget {
  const NotaFechaAutomaticaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NotaIconoWidget(
      icono: CupertinoIcons.clock,
      texto: MovimientosHelpers.textoFechaAutomatica(DateTime.now()),
    );
  }
}
