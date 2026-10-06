/****************************** FLUTTER / DART ******************************/
import 'package:flutter/widgets.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:go_router/go_router.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/routes/route_names.dart';

class NavegacionHelpers {
  NavegacionHelpers._();

  /********************************** VOLVER **********************************/
  static void volver(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(RouteNames.home);
    }
  }
}
