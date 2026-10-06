/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/**************************** PAQUETES EXTERNOS *****************************/
import 'package:go_router/go_router.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/layout/widgets/app_bar_principal_widget.dart';
import 'package:gastos_app/app/shared/layout/widgets/app_tab_bar_widget.dart';
import 'package:gastos_app/app/shared/layout/widgets/drawer/menu_drawer_widget.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final bool mostrarTabBar;

  const MainLayout({super.key, required this.child, this.mostrarTabBar = true});

  @override
  Widget build(BuildContext context) {
    final rutaActual = GoRouterState.of(context).uri.path;

    return Scaffold(
      appBar: const AppBarPrincipalWidget(),
      drawer: MenuDrawerWidget(rutaActual: rutaActual),
      body: child,
      bottomNavigationBar: mostrarTabBar
          ? AppTabBarWidget(
              rutaActual: rutaActual,
              onTabSeleccionado: context.go,
            )
          : null,
    );
  }
}
