/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/utils/formato_helpers.dart';
import 'package:gastos_app/app/core/utils/monto_input_formatter.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/widgets/formularios/campo_texto_widget.dart';

/********************************* FEATURE **********************************/
import '../constants/periodo_strings.dart';

/****************************** DIALOGO EDITAR PISO ***************************/
class DialogoEditarPisoWidget extends StatefulWidget {
  final int pisoCentavosActual;

  const DialogoEditarPisoWidget({
    super.key,
    required this.pisoCentavosActual,
  });

  @override
  State<DialogoEditarPisoWidget> createState() =>
      _DialogoEditarPisoWidgetState();
}

class _DialogoEditarPisoWidgetState extends State<DialogoEditarPisoWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: FormatoHelpers.formatearNumero(widget.pisoCentavosActual),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(PeriodoStrings.editarPiso),
      content: CampoTextoWidget(
        controller: _controller,
        keyboardType: TextInputType.number,
        inputFormatters: const [MontoInputFormatter()],
        hint: PeriodoStrings.pisoBs,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            final nuevoPiso =
                FormatoHelpers.parsearMonto(_controller.text);
            Navigator.of(context).pop(nuevoPiso);
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
