/*********************************** CORE ***********************************/
import 'errores_strings.dart';

/******************************** APP EXCEPTION ********************************/
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

/*************************** VALIDACION EXCEPTION ***************************/
class ValidacionException extends AppException {
  const ValidacionException(super.mensaje);
}

class ServidorException extends AppException {
  const ServidorException() : super(ErroresStrings.servidor);
}
