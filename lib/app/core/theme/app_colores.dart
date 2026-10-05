import 'package:flutter/material.dart';

/// Paleta blanco + morado, tomada de los fondos del logo:
/// lavanda (claro) / índigo (oscuro).
class AppColores {
  AppColores._();

  static const Color primario = Color(0xFF5B45C9);
  static const Color primarioOscuro = Color(0xFFB3A4F5);

  static const Color secundario = Color(0xFF8E7CE6);
  static const Color secundarioOscuro = Color(0xFFCFC5FA);

  static const Color exito = Color(0xFF4CAF7A);
  static const Color exitoOscuro = Color(0xFF57C084);

  static const Color peligro = Color(0xFFE53935);

  static const Color blanco = Colors.white;
  static const Color negro = Colors.black;

  // Modo claro
  static const Color fondoClaro = Color(0xFFF4F2FC);
  static const Color superficieClara = Colors.white;
  static const Color bordeClaro = Color(0xFFDCD8EE);

  // Modo oscuro
  static const Color fondoOscuro = Color(0xFF1E1748);
  static const Color superficieOscura = Color(0xFF2A2160);
  static const Color bordeOscuro = Color(0xFF3D3290);
}
