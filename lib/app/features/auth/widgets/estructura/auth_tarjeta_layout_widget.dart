/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/utils/responsive_helper.dart';

/********************************* FEATURE **********************************/
import 'boton_tema_auth_widget.dart';

/************************ AUTH TARJETA LAYOUT WIDGET ************************/
class AuthTarjetaLayoutWidget extends StatelessWidget {
  final Widget child;

  const AuthTarjetaLayoutWidget({super.key, required this.child});

  Widget _buildBotonTema(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: ResponsiveHelper.paddingAll(context),
          child: const BotonTemaAuthWidget(),
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
      body: Stack(children: [_buildBotonTema(context), _buildTarjeta(context)]),
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
