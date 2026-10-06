/********************************* FEATURE **********************************/
import '../constants/auth_constants.dart';
import '../constants/auth_strings.dart';

/******************************* AUTH HELPERS *******************************/
class AuthHelpers {
  AuthHelpers._();

  static String? validarCorreo(String? valor) {
    final correo = valor?.trim() ?? '';
    if (correo.isEmpty) return AuthStrings.ingresaCorreo;
    if (!AuthConstants.patronCorreo.hasMatch(correo)) {
      return AuthStrings.correoInvalido;
    }
    return null;
  }

  static String? validarNombre(String? valor) {
    final nombre = valor?.trim() ?? '';
    if (nombre.isEmpty) return AuthStrings.ingresaNombre;
    if (nombre.length < AuthConstants.longitudMinimaNombre) {
      return AuthStrings.nombreCorto;
    }
    return null;
  }

  static String? validarContrasena(String? valor, {required int minimo}) {
    final contrasena = valor ?? '';
    if (contrasena.isEmpty) return AuthStrings.ingresaContrasena;
    if (contrasena.length < minimo) return AuthStrings.contrasenaCorta;
    return null;
  }

  static String? validarConfirmacion(String? valor, String original) {
    if (valor == null || valor.isEmpty) return AuthStrings.ingresaContrasena;
    if (valor != original) return AuthStrings.contrasenasNoCoinciden;
    return null;
  }
}
