import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/utils/responsive_helper.dart';

import 'boton_tema_auth_widget.dart';

/// Estructura común de login/registro/recuperar: fondo de color arriba,
/// tarjeta con esquina redondeada abajo y botón de tema.
class AuthTarjetaLayoutWidget extends StatelessWidget {
  final Widget child;

  const AuthTarjetaLayoutWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final fraccionTarjeta = ResponsiveHelper.isMobile(context)
        ? AppDimensions.fraccionAlturaTarjetaAuthMovil
        : AppDimensions.fraccionAlturaTarjetaAuthAmplia;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: Stack(
        children: [
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: ResponsiveHelper.paddingAll(context),
                child: const BotonTemaAuthWidget(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: ResponsiveHelper.fraccionAlto(context, fraccionTarjeta),
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(AppDimensions.radiusTarjetaAuth),
                ),
              ),
              child: _ContenidoDesplazable(child: child),
            ),
          ),
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
