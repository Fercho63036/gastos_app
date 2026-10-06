/********************************** SHARED **********************************/
import '../models/resumen_mes_model.dart';
import 'api_claves.dart';
import 'json_helpers.dart';

class ResumenDto {
  ResumenDto._();

  static ResumenMes desdeJson(Json json) => ResumenMes(
    saldoCentavos: json[ApiClaves.saldoCentavos] as int,
    gastableCentavos: json[ApiClaves.gastableCentavos] as int,
    gastableTotalCentavos: json[ApiClaves.gastableTotalCentavos] as int,
    pisoCentavos: json[ApiClaves.pisoCentavos] as int,
    entradasCentavos: json[ApiClaves.entradasCentavos] as int,
    gastadoCentavos: json[ApiClaves.gastadoCentavos] as int,
  );

  static Json aJson(ResumenMes resumen) => {
    ApiClaves.saldoCentavos: resumen.saldoCentavos,
    ApiClaves.gastableCentavos: resumen.gastableCentavos,
    ApiClaves.gastableTotalCentavos: resumen.gastableTotalCentavos,
    ApiClaves.pisoCentavos: resumen.pisoCentavos,
    ApiClaves.entradasCentavos: resumen.entradasCentavos,
    ApiClaves.gastadoCentavos: resumen.gastadoCentavos,
  };
}
