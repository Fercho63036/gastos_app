typedef Json = Map<String, Object?>;

/******************************* JSON HELPERS *******************************/
class JsonHelpers {
  JsonHelpers._();

  /******************************* FECHA A JSON *******************************/
  static String fechaAJson(DateTime fecha) => fecha.toUtc().toIso8601String();

  static DateTime fechaDesdeJson(Object? valor) =>
      DateTime.parse(valor as String).toLocal();

  static List<Json> lista(Object? valor) =>
      (valor as List<Object?>? ?? const []).cast<Json>();
}
