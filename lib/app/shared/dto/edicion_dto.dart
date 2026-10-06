/********************************** SHARED **********************************/
import '../models/campo_edicion.dart';
import '../models/edicion_movimiento_model.dart';
import 'api_claves.dart';
import 'json_helpers.dart';

class EdicionDto {
  EdicionDto._();

  static EdicionMovimiento desdeJson(Json json) => EdicionMovimiento(
    campo: CampoEdicion.values.byName(json[ApiClaves.campo] as String),
    valorAnterior: json[ApiClaves.valorAnterior] as String,
    valorNuevo: json[ApiClaves.valorNuevo] as String,
    fecha: JsonHelpers.fechaDesdeJson(json[ApiClaves.fecha]),
  );

  static Json aJson(EdicionMovimiento edicion) => {
    ApiClaves.campo: edicion.campo.name,
    ApiClaves.valorAnterior: edicion.valorAnterior,
    ApiClaves.valorNuevo: edicion.valorNuevo,
    ApiClaves.fecha: JsonHelpers.fechaAJson(edicion.fecha),
  };
}
