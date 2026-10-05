import 'categoria_movimiento.dart';
import 'edicion_movimiento_model.dart';
import 'estado_movimiento.dart';

class Movimiento {
  final String id;
  final String codigo;
  final String titulo;
  final CategoriaMovimiento categoria;
  final int montoCentavos;
  final DateTime fecha;
  final bool anulado;
  final bool esEntrada;

  /// De la más reciente a la más antigua.
  final List<EdicionMovimiento> ediciones;

  const Movimiento({
    required this.id,
    required this.titulo,
    required this.categoria,
    required this.montoCentavos,
    required this.fecha,
    this.codigo = '',
    this.anulado = false,
    this.esEntrada = false,
    this.ediciones = const [],
  });

  EstadoMovimiento get estado => EstadoMovimiento.desde(anulado: anulado);

  Movimiento copyWith({
    String? codigo,
    String? titulo,
    CategoriaMovimiento? categoria,
    int? montoCentavos,
    bool? anulado,
    List<EdicionMovimiento>? ediciones,
  }) {
    return Movimiento(
      id: id,
      codigo: codigo ?? this.codigo,
      titulo: titulo ?? this.titulo,
      categoria: categoria ?? this.categoria,
      montoCentavos: montoCentavos ?? this.montoCentavos,
      fecha: fecha,
      anulado: anulado ?? this.anulado,
      esEntrada: esEntrada,
      ediciones: ediciones ?? this.ediciones,
    );
  }
}
