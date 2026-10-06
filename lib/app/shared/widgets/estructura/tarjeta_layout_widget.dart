/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/theme/app_colores.dart';
import 'package:gastos_app/app/core/utils/responsive_helper.dart';

/********************************* FEATURE **********************************/
import 'boton_tema_widget.dart';
import 'boton_volver_widget.dart';
import 'circulo_fondo_widget.dart';

/************************** TARJETA LAYOUT WIDGET ****************************/
class TarjetaLayoutWidget extends StatelessWidget {
  final Widget child;
  final bool mostrarBotonVolver;
  final VoidCallback? onVolver;

  const TarjetaLayoutWidget({
    super.key,
    required this.child,
    this.mostrarBotonVolver = false,
    this.onVolver,
  });

  Widget _buildBotonTema(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: ResponsiveHelper.paddingAll(context),
          child: const BotonTemaWidget(),
        ),
      ),
    );
  }

  Widget _buildBotonVolver(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: ResponsiveHelper.paddingAll(context),
          child: CirculoFondoWidget(
            child: BotonVolverWidget(
              onPressed: onVolver,
              color: AppColores.blanco,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTarjeta(BuildContext context) {
    final fraccionTarjeta = ResponsiveHelper.isMobile(context)
        ? AppDimensions.fraccionAlturaTarjetaAuthMovil
        : AppDimensions.fraccionAlturaTarjetaAuthAmplia;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: ResponsiveHelper.fraccionAlto(context, fraccionTarjeta),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(AppDimensions.radiusTarjetaAuth),
          ),
        ),
        child: _ContenidoDesplazable(child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          if (mostrarBotonVolver) _buildBotonVolver(context),
          _buildBotonTema(context),
          _buildTarjeta(context),
        ],
      ),
    );
  }
}

class _ContenidoDesplazable extends StatelessWidget {
  final Widget child;

  const _ContenidoDesplazable({required this.child});

  @override
  Widget build(BuildContext context) {
    final tecladoInferior = MediaQuery.viewInsetsOf(context).bottom;

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: ResponsiveHelper.paddingHorizontal(context).copyWith(
        top: AppDimensions.paddingSM,
        bottom: tecladoInferior + AppDimensions.paddingL,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppDimensions.anchoMaximoFormulario,
          ),
          child: child,
        ),
      ),
    );
  }
}
