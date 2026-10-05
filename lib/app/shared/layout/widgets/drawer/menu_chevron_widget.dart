import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/shared/layout/utils/menu_colores.dart';

class MenuChevronWidget extends StatelessWidget {
  final IconData icono;

  const MenuChevronWidget({
    super.key,
    this.icono = CupertinoIcons.chevron_right,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Icon(
      icono,
      size: AppDimensions.iconXS,
      color: MenuColores.chevron(colorScheme),
    );
  }
}
