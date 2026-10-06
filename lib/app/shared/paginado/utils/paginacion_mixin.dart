/****************************** FLUTTER / DART ******************************/
import 'package:flutter/foundation.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/paginado/constants/base_main_list_constants.dart';
import 'package:gastos_app/app/shared/paginado/constants/base_main_list_strings.dart';
import 'package:gastos_app/app/shared/paginado/models/paginated_response_model.dart';

/***************************** PAGINACION MIXIN *****************************/
mixin PaginacionMixin<T> on ChangeNotifier {
  List<T> _items = [];
  int _pagina = BaseMainListConstants.paginaInicial;
  int _total = 0;
  bool _cargandoMas = false;

  List<T> get items => _items;
  bool get hayMas => _items.length < _total;

  Future<PaginatedResponse<T>> obtenerPagina(int pagina);

  /*************************** REINICIAR PAGINACION ***************************/
  void reiniciarPaginacion(PaginatedResponse<T> primeraPagina) {
    _pagina = BaseMainListConstants.paginaInicial;
    _items = primeraPagina.datos;
    _total = primeraPagina.total;
  }

  /******************************** CARGAR MAS ********************************/
  Future<void> cargarMas() async {
    if (_cargandoMas || !hayMas) return;
    _cargandoMas = true;
    try {
      final respuesta = await obtenerPagina(_pagina + 1);
      _pagina++;
      _items = [..._items, ...respuesta.datos];
      _total = respuesta.total;
    } catch (error) {
      debugPrint('${BaseMainListStrings.errorCargarMas}: $error');
      rethrow;
    } finally {
      _cargandoMas = false;
      notifyListeners();
    }
  }
}
