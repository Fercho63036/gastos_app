/****************************** FLUTTER / DART ******************************/
import 'package:flutter/foundation.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/errors/app_exception.dart';

/********************************** SHARED **********************************/
import '../constants/dominio_strings.dart';

/****************************** GUARDADO MIXIN ******************************/
mixin GuardadoMixin on ChangeNotifier {
  bool _guardando = false;

  bool get guardando => _guardando;

  /**************************** GUARDAR CON ESTADO ****************************/
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
