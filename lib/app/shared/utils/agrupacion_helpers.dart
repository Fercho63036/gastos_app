import 'package:gastos_app/app/core/utils/formato_helpers.dart';

import 'package:gastos_app/app/shared/models/grupo_dia_model.dart';

class AgrupacionHelpers {
  AgrupacionHelpers._();

  /// Agrupa por día (más reciente primero) respetando el orden recibido
  /// dentro de cada día.
  static List<GrupoDia<T>> agruparPorDia<T>(
    List<T> items,
    DateTime Function(T item) fechaDe,
  ) {
    final porDia = <DateTime, List<T>>{};
    for (final item in items) {
      porDia
          .putIfAbsent(FormatoHelpers.soloDia(fechaDe(item)), () => [])
          .add(item);
    }
    final grupos = [
      for (final entrada in porDia.entries)
        GrupoDia<T>(fecha: entrada.key, items: entrada.value),
    ];
    return grupos..sort((a, b) => b.fecha.compareTo(a.fecha));
  }
}
