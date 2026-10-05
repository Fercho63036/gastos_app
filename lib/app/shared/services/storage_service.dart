import 'package:shared_preferences/shared_preferences.dart';

import 'package:gastos_app/app/core/config/app_config.dart';

class StorageService {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Sesión local (mock, sin backend)
  bool get tieneSesion => _prefs.getBool(AppConfig.storageSesionKey) ?? false;

  String? leerCorreoSesion() => _prefs.getString(AppConfig.storageCorreoKey);

  Future<void> guardarSesion(String correo) async {
    await _prefs.setBool(AppConfig.storageSesionKey, true);
    await _prefs.setString(AppConfig.storageCorreoKey, correo);
  }

  Future<void> eliminarSesion() async {
    await _prefs.remove(AppConfig.storageSesionKey);
    await _prefs.remove(AppConfig.storageCorreoKey);
  }

  // Tema
  bool leerTemaOscuro() => _prefs.getBool(AppConfig.storageTemaKey) ?? false;

  Future<void> guardarTemaOscuro(bool temaOscuro) =>
      _prefs.setBool(AppConfig.storageTemaKey, temaOscuro);
}
