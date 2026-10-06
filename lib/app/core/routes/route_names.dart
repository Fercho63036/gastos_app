class RouteNames {
  RouteNames._();

  /********************************* PÚBLICAS *********************************/
  static const String auth = '/auth';
  static const String registro = '/registro';
  static const String recuperarPassword = '/recuperar-password';

  /******************************** PROTEGIDAS ********************************/
  static const String home = '/';
  static const String perfil = '/perfil';
  static const String resumen = '/resumen';

  /******* PROTEGIDAS EN PANTALLA COMPLETA (FUERA DEL LAYOUT CON TABS) ********/
  static const String nuevoGasto = '/nuevo-gasto';
  static const String nuevaEntrada = '/nueva-entrada';
  static const String iniciarMes = '/iniciar-mes';
  static const String parametroId = 'id';
  static const String detalleGasto = '/gasto/:$parametroId';

  static String detalleGastoDe(String id) => '/gasto/$id';

  static const List<String> publicas = [auth, registro, recuperarPassword];
}
