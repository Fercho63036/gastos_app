/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:pull_to_refresh/pull_to_refresh.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/paginado/base_main_list.dart';
import 'package:gastos_app/app/shared/paginado/constants/base_main_list_constants.dart';
import 'package:gastos_app/app/shared/paginado/constants/base_main_list_strings.dart';
import 'package:gastos_app/app/shared/paginado/widgets/base_items_view_widget.dart';
import 'package:gastos_app/app/shared/paginado/widgets/base_list_contenedor_widget.dart';
import 'package:gastos_app/app/shared/paginado/widgets/base_search_bar_widget.dart';
import 'package:gastos_app/app/shared/paginado/widgets/base_tab_bar_widget.dart';

class BaseMainListState<T> extends State<BaseMainList<T>> {
  final RefreshController _refreshController = RefreshController();

  List<T> _items = [];
  int _currentPage = BaseMainListConstants.paginaInicial;
  int _totalItems = 0;
  bool _ocupado = false;
  int _tabIndex = 0;
  String _busqueda = '';

  BaseTab<T>? get _tabActual {
    final tabs = widget.tabs;
    if (tabs == null || tabs.isEmpty) return null;
    return tabs[_tabIndex];
  }

  bool get _tabTienePagina => _tabActual?.pageBuilder != null;

  List<T> get _filteredItems {
    final filtro = _tabActual?.filtro;
    if (filtro == null) return _items;
    return _items.where(filtro).toList();
  }

  Future<PaginatedResponse<T>> _cargarDatos(int page, String search) {
    final loadDataFn = _tabActual?.loadDataFn;
    return loadDataFn != null
        ? loadDataFn(page, search)
        : widget.loadData(page, search);
  }

  void _onTabChanged(int index) {
    if (_tabIndex == index) return;
    setState(() => _tabIndex = index);
    if (_tabTienePagina) _busqueda = '';
    if (!_tabTienePagina) _onRefresh();
  }

  void _onBuscar(String busqueda) {
    _busqueda = busqueda;
    _onRefresh();
  }

  void _aplicarPrimeraPagina(PaginatedResponse<T> res) {
    setState(() {
      _items = List<T>.from(res.datos);
      _totalItems = res.total;
    });
  }

  Future<void> manualRefresh() async => _onRefresh();

  /****************************** SILENT REFRESH ******************************/
  Future<void> silentRefresh() async {
    if (_ocupado || _tabTienePagina) return;
    _ocupado = true;
    _currentPage = BaseMainListConstants.paginaInicial;
    try {
      final res = await _cargarDatos(_currentPage, _busqueda);
      if (!mounted) return;
      _aplicarPrimeraPagina(res);
    } catch (error) {
      debugPrint('${BaseMainListStrings.errorRefrescoSilencioso}: $error');
    } finally {
      _ocupado = false;
    }
  }

  Future<void> _onRefresh() async {
    if (_ocupado) {
      _refreshController.refreshCompleted();
      return;
    }
    _ocupado = true;
    _currentPage = BaseMainListConstants.paginaInicial;
    _refreshController.resetNoData();
    try {
      final res = await _cargarDatos(_currentPage, _busqueda);
      if (!mounted) return;
      _aplicarPrimeraPagina(res);
      _refreshController.refreshCompleted();
      if (_items.length >= _totalItems) _refreshController.loadNoData();
    } catch (error) {
      if (mounted) _refreshController.refreshFailed();
    } finally {
      _ocupado = false;
    }
  }

  Future<void> _onLoading() async {
    if (_ocupado) {
      _refreshController.loadComplete();
      return;
    }
    if (_items.length >= _totalItems) {
      _refreshController.loadNoData();
      return;
    }
    _ocupado = true;
    _currentPage++;
    try {
      final res = await _cargarDatos(_currentPage, _busqueda);
      if (!mounted) return;
      setState(() => _items.addAll(res.datos));
      _refreshController.loadComplete();
    } catch (error) {
      _currentPage--;
      if (mounted) _refreshController.loadFailed();
    } finally {
      _ocupado = false;
    }
  }

  Widget _buildLista(BuildContext context) {
    final paginaTab = _tabActual?.pageBuilder;
    if (paginaTab != null) return paginaTab(context);
    return BaseItemsViewWidget<T>(
      refreshController: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      items: _filteredItems,
      columnas: widget.crossAxisCount,
      aspectRatio: widget.getChildAspectRatio(context),
      padding: widget.padding,
      itemBuilder: widget.buildItem,
    );
  }

  Widget _buildContenido(BuildContext context) {
    final tabs = widget.tabs;
    final subHeader = widget.buildSubHeader(context);
    final subSearch = widget.buildSubSearch(context);
    final preList = widget.buildPreList(context, _onRefresh);
    final footer = widget.footer;

    return Column(
      children: [
        ?subHeader,
        if (!_tabTienePagina)
          BaseSearchBarWidget(
            onBuscar: _onBuscar,
            accionesExtra: widget.buildSearchActions(context),
          ),
        if (!_tabTienePagina) ?subSearch,
        if (tabs != null && tabs.isNotEmpty)
          BaseTabBarWidget<T>(
            tabs: tabs,
            indiceSeleccionado: _tabIndex,
            onTabChanged: _onTabChanged,
            widgetFinal: widget.buildFilterButton(context),
          ),
        if (!_tabTienePagina) ?preList,
        Expanded(child: _buildLista(context)),
        ?footer,
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    widget.cargardatos(context);
    _onRefresh();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseListContenedorWidget(
      mostrarAppBar: widget.showAppBar,
      titulo: widget.title,
      acciones: widget.buildActionsHeader(context),
      floatingActionButton: widget.floatingActionButton,
      child: _buildContenido(context),
    );
  }
}
