/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/*********************** BASE LIST CONTENEDOR WIDGET ************************/
class BaseListContenedorWidget extends StatelessWidget {
  final bool mostrarAppBar;
  final String? titulo;
  final List<Widget>? acciones;
  final Widget? floatingActionButton;
  final Widget child;

  const BaseListContenedorWidget({
    super.key,
    required this.mostrarAppBar,
    required this.child,
    this.titulo,
    this.acciones,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final tituloAppBar = titulo;
    final fab = floatingActionButton;
    if (mostrarAppBar) {
      return Scaffold(
        appBar: tituloAppBar == null
            ? null
            : AppBar(title: Text(tituloAppBar), actions: acciones),
        floatingActionButton: fab,
        body: child,
      );
    }
    return Stack(
      children: [
        child,
        if (fab != null)
          Positioned(
            bottom: AppDimensions.paddingM,
            right: AppDimensions.paddingM,
            child: fab,
          ),
      ],
    );
  }
}
