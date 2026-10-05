import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

import '../../constants/auth_strings.dart';

class CampoContrasenaWidget extends StatefulWidget {
  final TextEditingController controller;
  final String etiqueta;
  final FormFieldValidator<String> validator;

  const CampoContrasenaWidget({
    super.key,
    required this.controller,
    required this.etiqueta,
    required this.validator,
  });

  @override
  State<CampoContrasenaWidget> createState() => _CampoContrasenaWidgetState();
}

class _CampoContrasenaWidgetState extends State<CampoContrasenaWidget> {
  bool _oculta = true;

  void _alternarVisibilidad() => setState(() => _oculta = !_oculta);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _oculta,
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.etiqueta,
          prefixIcon: const Icon(
            CupertinoIcons.lock,
            size: AppDimensions.iconS,
          ),
          suffixIcon: IconButton(
            iconSize: AppDimensions.iconS,
            tooltip: _oculta
                ? AuthStrings.mostrarContrasena
                : AuthStrings.ocultarContrasena,
            icon: Icon(_oculta ? CupertinoIcons.eye : CupertinoIcons.eye_slash),
            onPressed: _alternarVisibilidad,
          ),
        ),
      ),
    );
  }
}
