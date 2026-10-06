import '../models/credenciales_model.dart';
import '../models/sesion_model.dart';

/// Contrato de autenticación (`/auth/*` en `docs/api_contrato.md`). Guardar
/// la sesión en el dispositivo no es parte de esto: lo hace `AuthProvider`.
///
/// Los errores esperables se lanzan como `AppException`.
abstract class AuthRepositorio {
  /// `POST /auth/login`
  Future<SesionModel> iniciarSesion(CredencialesModel credenciales);

  /// `POST /auth/registro`
  Future<void> registrar({
    required String nombre,
    required CredencialesModel credenciales,
  });

  /// `POST /auth/recuperar`
  Future<void> recuperarContrasena(CredencialesModel credenciales);

  /// `POST /auth/logout`, invalida [token] en el servidor.
  Future<void> cerrarSesion(String token);
}
