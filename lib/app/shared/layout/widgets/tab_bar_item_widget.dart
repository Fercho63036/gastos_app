import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';
import 'package:gastos_app/app/core/constants/app_duraciones.dart';
import 'package:gastos_app/app/shared/layout/models/tab_bar_model.dart';
import 'package:gastos_app/app/shared/layout/utils/menu_colores.dart';

class TabBarItemWidget extends StatelessWidget {
  final TabBarItem item;
  final bool estaActivo;
  final VoidCallback onTap;

  const TabBarItemWidget({
    super.key,
    required this.item,
    required this.estaActivo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = MenuColores.textoTab(activo: estaActivo);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppDimensions.paddingXS,
        children: [
          _IconoTabWidget(item: item, estaActivo: estaActivo, color: color),
          Text(
            item.titulo,
            style: TextStyle(
              fontSize: AppDimensions.fontXS,
              fontWeight: estaActivo ? FontWeight.w600 : FontWeight.w400,
              color: color,
            ),
          ),
          _IndicadorTabWidget(estaActivo: estaActivo),
        ],
      ),
    );
  }
}

class _IndicadorTabWidget extends StatelessWidget {
  final bool estaActivo;

  const _IndicadorTabWidget({required this.estaActivo});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppDuraciones.animacionLenta,
      curve: Curves.easeOutCubic,
      height: AppDimensions.altoIndicadorTab,
      width: estaActivo ? AppDimensions.anchoIndicadorTab : 0,
      decoration: BoxDecoration(
        color: MenuColores.textoTab(activo: true),
        borderRadius: BorderRadius.circular(AppDimensions.paddingXXS),
      ),
    );
  }
}

class _IconoTabWidget extends StatelessWidget {
  final TabBarItem item;
  final bool estaActivo;
  final Color color;

  const _IconoTabWidget({
    required this.item,
    required this.estaActivo,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppDuraciones.animacionRapida,
      child: Icon(
        estaActivo ? item.iconoActivo : item.icono,
        key: ValueKey(estaActivo),
        size: AppDimensions.iconL,
        color: color,
      ),
    );
  }
}
