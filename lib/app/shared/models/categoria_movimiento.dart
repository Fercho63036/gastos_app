import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/theme/app_colores.dart';

import '../constants/dominio_strings.dart';

enum CategoriaMovimiento {
  comida(DominioStrings.comida, Icons.restaurant, AppColores.categoriaComida),
  pasajes(
    DominioStrings.pasajes,
    Icons.directions_bus_outlined,
    AppColores.categoriaPasajes,
  ),
  diversion(
    DominioStrings.diversion,
    CupertinoIcons.star,
    AppColores.categoriaDiversion,
  ),
  ropa(DominioStrings.ropa, Icons.checkroom, AppColores.categoriaRopa),
  deportes(
    DominioStrings.deportes,
    Icons.sports_soccer,
    AppColores.categoriaDeportes,
  ),
  otros(DominioStrings.otros, Icons.more_horiz, AppColores.categoriaOtros),
  entrada(
    DominioStrings.entrada,
    Icons.add_circle_outline,
    AppColores.categoriaEntrada,
  );

  final String nombre;
  final IconData icono;
  final Color color;

  const CategoriaMovimiento(this.nombre, this.icono, this.color);

  /// Las que se pueden elegir al registrar o editar un gasto.
  static const List<CategoriaMovimiento> deGasto = [
    comida,
    pasajes,
    diversion,
    ropa,
    deportes,
    otros,
  ];
}
