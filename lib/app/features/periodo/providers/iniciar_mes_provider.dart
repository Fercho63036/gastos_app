/****************************** FLUTTER / DART ******************************/
import 'package:flutter/widgets.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/utils/formato_helpers.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/models/fila_resumen_model.dart';
import 'package:gastos_app/app/shared/services/movimientos_service.dart';
import 'package:gastos_app/app/shared/utils/guardado_mixin.dart';

/********************************* FEATURE **********************************/
import '../utils/periodo_helpers.dart';

/*************************** INICIAR MES PROVIDER ***************************/
class IniciarMesProvider extends ChangeNotifier with GuardadoMixin {
  final MovimientosService _datos;
  final bool editando;
  final int arrastradoCentavos;
  final String tituloMes;
  final String textoSobrante;
  final TextEditingController montoController;
  final TextEditingController pisoController;

  factory IniciarMesProvider(MovimientosService datos, DateTime ahora) {
    final editando = PeriodoHelpers.esMesActual(datos.periodoActual, ahora);
    return IniciarMesProvider._(
      datos,
      ahora,
      editando: editando,
      arrastradoCentavos: editando
          ? datos.periodoActual!.arrastradoCentavos
          : datos.resumen.saldoCentavos,
      montoPrecargado: editando
          ? FormatoHelpers.formatearNumero(
              datos.periodoActual!.montoMesCentavos,
            )
          : '',
    );
  }

  IniciarMesProvider._(
    this._datos,
    DateTime ahora, {
    required this.editando,
    required this.arrastradoCentavos,
    required String montoPrecargado,
  }) : tituloMes = FormatoHelpers.formatearMesAnio(ahora),
       textoSobrante = PeriodoHelpers.textoSobrante(_datos.periodoActual),
       montoController = TextEditingController(text: montoPrecargado),
       pisoController = TextEditingController(
         text: PeriodoHelpers.pisoPrecargado(_datos.periodoActual),
       ) {
    montoController.addListener(notifyListeners);
    pisoController.addListener(notifyListeners);
  }

  int get _montoMes => FormatoHelpers.parsearMonto(montoController.text);
  int get _piso => FormatoHelpers.parsearMonto(pisoController.text);

  List<FilaResumen> get filasResumen => PeriodoHelpers.filasResumen(
    arrastradoCentavos: arrastradoCentavos,
    montoMesCentavos: _montoMes,
    pisoCentavos: _piso,
  );

  /********************************* INICIAR **********************************/
  Future<String?> iniciar() => guardarConEstado(() async {
    final error = PeriodoHelpers.validar(
      montoMesCentavos: _montoMes,
      pisoCentavos: _piso,
      saldoInicialCentavos: arrastradoCentavos + _montoMes,
    );
    if (error != null) return error;
    if (editando) {
      await _datos.actualizarMontoMes(
        montoMesCentavos: _montoMes,
        pisoCentavos: _piso,
      );
    } else {
      await _datos.iniciarMes(
        montoMesCentavos: _montoMes,
        pisoCentavos: _piso,
      );
    }
    return null;
  });

  @override
  void dispose() {
    montoController.dispose();
    pisoController.dispose();
    super.dispose();
  }
}
