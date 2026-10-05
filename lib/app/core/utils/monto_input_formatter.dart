import 'package:flutter/services.dart';

import 'package:gastos_app/app/core/constants/formato_constants.dart';
import 'package:gastos_app/app/core/utils/formato_helpers.dart';

/// Escribe montos como cajero: cada dígito entra por los centavos
/// ("2" → "0,02", "2500" → "25,00") y se muestra con miles ("1.200,00").
class MontoInputFormatter extends TextInputFormatter {
  const MontoInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final centavos = FormatoHelpers.parsearMonto(newValue.text);
    final digitos = centavos.toString().length;
    if (digitos > FormatoConstants.digitosMaximosMonto) return oldValue;
    if (centavos == 0) return TextEditingValue.empty;
    final texto = FormatoHelpers.formatearNumero(centavos);
    return TextEditingValue(
      text: texto,
      selection: TextSelection.collapsed(offset: texto.length),
    );
  }
}
