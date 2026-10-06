/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/paginado/base_main_list_state.dart';
import 'package:gastos_app/app/shared/paginado/constants/base_main_list_constants.dart';
import 'package:gastos_app/app/shared/paginado/models/base_tab_model.dart';
import 'package:gastos_app/app/shared/paginado/models/paginated_response_model.dart';

export 'package:gastos_app/app/shared/paginado/base_main_list_state.dart';
export 'package:gastos_app/app/shared/paginado/models/base_tab_model.dart';
export 'package:gastos_app/app/shared/paginado/models/paginated_response_model.dart';

/****************************** BASE MAIN LIST *******************************/
abstract class BaseMainList<T> extends StatefulWidget {
  final String? title;
  final Widget? footer;
  final bool showAppBar;
  final Widget? floatingActionButton;

  const BaseMainList({
    super.key,
    this.title,
    this.footer,
    this.showAppBar = true,
    this.floatingActionButton,
  });

  @override
  State<BaseMainList<T>> createState() => BaseMainListState<T>();

  Future<PaginatedResponse<T>> loadData(int page, String search);
  Widget buildItem(BuildContext context, T item);

  int get crossAxisCount => BaseMainListConstants.columnasPorDefecto;
  double getChildAspectRatio(BuildContext context) =>
      BaseMainListConstants.aspectRatioPorDefecto;
  EdgeInsets get padding =>
      const EdgeInsets.all(AppDimensions.paddingListaBase);

  List<Widget>? buildActionsHeader(BuildContext context) => null;
  Widget? buildSubHeader(BuildContext context) => null;
  Widget? buildSubSearch(BuildContext context) => null;
  List<Widget>? buildSearchActions(BuildContext context) => null;
  Widget? buildFilterButton(BuildContext context) => null;

  /****************************** BUILD PRE LIST ******************************/
  Widget? buildPreList(BuildContext context, VoidCallback refresh) => null;

  Future<void>? cargardatos(BuildContext context) => null;

  List<BaseTab<T>>? get tabs => null;
}
