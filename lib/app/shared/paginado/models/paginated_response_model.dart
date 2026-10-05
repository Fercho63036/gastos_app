class PaginatedResponse<T> {
  final List<T> datos;
  final int total;

  const PaginatedResponse({required this.datos, required this.total});
}
