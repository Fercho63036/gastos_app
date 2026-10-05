import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/theme/app_colores.dart';

import '../constants/inicio_strings.dart';

enum CategoriaMovimiento {
  comida(InicioStrings.comida, Icons.restaurant, AppColores.categoriaComida),
  pasajes(
    InicioStrings.pasajes,
    Icons.directions_bus_outlined,
    AppColores.categoriaPasajes,
  ),
  diversion(
    InicioStrings.diversion,
    CupertinoIcons.star,
    AppColores.categoriaDiversion,
  );

  final String nombre;
  final IconData icono;
  final Color color;

  const CategoriaMovimiento(this.nombre, this.icono, this.color);
}
