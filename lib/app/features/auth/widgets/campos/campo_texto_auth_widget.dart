/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/app_dimensions.dart';

class CampoTextoAuthWidget extends StatelessWidget {
  final TextEditingController controller;
  final String etiqueta;
  final IconData icono;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;

  const CampoTextoAuthWidget({
    super.key,
    required this.controller,
    required this.etiqueta,
    required this.icono,
    required this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        validator: validator,
        decoration: InputDecoration(
          labelText: etiqueta,
          prefixIcon: Icon(icono, size: AppDimensions.iconS),
        ),
      ),
    );
  }
}
