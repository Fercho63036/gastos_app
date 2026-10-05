import 'package:flutter/foundation.dart';

import 'package:gastos_app/app/shared/services/storage_service.dart';

import '../constants/auth_constants.dart';
import '../models/credenciales_model.dart';

/// Auth 100% local (mock): no valida contra ningún backend; solo guarda una
/// sesión en el dispositivo. Aquí se conectará el backend más adelante.
class AuthProvider extends ChangeNotifier {
  final StorageService _storage;

  AuthProvider(this._storage);

  bool _cargando = false;
  bool _autenticado = false;

  bool get cargando => _cargando;
  bool get estaAutenticado => _autenticado;
  String? get correoUsuario => _storage.leerCorreoSesion();

  void verificarSesion() {
    _autenticado = _storage.tieneSesion;
    notifyListeners();
  }

  Future<void> iniciarSesion(CredencialesModel credenciales) async {
    await _simularOperacion(() async {
      await _storage.guardarSesion(credenciales.correo);
      _autenticado = true;
    });
  }

  Future<void> registrarUsuario({
    required String nombre,
    required CredencialesModel credenciales,
  }) => _simularOperacion(() async {});

  Future<void> recuperarContrasena(CredencialesModel credenciales) =>
      _simularOperacion(() async {});

  Future<void> logout() async {
    await _storage.eliminarSesion();
    _autenticado = false;
    notifyListeners();
  }

  Future<void> _simularOperacion(Future<void> Function() operacion) async {
    _cargando = true;
    notifyListeners();
    try {
      await Future<void>.delayed(AuthConstants.demoraSimulada);
      await operacion();
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }
}
