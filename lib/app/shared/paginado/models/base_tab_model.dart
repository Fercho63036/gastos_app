/****************************** FLUTTER / DART ******************************/
import 'package:flutter/widgets.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/paginado/models/paginated_response_model.dart';

/********************************* BASE TAB *********************************/
class BaseTab<T> {
  final String label;
  final IconData? icon;
  final bool Function(T item)? filtro;
  final WidgetBuilder? pageBuilder;
  final Future<PaginatedResponse<T>> Function(int page, String search)?
  loadDataFn;

  const BaseTab({
    required this.label,
    this.icon,
    this.filtro,
    this.pageBuilder,
    this.loadDataFn,
  }) : assert(
         (filtro == null || pageBuilder == null) &&
             (filtro == null || loadDataFn == null) &&
             (pageBuilder == null || loadDataFn == null),
         'Un tab solo puede tener uno: filtro, pageBuilder o loadDataFn.',
       );
}
