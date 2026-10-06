import 'package:flutter/foundation.dart';

import 'package:gastos_app/app/core/errors/app_exception.dart';

import '../constants/dominio_strings.dart';

/// Estado "guardando" para formularios que persisten de forma asíncrona.
mixin GuardadoMixin on ChangeNotifier {
  bool _guardando = false;

  bool get guardando => _guardando;

  /// Ejecuta [accion] (que devuelve el error a mostrar o `null`) e impide
  /// un segundo guardado mientras el primero sigue en curso.
  Future<String?> guardarConEstado(Future<String?> Function() accion) async {
    if (_guardando) return DominioStrings.guardando;
    _guardando = true;
    notifyListeners();
    try {
      return await accion();
    } on AppException catch (error) {
      debugPrint('${DominioStrings.errorGuardar}: $error');
      return error.mensaje;
    } catch (error) {
      debugPrint('${DominioStrings.errorGuardar}: $error');
      return DominioStrings.errorGuardar;
    } finally {
      _guardando = false;
      notifyListeners();
    }
  }
}
