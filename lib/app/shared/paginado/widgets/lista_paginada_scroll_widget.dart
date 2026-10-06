/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:pull_to_refresh/pull_to_refresh.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/paginado/constants/base_main_list_strings.dart';
import 'package:gastos_app/app/shared/paginado/widgets/pie_carga_paginado_widget.dart';

/*********************** LISTA PAGINADA SCROLL WIDGET ***********************/
class ListaPaginadaScrollWidget<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final bool hayMas;
  final Future<void> Function() onRefrescar;
  final Future<void> Function() onCargarMas;
  final String mensajeVacio;
  final String textoSinMas;
  final EdgeInsets padding;

  const ListaPaginadaScrollWidget({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.hayMas,
    required this.onRefrescar,
    required this.onCargarMas,
    required this.mensajeVacio,
    this.textoSinMas = BaseMainListStrings.sinMasElementos,
    this.padding = EdgeInsets.zero,
  });

  @override
  State<ListaPaginadaScrollWidget<T>> createState() =>
      _ListaPaginadaScrollWidgetState<T>();
}

class _ListaPaginadaScrollWidgetState<T>
    extends State<ListaPaginadaScrollWidget<T>> {
  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();

  /************************* SINCRONIZAR FIN DE LISTA *************************/
  void _sincronizarFinDeLista() {
    if (!mounted) return;
    if (_refreshController.footerStatus == LoadStatus.loading) return;
    if (!widget.hayMas) {
      _refreshController.loadNoData();
    } else if (_refreshController.footerStatus == LoadStatus.noMore) {
      _refreshController.resetNoData();
    }
  }

  Future<void> _manejarRefresco() async {
    await widget.onRefrescar();
    if (!mounted) return;
    _refreshController.refreshCompleted();
  }

  Future<void> _manejarCargaMas() async {
    try {
      await widget.onCargarMas();
      if (!mounted) return;
      _refreshController.loadComplete();
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _sincronizarFinDeLista(),
      );
    } catch (error) {
      if (mounted) _refreshController.loadFailed();
    }
  }

  Widget _buildLista() {
    if (widget.items.isEmpty) {
      return ListView(
        controller: _scrollController,
        padding: widget.padding,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.paddingXL,
            ),
            child: Center(child: Text(widget.mensajeVacio)),
          ),
        ],
      );
    }
    return ListView.builder(
      controller: _scrollController,
      padding: widget.padding,
      itemCount: widget.items.length,
      itemBuilder: (context, indice) =>
          widget.itemBuilder(context, widget.items[indice]),
    );
  }

  @override
  void didUpdateWidget(covariant ListaPaginadaScrollWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sincronizarFinDeLista();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      child: SmartRefresher(
        controller: _refreshController,
        enablePullUp: widget.items.isNotEmpty,
        onRefresh: _manejarRefresco,
        onLoading: _manejarCargaMas,
        footer: PieCargaPaginadoWidget(textoSinMas: widget.textoSinMas),
        child: _buildLista(),
      ),
    );
  }
}
