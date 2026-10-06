import 'package:gastos_app/app/shared/dto/json_helpers.dart';

import '../models/credenciales_model.dart';
import '../models/sesion_model.dart';
import 'auth_claves.dart';

class SesionDto {
  SesionDto._();

  /// `{"token": "...", "usuario": {"correo": "...", "nombre": "..."}}`.
  static SesionModel desdeJson(Json json) {
    final usuario = json[AuthClaves.usuario] as Json;
    return SesionModel(
      token: json[AuthClaves.token] as String,
      correo: usuario[AuthClaves.correo] as String,
      nombre: usuario[AuthClaves.nombre] as String?,
    );
  }

  static Json aJson(SesionModel sesion) => {
    AuthClaves.token: sesion.token,
    AuthClaves.usuario: {
      AuthClaves.correo: sesion.correo,
      AuthClaves.nombre: sesion.nombre,
    },
  };

  /// Cuerpo de `/auth/login` y `/auth/recuperar`.
  static Json credencialesAJson(CredencialesModel credenciales) => {
    AuthClaves.correo: credenciales.correo,
    AuthClaves.contrasena: credenciales.contrasena,
  };

  /// Cuerpo de `/auth/registro`.
  static Json registroAJson(String nombre, CredencialesModel credenciales) => {
    AuthClaves.nombre: nombre,
    ...credencialesAJson(credenciales),
  };
}
