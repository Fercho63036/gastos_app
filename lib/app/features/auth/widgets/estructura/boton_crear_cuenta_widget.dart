/****************************** FLUTTER / DART ******************************/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:go_router/go_router.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/routes/route_names.dart';

/********************************* FEATURE **********************************/
import '../../constants/auth_strings.dart';

class BotonCrearCuentaWidget extends StatelessWidget {
  const BotonCrearCuentaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.alturaBoton,
      child: OutlinedButton.icon(
        onPressed: () => context.go(RouteNames.registro),
        icon: const Icon(
          CupertinoIcons.person_badge_plus,
          size: AppDimensions.iconS,
        ),
        label: const Text(AuthStrings.crearCuenta),
      ),
    );
  }
}
