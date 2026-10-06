/**************************** PAQUETES EXTERNOS *****************************/
import 'package:sqflite/sqflite.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/constants/database_constants.dart';
import 'package:gastos_app/app/core/utils/formato_helpers.dart';

/********************************** SHARED **********************************/
import 'package:gastos_app/app/shared/constants/dominio_strings.dart';
import 'package:gastos_app/app/shared/models/campo_edicion.dart';
import 'package:gastos_app/app/shared/models/categoria_movimiento.dart';
import 'package:gastos_app/app/shared/models/estado_movimiento.dart';

typedef FilaEdicion = Map<String, Object?>;

/*************************** MIGRACIONES DATABASE ***************************/
class MigracionesDatabase {
  MigracionesDatabase._();

  static Future<void> actualizar(Database db, int anterior, int nueva) async {
    if (anterior < DatabaseConstants.versionEdicionesCrudas) {
      await _edicionesACrudas(db);
    }
  }

  static Future<void> _edicionesACrudas(Database db) async {
    final filas = await db.query(DatabaseConstants.tablaEdiciones);
    final batch = db.batch();
    for (final fila in filas) {
      final cruda = edicionACruda(fila);
      if (identical(cruda, fila)) continue;
      batch.update(
        DatabaseConstants.tablaEdiciones,
        cruda,
        where: DatabaseConstants.whereId,
        whereArgs: [fila[DatabaseConstants.colId]],
      );
    }
    await batch.commit(noResult: true);
  }

  /***************************** EDICION A CRUDA ******************************/
  static FilaEdicion edicionACruda(FilaEdicion fila) {
    final campo = _campoDesdeEtiqueta(fila[DatabaseConstants.colCampo]);
    if (campo == null) return fila;
    return {
      DatabaseConstants.colCampo: campo.name,
      DatabaseConstants.colValorAnterior: _valorCrudo(
        campo,
        fila[DatabaseConstants.colValorAnterior] as String,
      ),
      DatabaseConstants.colValorNuevo: _valorCrudo(
        campo,
        fila[DatabaseConstants.colValorNuevo] as String,
      ),
    };
  }

  static CampoEdicion? _campoDesdeEtiqueta(Object? etiqueta) {
    for (final campo in CampoEdicion.values) {
      if (campo.etiqueta == etiqueta) return campo;
    }
    return null;
  }

  static String _valorCrudo(CampoEdicion campo, String formateado) =>
      switch (campo) {
        CampoEdicion.monto => FormatoHelpers.parsearMonto(
          formateado,
        ).toString(),
        CampoEdicion.descripcion => _sinComillas(formateado),
        CampoEdicion.categoria => _nombreACategoria(formateado),
        CampoEdicion.estado => _etiquetaAEstado(formateado),
      };

  static String _sinComillas(String texto) => texto
      .replaceFirst(DominioStrings.comillaApertura, '')
      .replaceFirst(RegExp('${DominioStrings.comillaCierre}\$'), '');

  static String _nombreACategoria(String nombre) {
    for (final categoria in CategoriaMovimiento.values) {
      if (categoria.nombre == nombre) return categoria.name;
    }
    return nombre;
  }

  static String _etiquetaAEstado(String etiqueta) {
    for (final estado in EstadoMovimiento.values) {
      if (estado.etiqueta == etiqueta) return estado.name;
    }
    return etiqueta;
  }
}
