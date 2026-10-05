class RouteNames {
  RouteNames._();

  // Públicas
  static const String auth = '/auth';
  static const String registro = '/registro';
  static const String recuperarPassword = '/recuperar-password';

  // Protegidas
  static const String home = '/';
  static const String perfil = '/perfil';

  // Protegidas en pantalla completa (fuera del layout con tabs)
  static const String nuevoGasto = '/nuevo-gasto';
  static const String nuevaEntrada = '/nueva-entrada';
  static const String iniciarMes = '/iniciar-mes';
  static const String parametroId = 'id';
  static const String detalleGasto = '/gasto/:$parametroId';

  static String detalleGastoDe(String id) => '/gasto/$id';

  static const List<String> publicas = [auth, registro, recuperarPassword];
}
