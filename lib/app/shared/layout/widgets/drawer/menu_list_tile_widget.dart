import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/// ListTile base del Drawer: mismo espaciado, icono y tipografía para items,
/// cabeceras expandibles y "Cerrar sesión".
class MenuListTileWidget extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final Color color;
  final bool resaltado;
  final Widget trailing;
  final VoidCallback? onTap;

  const MenuListTileWidget({
    super.key,
    required this.icono,
    required this.titulo,
    required this.color,
    required this.trailing,
    this.resaltado = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(
        vertical: AppDimensions.densidadVerticalMenu,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSM,
      ),
      minLeadingWidth: AppDimensions.anchoMinimoLeadingMenu,
      leading: Icon(icono, size: AppDimensions.iconM, color: color),
      title: Text(
        titulo,
        style: TextStyle(
          fontSize: AppDimensions.fontM,
          fontWeight: resaltado ? FontWeight.w600 : FontWeight.w400,
          color: color,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
