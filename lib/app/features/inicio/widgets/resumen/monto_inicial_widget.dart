/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/utils/formato_helpers.dart';

/********************************* FEATURE **********************************/
import '../../constants/inicio_strings.dart';

class MontoInicialWidget extends StatelessWidget {
  /******************************** PROPIEDADES ********************************/
  final int montoInicialCentavos;
  final TextStyle? estilo;

  /******************************** CONSTRUCTOR ********************************/
  const MontoInicialWidget({
    super.key,
    required this.montoInicialCentavos,
    this.estilo,
  });

  /************************************ BUILD ************************************/
  @override
  Widget build(BuildContext context) {
    final monto = FormatoHelpers.formatearMonto(montoInicialCentavos);
    return Text(
      '${InicioStrings.montoInicial}: $monto',
      style: estilo?.copyWith(fontWeight: FontWeight.w500),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
