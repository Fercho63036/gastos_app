/****************************** FLUTTER / DART ******************************/
import 'dart:async';
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/constants/app_duraciones.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/paginado/constants/base_main_list_strings.dart';

/************************** BASE SEARCH BAR WIDGET **************************/
class BaseSearchBarWidget extends StatefulWidget {
  final ValueChanged<String> onBuscar;
  final List<Widget>? accionesExtra;

  const BaseSearchBarWidget({
    super.key,
    required this.onBuscar,
    this.accionesExtra,
  });

  @override
  State<BaseSearchBarWidget> createState() => _BaseSearchBarWidgetState();
}

class _BaseSearchBarWidgetState extends State<BaseSearchBarWidget> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  void _onChanged(String texto) {
    setState(() {});
    _debounce?.cancel();
    _debounce = Timer(
      AppDuraciones.debounceBusqueda,
      () => widget.onBuscar(_controller.text),
    );
  }

  void _onLimpiar() {
    _debounce?.cancel();
    _controller.clear();
    setState(() {});
    widget.onBuscar(_controller.text);
  }

  InputDecoration _buildDecoracion(Color colorTenue) {
    return InputDecoration(
      hintText: BaseMainListStrings.buscar,
      hintStyle: TextStyle(color: colorTenue, fontSize: AppDimensions.fontM),
      prefixIcon: Icon(
        Icons.search,
        color: colorTenue,
        size: AppDimensions.iconM,
      ),
      suffixIcon: _controller.text.isEmpty
          ? null
          : IconButton(
              icon: const Icon(Icons.close, size: AppDimensions.iconS),
              color: colorTenue,
              onPressed: _onLimpiar,
            ),
      filled: false,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingSM,
      ),
      isDense: true,
    );
  }

  Widget _buildCampo(ColorScheme colorScheme) {
    final colorTenue = colorScheme.onSurface.withValues(
      alpha: AppDimensions.opacidadInactivo,
    );
    return Container(
      height: AppDimensions.alturaBuscador,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(
          color: colorScheme.onSurface.withValues(
            alpha: AppDimensions.opacidadBorde,
          ),
        ),
      ),
      child: TextField(
        controller: _controller,
        onChanged: _onChanged,
        textAlignVertical: TextAlignVertical.center,
        decoration: _buildDecoracion(colorTenue),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final acciones = widget.accionesExtra;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.paddingSM,
        AppDimensions.paddingBuscadorSuperior,
        AppDimensions.paddingSM,
        AppDimensions.paddingBuscadorInferior,
      ),
      child: Row(
        children: [
          Expanded(child: _buildCampo(Theme.of(context).colorScheme)),
          if (acciones != null) ...acciones,
        ],
      ),
    );
  }
}
