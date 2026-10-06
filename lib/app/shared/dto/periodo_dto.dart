import '../models/periodo_mes_model.dart';
import 'api_claves.dart';
import 'json_helpers.dart';

class PeriodoDto {
  PeriodoDto._();

  static PeriodoMes desdeJson(Json json) => PeriodoMes(
    inicio: JsonHelpers.fechaDesdeJson(json[ApiClaves.inicio]),
    arrastradoCentavos: json[ApiClaves.arrastradoCentavos] as int,
    montoMesCentavos: json[ApiClaves.montoMesCentavos] as int,
    pisoCentavos: json[ApiClaves.pisoCentavos] as int,
  );

  static Json aJson(PeriodoMes periodo) => {
    ApiClaves.inicio: JsonHelpers.fechaAJson(periodo.inicio),
    ApiClaves.arrastradoCentavos: periodo.arrastradoCentavos,
    ApiClaves.montoMesCentavos: periodo.montoMesCentavos,
    ApiClaves.pisoCentavos: periodo.pisoCentavos,
  };

  /// Cuerpo de `POST /periodos`; el arrastre lo calcula el servidor.
  static Json inicioMesAJson({
    required int montoMesCentavos,
    required int pisoCentavos,
  }) => {
    ApiClaves.montoMesCentavos: montoMesCentavos,
    ApiClaves.pisoCentavos: pisoCentavos,
  };
}
