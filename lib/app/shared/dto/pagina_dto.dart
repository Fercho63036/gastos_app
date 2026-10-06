/********************************** SHARED **********************************/
import '../paginado/models/paginated_response_model.dart';
import 'api_claves.dart';
import 'json_helpers.dart';

class PaginaDto {
  PaginaDto._();

  /******************************** DESDE JSON *********************************/
  static PaginatedResponse<T> desdeJson<T>(
    Json json,
    T Function(Json) itemDesdeJson,
  ) => PaginatedResponse(
    datos: JsonHelpers.lista(json[ApiClaves.datos]).map(itemDesdeJson).toList(),
    total: json[ApiClaves.total] as int,
  );
}
