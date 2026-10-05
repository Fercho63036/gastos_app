import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/config/app_config.dart';
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/shared/layout/widgets/app_brand_logo_widget.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final paddingSuperior = MediaQuery.paddingOf(context).top;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      height: paddingSuperior + AppDimensions.alturaDrawerHeader,
      padding: EdgeInsets.only(
        top: paddingSuperior + AppDimensions.paddingSM,
        left: AppDimensions.paddingM,
        bottom: AppDimensions.paddingSM,
      ),
      child: Row(
        children: [
          const AppBrandLogoWidget(
            width: AppDimensions.anchoLogoDrawer,
            height: AppDimensions.altoLogoDrawer,
          ),
          const SizedBox(width: AppDimensions.paddingSM),
          Text(
            AppConfig.appName,
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
