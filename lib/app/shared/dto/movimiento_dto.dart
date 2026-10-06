/********************************** SHARED **********************************/
import '../models/borrador_movimiento_model.dart';
import '../models/categoria_movimiento.dart';
import '../models/movimiento_model.dart';
import 'api_claves.dart';
import 'edicion_dto.dart';
import 'json_helpers.dart';

class MovimientoDto {
  MovimientoDto._();

  /******************************** DESDE JSON ********************************/
  static Movimiento desdeJson(Json json) => Movimiento(
    id: json[ApiClaves.id].toString(),
    codigo: json[ApiClaves.codigo] as String,
    titulo: json[ApiClaves.titulo] as String,
    categoria: CategoriaMovimiento.values.byName(
      json[ApiClaves.categoria] as String,
    ),
    montoCentavos: json[ApiClaves.montoCentavos] as int,
    fecha: JsonHelpers.fechaDesdeJson(json[ApiClaves.fecha]),
    anulado: json[ApiClaves.anulado] as bool,
    esEntrada: json[ApiClaves.esEntrada] as bool,
    ediciones: [
      for (final edicion in JsonHelpers.lista(json[ApiClaves.ediciones]))
        EdicionDto.desdeJson(edicion),
    ],
  );

  static Json aJson(Movimiento movimiento) => {
    ApiClaves.id: movimiento.id,
    ApiClaves.codigo: movimiento.codigo,
    ApiClaves.titulo: movimiento.titulo,
    ApiClaves.categoria: movimiento.categoria.name,
    ApiClaves.montoCentavos: movimiento.montoCentavos,
    ApiClaves.fecha: JsonHelpers.fechaAJson(movimiento.fecha),
    ApiClaves.anulado: movimiento.anulado,
    ApiClaves.esEntrada: movimiento.esEntrada,
    ApiClaves.ediciones: movimiento.ediciones.map(EdicionDto.aJson).toList(),
  };

  /***************************** BORRADOR A JSON ******************************/
  static Json borradorAJson(BorradorMovimiento borrador) => {
    ApiClaves.titulo: borrador.titulo,
    ApiClaves.categoria: borrador.categoria.name,
    ApiClaves.montoCentavos: borrador.montoCentavos,
    ApiClaves.esEntrada: borrador.esEntrada,
  };

  /****************************** CAMBIOS A JSON ******************************/
  static Json cambiosAJson(Movimiento editado) => {
    ApiClaves.titulo: editado.titulo,
    ApiClaves.categoria: editado.categoria.name,
    ApiClaves.montoCentavos: editado.montoCentavos,
    ApiClaves.anulado: editado.anulado,
  };
}
