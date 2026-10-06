/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/constants/formulario_strings.dart';
import 'package:gastos_app/app/shared/constants/validacion_constants.dart';

/**************************** VALIDADORES HELPERS ****************************/
class ValidadoresHelpers {
  ValidadoresHelpers._();

  static String? validarCorreo(String? valor) {
    final correo = valor?.trim() ?? '';
    if (correo.isEmpty) return FormularioStrings.ingresaCorreo;
    if (!ValidacionConstants.patronCorreo.hasMatch(correo)) {
      return FormularioStrings.correoInvalido;
    }
    return null;
  }

  static String? validarNombre(String? valor) {
    final nombre = valor?.trim() ?? '';
    if (nombre.isEmpty) return FormularioStrings.ingresaNombre;
    if (nombre.length < ValidacionConstants.longitudMinimaNombre) {
      return FormularioStrings.nombreCorto;
    }
    return null;
  }
}
