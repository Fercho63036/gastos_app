class ValidacionConstants {
  ValidacionConstants._();

  static const int longitudMinimaNombre = 2;

  static final RegExp patronCorreo = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
}
