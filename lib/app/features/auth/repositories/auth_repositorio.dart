/********************************* FEATURE **********************************/
import '../models/credenciales_model.dart';
import '../models/sesion_model.dart';

/****************************** AUTH REPOSITORIO *******************************/
abstract class AuthRepositorio {
  /****************************** INICIAR SESION ******************************/
  Future<SesionModel> iniciarSesion(CredencialesModel credenciales);

  /******************************** REGISTRAR *********************************/
  Future<void> registrar({
    required String nombre,
    required CredencialesModel credenciales,
  });

  /*************************** RECUPERAR CONTRASENA ***************************/
  Future<void> recuperarContrasena(CredencialesModel credenciales);

  /****************************** ACTUALIZAR PERFIL ****************************/
  Future<void> actualizarPerfil({
    required String nombre,
    required String correo,
  });

  /****************************** CERRAR SESION *******************************/
  Future<void> cerrarSesion(String token);
}
