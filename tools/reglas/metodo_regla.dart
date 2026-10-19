// ********************************** FEATURE **********************************
import 'codigo_util.dart';
import 'incumplimiento.dart';

// ******************************** CONSTANTES *********************************
const int maxLineasMetodo = 30;
const int profundidadMaximaMetodo = 1;
final RegExp _patronTipo = RegExp(
  r'^\s*(?:(?:abstract|sealed|final|base|interface)\s+)*'
  r'(?:class|enum|mixin|extension)\b',
);
final RegExp _patronLiteral = RegExp(r'=>?\s*(?:const\s+)?(?:<[^>]*>)?\{');

// ****************************** METODO ABIERTO *******************************
class _MetodoAbierto {
  // ******************************** PROPIEDADES ********************************
  final int lineaInicio;
  final int profundidadBase;

  // ******************************** CONSTRUCTOR ********************************
  const _MetodoAbierto(this.lineaInicio, this.profundidadBase);
}

// ****************************** REVISAR METODOS ******************************
List<Incumplimiento> revisarMetodos(String ruta, List<String> lineas) {
  final List<Incumplimiento> encontrados = <Incumplimiento>[];
  _MetodoAbierto? abierto;
  int profundidad = 0;
  for (int indice = 0; indice < lineas.length; indice++) {
    final String codigo = codigoSinComentario(lineas[indice]);
    final int profundidadInicial = profundidad;
    profundidad += _contar(codigo, '{') - _contar(codigo, '}');
    if (abierto == null) {
      if (_abreMetodo(codigo, profundidadInicial, profundidad)) {
        abierto = _MetodoAbierto(indice, profundidadInicial);
      }
    } else if (profundidad <= abierto.profundidadBase) {
      _registrarSiExcede(ruta, abierto, indice, encontrados);
      abierto = null;
    }
  }
  return encontrados;
}

// ********************************** CONTAR ***********************************
int _contar(String codigo, String simbolo) => simbolo.allMatches(codigo).length;

// ******************************** ABRE METODO ********************************
bool _abreMetodo(String codigo, int profundidadInicial, int profundidad) {
  if (profundidad <= profundidadInicial) return false;
  if (profundidadInicial > profundidadMaximaMetodo) return false;
  if (_patronTipo.hasMatch(codigo) || _patronLiteral.hasMatch(codigo)) {
    return false;
  }
  return codigo.contains('(') || codigo.contains(')');
}

// **************************** REGISTRAR SI EXCEDE ****************************
void _registrarSiExcede(
  String ruta,
  _MetodoAbierto metodo,
  int lineaFin,
  List<Incumplimiento> encontrados,
) {
  final int longitud = lineaFin - metodo.lineaInicio + 1;
  if (longitud <= maxLineasMetodo) return;
  encontrados.add(
    Incumplimiento(
      ruta,
      metodo.lineaInicio + 1,
      'Método de $longitud líneas (máx $maxLineasMetodo)',
    ),
  );
}
