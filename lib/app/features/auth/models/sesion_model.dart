/******************************* SESION MODEL *******************************/
class SesionModel {
  final String token;
  final String correo;
  final String? nombre;

  const SesionModel({required this.token, required this.correo, this.nombre});
}
