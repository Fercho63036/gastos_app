import 'package:flutter/material.dart';

/// Paleta blanco + morado, tomada de los fondos del logo:
/// fondo lavanda (claro) o morado medio (oscuro), barras violeta en ambos.
class AppColores {
  AppColores._();

  static const Color primario = Color(0xFF5B45C9);
  static const Color primarioOscuro = Color(0xFF9D88F7);

  static const Color secundario = Color(0xFF8E7CE6);
  static const Color secundarioOscuro = Color(0xFFBBA9FB);

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
  static const Color fondoOscuro = Color(0xFF2D2468);
  static const Color superficieOscura = Color(0xFF3A2F82);
  static const Color bordeOscuro = Color(0xFF5446A8);

  // Encabezado y barra inferior (ambos modos)
  static const Color barra = primario;
  static const Color textoBarra = blanco;

  // Inicio: tarjeta de saldo (ambos modos)
  static const Color tarjetaSaldo = Color(0xFF9C8EEB);
  static const Color textoTarjetaSaldo = Color(0xFF1E1A3C);
  static const Color pistaProgresoSaldo = Color(0xFF7C6CD6);

  // Inicio: categorías y estados de movimientos
  static const Color categoriaComida = Color(0xFFF2B84B);
  static const Color categoriaPasajes = Color(0xFF7FB2F0);
  static const Color categoriaDiversion = Color(0xFFF08BC0);
  static const Color alertaAnulado = Color(0xFFFFB37A);
}
