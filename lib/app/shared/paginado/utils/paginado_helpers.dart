import 'package:gastos_app/app/shared/paginado/constants/base_main_list_constants.dart';

class PaginadoHelpers {
  PaginadoHelpers._();

  /// Devuelve los elementos de [pagina] (empieza en 1); vacío si se pasa.
  static List<T> paginar<T>(List<T> lista, int pagina, int porPagina) {
    final desde = (pagina - BaseMainListConstants.paginaInicial) * porPagina;
    if (desde < 0 || desde >= lista.length) return [];
    return lista.skip(desde).take(porPagina).toList();
  }
}
