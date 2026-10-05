class RouteNames {
  RouteNames._();

  // Públicas
  static const String auth = '/auth';
  static const String registro = '/registro';
  static const String recuperarPassword = '/recuperar-password';

  // Protegidas
  static const String home = '/';
  static const String perfil = '/perfil';

  static const List<String> publicas = [auth, registro, recuperarPassword];
}
