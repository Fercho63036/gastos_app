import 'package:flutter/cupertino.dart';

import 'package:gastos_app/app/shared/widgets/tarjetas/nota_icono_widget.dart';

import '../../utils/movimientos_helpers.dart';

/// Avisa que el movimiento se fecha solo, con la fecha y hora de ahora.
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
