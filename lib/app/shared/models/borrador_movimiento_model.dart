/********************************** SHARED **********************************/
import 'categoria_movimiento.dart';

/*************************** BORRADOR MOVIMIENTO ****************************/
class BorradorMovimiento {
  final String titulo;
  final CategoriaMovimiento categoria;
  final int montoCentavos;
  final bool esEntrada;

  const BorradorMovimiento({
    required this.titulo,
    required this.categoria,
    required this.montoCentavos,
    this.esEntrada = false,
  });
}
