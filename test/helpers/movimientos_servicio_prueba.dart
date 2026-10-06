import 'package:gastos_app/app/shared/repositories/local/movimientos_local_repositorio.dart';
import 'package:gastos_app/app/shared/services/movimientos_service.dart';

import 'movimientos_almacen_fake.dart';

/// Servicio real sobre el backend simulado y un almacén en memoria.
MovimientosService servicioDePrueba(
  MovimientosAlmacenFake almacen, {
  DateTime Function() ahora = DateTime.now,
}) => MovimientosService(MovimientosLocalRepositorio(almacen, ahora: ahora));
