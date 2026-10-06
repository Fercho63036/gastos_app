class AuthConstants {
  AuthConstants._();

  static const int longitudMinimaContrasenaLogin = 3;
  static const int longitudMinimaContrasenaRegistro = 6;
  static const int longitudMinimaNombre = 2;

  /// Espera artificial para que el mock se comporte como una llamada real.
  static const Duration demoraSimulada = Duration(milliseconds: 600);

  /// Token de la sesión simulada; el backend entregará uno real.
  static const String tokenLocal = 'token-local';

  static final RegExp patronCorreo = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
}
