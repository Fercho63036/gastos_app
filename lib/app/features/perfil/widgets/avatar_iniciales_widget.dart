/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

class AvatarInicialesWidget extends StatelessWidget {
  /******************************** PROPIEDADES ********************************/
  final String? nombre;
  final String? correo;

  /******************************** CONSTRUCTOR ********************************/
  const AvatarInicialesWidget({super.key, this.nombre, this.correo});

  /******************************** INICIALES ********************************/
  String _iniciales() {
    final nombreCompleto = nombre?.trim();
    if (nombreCompleto != null && nombreCompleto.isNotEmpty) {
      final partes = nombreCompleto.split(RegExp(r'\s+'));
      final primeras = partes.take(2).map((parte) => parte[0].toUpperCase());
      return primeras.join();
    }
    final correoUsuario = correo?.trim();
    if (correoUsuario != null && correoUsuario.isNotEmpty) {
      return correoUsuario[0].toUpperCase();
    }
    return '';
  }

  /************************************ BUILD ************************************/
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CircleAvatar(
      radius: AppDimensions.radioAvatarPerfil,
      backgroundColor: colorScheme.primaryContainer,
      child: Text(
        _iniciales(),
        style: TextStyle(
          fontSize: AppDimensions.fontInicialesAvatar,
          fontWeight: FontWeight.w700,
          color: colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
