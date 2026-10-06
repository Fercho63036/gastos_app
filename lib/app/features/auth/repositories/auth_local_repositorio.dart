import '../constants/auth_constants.dart';
import '../models/credenciales_model.dart';
import '../models/sesion_model.dart';
import 'auth_repositorio.dart';

/// Auth simulada: acepta cualquier credencial válida en el formulario. Se
/// reemplaza en DI por la versión que llama al backend.
class AuthLocalRepositorio implements AuthRepositorio {
  Future<void> _simularLlamada() =>
      Future<void>.delayed(AuthConstants.demoraSimulada);

  @override
  Future<SesionModel> iniciarSesion(CredencialesModel credenciales) async {
    await _simularLlamada();
    return SesionModel(
      token: AuthConstants.tokenLocal,
      correo: credenciales.correo,
    );
  }

  @override
  Future<void> registrar({
    required String nombre,
    required CredencialesModel credenciales,
  }) => _simularLlamada();

  @override
  Future<void> recuperarContrasena(CredencialesModel credenciales) =>
      _simularLlamada();

  @override
  Future<void> cerrarSesion(String token) async {}
}
