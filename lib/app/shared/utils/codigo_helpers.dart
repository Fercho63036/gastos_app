/********************************** SHARED **********************************/
import '../constants/dominio_constants.dart';

class CodigoHelpers {
  CodigoHelpers._();

  /******************************** FORMATEAR *********************************/
  static String formatear(String prefijo, int numero) =>
      '$prefijo${numero.toString().padLeft(DominioConstants.digitosCodigo, '0')}';
}
