/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/theme/app_colores.dart';
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
    final colorAtenuado = estilo?.color?.withValues(
      alpha: AppColores.opacidadTextoAtenuado,
    ) ?? Colors.black.withValues(
      alpha: AppColores.opacidadTextoAtenuado,
    );
    return Text(
      '${InicioStrings.montoInicial}: $monto',
      style: estilo?.copyWith(
        fontWeight: FontWeight.w500,
        color: colorAtenuado,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
