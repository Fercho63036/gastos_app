/****************************** FLUTTER / DART ******************************/
import 'package:flutter/foundation.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/errors/app_exception.dart';

/********************************* FEATURE **********************************/
import '../../inicio/models/periodo_filtro.dart';
import '../constants/resumen_strings.dart';
import '../models/categoria_totalizada_model.dart';
import '../models/punto_barra_model.dart';
import '../services/resumen_service.dart';
import '../utils/resumen_helpers.dart';

class ResumenProvider extends ChangeNotifier {
  final ResumenService _servicio;

  ResumenProvider(this._servicio) {
    _servicio.cambios.addListener(cargar);
  }

  PeriodoFiltro _periodo = PeriodoFiltro.mes;
  bool _cargando = false;
  String? _error;
  List<CategoriaTotalizada> _categorias = const [];
  List<PuntoBarra> _puntosBarras = const [];

  PeriodoFiltro get periodoSeleccionado => _periodo;
  bool get cargando => _cargando;
  String? get error => _error;
  List<CategoriaTotalizada> get categorias => _categorias;
  List<PuntoBarra> get puntosBarras => _puntosBarras;
  bool get sinDatos => _categorias.isEmpty && _puntosBarras.isEmpty;

  /********************************** CARGAR **********************************/
  Future<void> cargar() async {
    _cargando = true;
    _error = null;
    notifyListeners();
    try {
      final movimientos = await _servicio.obtenerVigentes(_periodo);
      _categorias = ResumenHelpers.porCategoria(movimientos);
      _puntosBarras = ResumenHelpers.porDia(movimientos);
    } on AppException catch (error) {
      _error = error.mensaje;
      debugPrint('${ResumenStrings.errorCarga}: $error');
    } catch (error) {
      _error = ResumenStrings.errorCarga;
      debugPrint('${ResumenStrings.errorCarga}: $error');
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  /***************************** SELECCIONAR PERIODO ***************************/
  Future<void> seleccionarPeriodo(PeriodoFiltro periodo) async {
    if (_periodo == periodo) return;
    _periodo = periodo;
    await cargar();
  }

  @override
  void dispose() {
    _servicio.cambios.removeListener(cargar);
    super.dispose();
  }
}
