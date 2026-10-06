typedef Json = Map<String, Object?>;

/// Conversiones comunes del JSON del API.
class JsonHelpers {
  JsonHelpers._();

  /// Se envía siempre en UTC para que el servidor no dependa de la zona.
  static String fechaAJson(DateTime fecha) => fecha.toUtc().toIso8601String();

  static DateTime fechaDesdeJson(Object? valor) =>
      DateTime.parse(valor as String).toLocal();

  static List<Json> lista(Object? valor) =>
      (valor as List<Object?>? ?? const []).cast<Json>();
}
