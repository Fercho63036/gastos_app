import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/config/app_config.dart';
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/shared/layout/constants/layout_strings.dart';
import 'package:gastos_app/app/shared/layout/widgets/app_brand_logo_widget.dart';
import 'package:gastos_app/app/shared/layout/widgets/boton_tema_app_bar_widget.dart';

class AppBarPrincipalWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarPrincipalWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: AppDimensions.elevacionNula,
      title: Row(
        spacing: AppDimensions.paddingS,
        children: [
          Builder(
            builder: (scaffoldContext) => IconButton(
              icon: Icon(Icons.menu, color: colorScheme.onSurface),
              iconSize: AppDimensions.iconM,
              tooltip: LayoutStrings.menu,
              onPressed: () => Scaffold.of(scaffoldContext).openDrawer(),
            ),
          ),
          const AppBrandLogoWidget(
            width: AppDimensions.anchoLogoAppBar,
            height: AppDimensions.altoLogoAppBar,
          ),
          const Text(AppConfig.appName),
        ],
      ),
      actions: const [
        BotonTemaAppBarWidget(),
        SizedBox(width: AppDimensions.paddingXS),
      ],
    );
  }
}
