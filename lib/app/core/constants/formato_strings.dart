/// Textos de formato (moneda, separadores y fechas) compartidos por toda la app.
class FormatoStrings {
  FormatoStrings._();

  static const String moneda = 'Bs';
  static const String signoNegativo = '−';
  static const String signoPositivo = '+';
  static const String separadorMiles = '.';
  static const String separadorDecimal = ',';
  static const String separadorPunto = ' · ';
  static const String separadorHora = ':';
  static const String porcentaje = '%';
  static const String hoyMayuscula = 'HOY';
  static const String ayerMayuscula = 'AYER';

  /// Índice 0 = lunes, igual que `DateTime.weekday - 1`.
  static const List<String> diasAbreviados = [
    'LUN',
    'MAR',
    'MIE',
    'JUE',
    'VIE',
    'SAB',
    'DOM',
  ];

  /// Índice 0 = enero, igual que `DateTime.month - 1`.
  static const List<String> mesesAbreviados = [
    'ENE',
    'FEB',
    'MAR',
    'ABR',
    'MAY',
    'JUN',
    'JUL',
    'AGO',
    'SEP',
    'OCT',
    'NOV',
    'DIC',
  ];
}
