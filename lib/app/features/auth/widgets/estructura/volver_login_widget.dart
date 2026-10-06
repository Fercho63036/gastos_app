/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/routes/route_names.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/utils/navegacion_helpers.dart';

/********************************* FEATURE **********************************/
import '../../constants/auth_strings.dart';

class VolverLoginWidget extends StatelessWidget {
  const VolverLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => NavegacionHelpers.volverOIr(context, RouteNames.auth),
      child: const Text(AuthStrings.volverALogin),
    );
  }
}
