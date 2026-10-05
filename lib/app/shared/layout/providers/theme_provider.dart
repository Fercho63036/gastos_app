import 'package:flutter/material.dart';

import 'package:gastos_app/app/shared/services/storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  final StorageService _storage;

  ThemeProvider(this._storage) : _temaOscuro = _storage.leerTemaOscuro();

  bool _temaOscuro;

  bool get temaOscuro => _temaOscuro;

  ThemeMode get themeMode => _temaOscuro ? ThemeMode.dark : ThemeMode.light;

  Future<void> cambiarTema() async {
    _temaOscuro = !_temaOscuro;
    notifyListeners();
    await _storage.guardarTemaOscuro(_temaOscuro);
  }
}
