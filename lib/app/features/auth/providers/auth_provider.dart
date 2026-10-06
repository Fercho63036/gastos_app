import 'package:flutter/foundation.dart';

import 'package:gastos_app/app/core/errors/app_exception.dart';
import 'package:gastos_app/app/shared/services/storage_service.dart';

import '../models/credenciales_model.dart';
import '../models/sesion_model.dart';
import '../repositories/auth_repositorio.dart';

/// Estado de la sesión. Las llamadas van al [AuthRepositorio]; la sesión
/// obtenida se guarda en el dispositivo para no pedir login al reabrir.
class AuthProvider extends ChangeNotifier {
  final AuthRepositorio _repositorio;
  final StorageService _storage;

  AuthProvider(this._repositorio, this._storage);

  bool _cargando = false;
  SesionModel? _sesion;

  bool get cargando => _cargando;
  bool get estaAutenticado => _sesion != null;
  String? get correoUsuario => _sesion?.correo;
  String? get token => _sesion?.token;

  void verificarSesion() {
    final token = _storage.leerTokenSesion();
    final correo = _storage.leerCorreoSesion();
    _sesion = token == null || correo == null
        ? null
        : SesionModel(token: token, correo: correo);
    notifyListeners();
  }

  /// Lanza `AppException` si el servidor rechaza las credenciales.
  Future<void> iniciarSesion(CredencialesModel credenciales) => _ejecutar(
    () async {
      final sesion = await _repositorio.iniciarSesion(credenciales);
      await _storage.guardarSesion(token: sesion.token, correo: sesion.correo);
      _sesion = sesion;
    },
  );

  Future<void> registrarUsuario({
    required String nombre,
    required CredencialesModel credenciales,
  }) => _ejecutar(
    () => _repositorio.registrar(nombre: nombre, credenciales: credenciales),
  );

  Future<void> recuperarContrasena(CredencialesModel credenciales) =>
      _ejecutar(() => _repositorio.recuperarContrasena(credenciales));

  /// La sesión local se cierra aunque el servidor no responda.
  Future<void> logout() async {
    final sesion = _sesion;
    await _storage.eliminarSesion();
    _sesion = null;
    notifyListeners();
    if (sesion == null) return;
    try {
      await _repositorio.cerrarSesion(sesion.token);
    } on AppException catch (error) {
      debugPrint('[Auth] logout remoto falló: $error');
    }
  }

  Future<void> _ejecutar(Future<void> Function() operacion) async {
    _cargando = true;
    notifyListeners();
    try {
      await operacion();
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }
}
