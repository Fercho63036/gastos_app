import 'categoria_movimiento.dart';

/// Lo que la app envía al registrar un movimiento; el id, el código y la
/// fecha los asigna quien lo guarda.
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
