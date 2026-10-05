import 'package:flutter/foundation.dart';

import 'package:gastos_app/app/shared/models/grupo_dia_model.dart';
import 'package:gastos_app/app/shared/models/movimiento_model.dart';
import 'package:gastos_app/app/shared/models/resumen_mes_model.dart';
import 'package:gastos_app/app/shared/paginado/constants/base_main_list_constants.dart';
import 'package:gastos_app/app/shared/paginado/models/paginated_response_model.dart';
import 'package:gastos_app/app/shared/paginado/utils/paginacion_mixin.dart';
import 'package:gastos_app/app/shared/utils/agrupacion_helpers.dart';

import '../constants/inicio_strings.dart';
import '../models/periodo_filtro.dart';
import '../services/inicio_mock_service.dart';

class InicioProvider extends ChangeNotifier with PaginacionMixin<Movimiento> {
  final InicioMockService _servicio;

  InicioProvider(this._servicio) {
    _servicio.cambios.addListener(cargar);
  }

  ResumenMes _resumen = ResumenMes.vacio;
  PeriodoFiltro _periodo = PeriodoFiltro.hoy;
  bool _cargando = false;
  String? _error;

  ResumenMes get resumen => _resumen;
  PeriodoFiltro get periodoSeleccionado => _periodo;
  bool get cargando => _cargando;
  String? get error => _error;

  List<GrupoDia<Movimiento>> get gruposVisibles =>
      AgrupacionHelpers.agruparPorDia(items, (movimiento) => movimiento.fecha);

  @override
  Future<PaginatedResponse<Movimiento>> obtenerPagina(int pagina) =>
      _servicio.obtenerMovimientos(periodo: _periodo, pagina: pagina);

  /// Recarga el resumen y vuelve a la primera página del periodo actual.
  Future<void> cargar() async {
    _cargando = true;
    _error = null;
    notifyListeners();
    try {
      _resumen = await _servicio.obtenerResumen();
      reiniciarPaginacion(
        await obtenerPagina(BaseMainListConstants.paginaInicial),
      );
    } catch (error) {
      _error = InicioStrings.errorCarga;
      debugPrint('${InicioStrings.errorCarga}: $error');
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  /// No pide más mientras se recarga la primera página.
  @override
  Future<void> cargarMas() async {
    if (_cargando) return;
    await super.cargarMas();
  }

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
