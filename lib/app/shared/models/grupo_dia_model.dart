/// Elementos de cualquier tipo que comparten el mismo día.
class GrupoDia<T> {
  final DateTime fecha;
  final List<T> items;

  const GrupoDia({required this.fecha, required this.items});
}
