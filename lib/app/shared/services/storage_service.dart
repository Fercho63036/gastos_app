/**************************** PAQUETES EXTERNOS *****************************/
import 'package:shared_preferences/shared_preferences.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/config/app_config.dart';

class StorageService {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /*********************************** SESION **********************************/
  String? leerTokenSesion() => _prefs.getString(AppConfig.storageTokenKey);

  String? leerCorreoSesion() => _prefs.getString(AppConfig.storageCorreoKey);

  Future<void> guardarSesion({
    required String token,
    required String correo,
  }) async {
    await _prefs.setString(AppConfig.storageTokenKey, token);
    await _prefs.setString(AppConfig.storageCorreoKey, correo);
  }

  Future<void> eliminarSesion() async {
    await _prefs.remove(AppConfig.storageTokenKey);
    await _prefs.remove(AppConfig.storageCorreoKey);
  }

  /*********************************** TEMA ***********************************/
  bool leerTemaOscuro() => _prefs.getBool(AppConfig.storageTemaKey) ?? false;

  Future<void> guardarTemaOscuro(bool temaOscuro) =>
      _prefs.setBool(AppConfig.storageTemaKey, temaOscuro);
}
