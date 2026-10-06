/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/widgets/estructura/encabezado_formulario_widget.dart';
import 'package:gastos_app/app/shared/widgets/estructura/tarjeta_layout_widget.dart';

/********************************* FEATURE **********************************/
import '../constants/perfil_strings.dart';
import '../widgets/formularios/formulario_editar_perfil_widget.dart';

class EditarPerfilPage extends StatelessWidget {
  const EditarPerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TarjetaLayoutWidget(
      mostrarBotonVolver: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EncabezadoFormularioWidget(
            titulo: PerfilStrings.editarDatosTitulo,
            subtitulo: PerfilStrings.editarDatosSubtitulo,
          ),
          FormularioEditarPerfilWidget(),
        ],
      ),
    );
  }
}
