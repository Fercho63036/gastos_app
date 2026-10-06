/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/paginado/constants/base_main_list_constants.dart';

class PaginadoHelpers {
  PaginadoHelpers._();

  /********************************** PAGINAR **********************************/
  static List<T> paginar<T>(List<T> lista, int pagina, int porPagina) {
    final desde = (pagina - BaseMainListConstants.paginaInicial) * porPagina;
    if (desde < 0 || desde >= lista.length) return [];
    return lista.skip(desde).take(porPagina).toList();
  }
}
