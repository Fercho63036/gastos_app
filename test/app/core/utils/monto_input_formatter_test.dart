import 'package:flutter_test/flutter_test.dart';

import 'package:gastos_app/app/core/utils/monto_input_formatter.dart';

String _escribir(String anterior, String nuevo) => const MontoInputFormatter()
    .formatEditUpdate(
      TextEditingValue(text: anterior),
      TextEditingValue(text: nuevo),
    )
    .text;

void main() {
  test('los dígitos entran por los centavos', () {
    expect(_escribir('', '2'), '0,02');
    expect(_escribir('0,02', '0,025'), '0,25');
    expect(_escribir('25,00', '25,000'), '250,00');
    expect(_escribir('', '120000'), '1.200,00');
  });

  test('borrar todo deja el campo vacío y se ignoran letras', () {
    expect(_escribir('0,02', '0,0'), '');
    expect(_escribir('', 'abc'), '');
  });

  test('no pasa del máximo de dígitos', () {
    expect(_escribir('9.999.999,99', '9.999.999,999'), '9.999.999,99');
  });
}
