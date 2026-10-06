class AuthConstants {
  AuthConstants._();

  static const int longitudMinimaContrasenaLogin = 3;
  static const int longitudMinimaContrasenaRegistro = 6;
  static const int longitudMinimaNombre = 2;

  /***************************** DEMORA SIMULADA ******************************/
  static const Duration demoraSimulada = Duration(milliseconds: 600);

  /******************************* TOKEN LOCAL ********************************/
  static const String tokenLocal = 'token-local';

  static final RegExp patronCorreo = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
}
