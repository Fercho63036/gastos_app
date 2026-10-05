import '../constants/dominio_constants.dart';

class CodigoHelpers {
  CodigoHelpers._();

  /// ("G-", 42) → "G-0042".
  static String formatear(String prefijo, int numero) =>
      '$prefijo${numero.toString().padLeft(DominioConstants.digitosCodigo, '0')}';
}
