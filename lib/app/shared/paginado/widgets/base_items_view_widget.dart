import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

/// Items como lista (1 columna) o grilla, con pull-to-refresh y carga de la
/// página siguiente al llegar al final.
class BaseItemsViewWidget<T> extends StatelessWidget {
  final RefreshController refreshController;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final List<T> items;
  final int columnas;
  final double aspectRatio;
  final EdgeInsets padding;
  final Widget Function(BuildContext context, T item) itemBuilder;

  const BaseItemsViewWidget({
    super.key,
    required this.refreshController,
    required this.onRefresh,
    required this.onLoading,
    required this.items,
    required this.columnas,
    required this.aspectRatio,
    required this.padding,
    required this.itemBuilder,
  });

  Widget _buildVista() {
    if (columnas > 1) {
      return GridView.builder(
        padding: padding,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columnas,
          childAspectRatio: aspectRatio,
        ),
        itemCount: items.length,
        itemBuilder: (context, indice) => itemBuilder(context, items[indice]),
      );
    }
    return ListView.builder(
      padding: padding,
      itemCount: items.length,
      itemBuilder: (context, indice) => itemBuilder(context, items[indice]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullUp: true,
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: _buildVista(),
    );
  }
}
