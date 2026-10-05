import 'package:gastos_app/app/core/constants/formato_constants.dart';
import 'package:gastos_app/app/core/constants/formato_strings.dart';

/// Formateo de dinero (en centavos), horas y fechas para cualquier feature.
class FormatoHelpers {
  FormatoHelpers._();

  /// 124550 → "Bs 1.245,50".
  static String formatearMonto(int centavos) {
    final signo = centavos < 0 ? FormatoStrings.signoNegativo : '';
    return '$signo${FormatoStrings.moneda}${FormatoStrings.espacio}'
        '${formatearNumero(centavos.abs())}';
  }

  /// 124550 → "1.245,50", sin moneda ni signo.
  static String formatearNumero(int centavos) {
    final absoluto = centavos.abs();
    final enteros = absoluto ~/ FormatoConstants.centavosPorUnidad;
    final decimales = (absoluto % FormatoConstants.centavosPorUnidad)
        .toString()
        .padLeft(FormatoConstants.digitosCentavos, '0');
    return '${_agruparMiles(enteros)}'
        '${FormatoStrings.separadorDecimal}$decimales';
  }

  /// "1.245,50" → 124550; los dígitos se leen siempre como centavos.
  static int parsearMonto(String texto) {
    final digitos = texto.replaceAll(RegExp(r'\D'), '');
    if (digitos.isEmpty) return 0;
    return int.parse(digitos);
  }

  static String _agruparMiles(int valor) {
    final digitos = valor.toString();
    final buffer = StringBuffer();
    for (var indice = 0; indice < digitos.length; indice++) {
      final restantes = digitos.length - indice;
      final iniciaGrupo =
          restantes % FormatoConstants.digitosPorGrupoMiles == 0;
      if (indice > 0 && iniciaGrupo) {
        buffer.write(FormatoStrings.separadorMiles);
      }
      buffer.write(digitos[indice]);
    }
    return buffer.toString();
  }

  static String _dosDigitos(int valor) =>
      valor.toString().padLeft(FormatoConstants.digitosHora, '0');

  static String formatearHora(DateTime fecha) =>
      '${_dosDigitos(fecha.hour)}${FormatoStrings.separadorHora}'
      '${_dosDigitos(fecha.minute)}';

  /// "05/10/2026".
  static String formatearFecha(DateTime fecha) {
    const separador = FormatoStrings.separadorFecha;
    return '${_dosDigitos(fecha.day)}$separador'
        '${_dosDigitos(fecha.month)}$separador${fecha.year}';
  }

  /// "05/10/2026 13:20".
  static String formatearFechaHora(DateTime fecha) =>
      '${formatearFecha(fecha)}${FormatoStrings.espacio}${formatearHora(fecha)}';

  static String nombreMes(DateTime fecha) =>
      FormatoStrings.mesesCompletos[fecha.month - 1];

  /// "Octubre 2026".
  static String formatearMesAnio(DateTime fecha) =>
      '${nombreMes(fecha)}${FormatoStrings.espacio}${fecha.year}';

  /// Parte sobre total entre 0 y 1; 0 si el total no es positivo.
  static double fraccion(int parte, int total) {
    if (total <= 0) return 0;
    return (parte / total).clamp(0, 1).toDouble();
  }

  static int porcentaje(double fraccion) =>
      (fraccion * FormatoConstants.porcentajeMaximo).round();

  static DateTime soloDia(DateTime fecha) =>
      DateTime(fecha.year, fecha.month, fecha.day);

  /// "HOY · LUN 5 OCT", "AYER · DOM 4 OCT" o "MIE 1 OCT".
  static String formatearEncabezadoDia(DateTime fecha, DateTime hoy) {
    final dia = soloDia(fecha);
    final diasAtras = soloDia(hoy).difference(dia).inDays;
    final fechaCorta =
        '${FormatoStrings.diasAbreviados[dia.weekday - 1]} ${dia.day} '
        '${FormatoStrings.mesesAbreviados[dia.month - 1]}';
    final prefijo = switch (diasAtras) {
      FormatoConstants.diasAtrasHoy => FormatoStrings.hoyMayuscula,
      FormatoConstants.diasAtrasAyer => FormatoStrings.ayerMayuscula,
      _ => null,
    };
    if (prefijo == null) return fechaCorta;
    return '$prefijo${FormatoStrings.separadorPunto}$fechaCorta';
  }
}
