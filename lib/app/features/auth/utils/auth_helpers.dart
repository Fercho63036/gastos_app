/********************************* FEATURE **********************************/
import '../constants/auth_strings.dart';

/******************************* AUTH HELPERS *******************************/
class AuthHelpers {
  AuthHelpers._();

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
