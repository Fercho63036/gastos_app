/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/******************************* APP COLORES ********************************/
class AppColores {
  AppColores._();

  static const Color primario = Color(0xFF2E7D32);
  static const Color primarioOscuro = Color(0xFF81C784);

  static const Color secundario = Color(0xFF00897B);
  static const Color secundarioOscuro = Color(0xFF80CBC4);

  static const Color exito = Color(0xFF4CAF7A);
  static const Color exitoOscuro = Color(0xFF57C084);

  static const Color peligro = Color(0xFFE53935);

  static const Color blanco = Colors.white;
  static const Color negro = Colors.black;

  /******************************** MODO CLARO ********************************/
  static const Color fondoClaro = Color(0xFFF1F8F2);
  static const Color superficieClara = Colors.white;
  static const Color bordeClaro = Color(0xFFCFE3D2);

  /******************************* MODO OSCURO ********************************/
  static const Color fondoOscuro = Color(0xFF0F1F17);
  static const Color superficieOscura = Color(0xFF1B3226);
  static const Color bordeOscuro = Color(0xFF2F4F3D);

  /**************** ENCABEZADO Y BARRA INFERIOR (AMBOS MODOS) *****************/
  static const Color barra = primario;
  static const Color textoBarra = blanco;

  /****************** INICIO: TARJETA DE SALDO (AMBOS MODOS) ******************/
  static const Color tarjetaSaldo = Color(0xFF1B5E20);
  static const Color textoTarjetaSaldo = Color(0xFFFFFFFF);
  static const Color pistaProgresoSaldo = Color(0xFF4E9A53);
  static const Color fondoMetricaTarjeta = Color(0x40FFFFFF); // blanco 25% opacidad
  static const double opacidadTextoAtenuado = 0.70;

  /*************** INICIO: CATEGORÍAS Y ESTADOS DE MOVIMIENTOS ****************/
  static const Color categoriaComida = Color(0xFFF2B84B);
  static const Color categoriaPasajes = Color(0xFF4DD0E1);
  static const Color categoriaDiversion = Color(0xFFF08BC0);
  static const Color categoriaRopa = Color(0xFF64B5F6);
  static const Color categoriaDeportes = Color(0xFFFF9E80);
  static const Color categoriaOtros = Color(0xFFA5B4A8);
  static const Color categoriaEntrada = exitoOscuro;
  static const Color alertaAnulado = Color(0xFFFFB300);
}
