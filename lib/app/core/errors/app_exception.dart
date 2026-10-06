import 'errores_strings.dart';

/// Errores esperables de cualquier repositorio (local o remoto). La UI solo
/// muestra [mensaje]; el futuro cliente HTTP traduce cada código a una de
/// estas clases.
sealed class AppException implements Exception {
  final String mensaje;

  const AppException(this.mensaje);

  @override
  String toString() => '$runtimeType: $mensaje';
}

class SinConexionException extends AppException {
  const SinConexionException() : super(ErroresStrings.sinConexion);
}

class NoAutorizadoException extends AppException {
  const NoAutorizadoException() : super(ErroresStrings.noAutorizado);
}

class NoEncontradoException extends AppException {
  const NoEncontradoException([super.mensaje = ErroresStrings.noEncontrado]);
}

/// Datos rechazados por las reglas de negocio (HTTP 422).
class ValidacionException extends AppException {
  const ValidacionException(super.mensaje);
}

class ServidorException extends AppException {
  const ServidorException() : super(ErroresStrings.servidor);
}
