import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gastos_app/app/core/constants/app_dimensions.dart';

/// Campo de texto relleno con el estilo del tema; sirve para texto o montos.
class CampoTextoWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final TextStyle? estilo;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final TextInputAction textInputAction;

  const CampoTextoWidget({
    super.key,
    required this.controller,
    this.hint,
    this.estilo,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      textCapitalization: TextCapitalization.sentences,
      style: estilo ?? const TextStyle(fontSize: AppDimensions.fontL),
      decoration: InputDecoration(hintText: hint),
    );
  }
}
