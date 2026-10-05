import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/utils/responsive_helper.dart';

import '../../constants/comun_strings.dart';
import '../../utils/navegacion_helpers.dart';
import '../botones/boton_primario_widget.dart';

/// Pantalla completa de formulario: AppBar con volver, contenido con scroll
/// y botón principal fijo abajo.
class PaginaFormularioWidget extends StatelessWidget {
  final String titulo;
  final List<Widget> children;
  final String textoBoton;
  final VoidCallback onConfirmar;
  final bool cargando;

  const PaginaFormularioWidget({
    super.key,
    required this.titulo,
    required this.children,
    required this.textoBoton,
    required this.onConfirmar,
    this.cargando = false,
  });

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(CupertinoIcons.back),
        tooltip: ComunStrings.volver,
        onPressed: () => NavegacionHelpers.volver(context),
      ),
      titleSpacing: AppDimensions.elevacionNula,
      title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }

  Widget _buildBoton(EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: BotonPrimarioWidget(
        texto: textoBoton,
        cargando: cargando,
        onPressed: onConfirmar,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveHelper.paddingAll(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: AppDimensions.paddingM,
                  children: children,
                ),
              ),
            ),
            _buildBoton(padding),
          ],
        ),
      ),
    );
  }
}
