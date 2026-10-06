/****************************** FLUTTER / DART ******************************/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/********************************** SHARED **********************************/
import '../../constants/comun_strings.dart';
import '../../utils/navegacion_helpers.dart';

/**************************** BOTON VOLVER WIDGET ****************************/
class BotonVolverWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;

  const BotonVolverWidget({super.key, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(CupertinoIcons.back),
      tooltip: ComunStrings.volver,
      color: color,
      onPressed: onPressed ?? () => NavegacionHelpers.volver(context),
    );
  }
}
