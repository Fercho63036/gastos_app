/// Sesión abierta: el [token] va en cada llamada al backend.
class SesionModel {
  final String token;
  final String correo;
  final String? nombre;

  const SesionModel({required this.token, required this.correo, this.nombre});
}
