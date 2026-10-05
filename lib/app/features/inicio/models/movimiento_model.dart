import 'categoria_movimiento.dart';

class Movimiento {
  final String id;
  final String titulo;
  final CategoriaMovimiento categoria;
  final int montoCentavos;
  final DateTime fecha;
  final bool anulado;
  final bool esEntrada;

  const Movimiento({
    required this.id,
    required this.titulo,
    required this.categoria,
    required this.montoCentavos,
    required this.fecha,
    this.anulado = false,
    this.esEntrada = false,
  });
}
