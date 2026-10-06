/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/models/categoria_movimiento.dart';

/**************************** CATEGORIA TOTALIZADA ***************************/
class CategoriaTotalizada {
  final CategoriaMovimiento categoria;
  final int totalCentavos;

  const CategoriaTotalizada({
    required this.categoria,
    required this.totalCentavos,
  });
}
