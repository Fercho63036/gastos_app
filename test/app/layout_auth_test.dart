import 'package:flutter_test/flutter_test.dart';

import 'package:gastos_app/app/core/routes/route_names.dart';
import 'package:gastos_app/app/features/auth/constants/auth_strings.dart';
import 'package:gastos_app/app/features/auth/utils/auth_helpers.dart';
import 'package:gastos_app/app/shared/constants/formulario_strings.dart';
import 'package:gastos_app/app/shared/layout/config/menu_config.dart';
import 'package:gastos_app/app/shared/utils/validadores_helpers.dart';

void main() {
  group('MenuConfig', () {
    test('ids únicos', () {
      final ids = MenuConfig.items.map((item) => item.id).toList();

      expect(ids.toSet().length, ids.length);
    });

    test('items navegables apuntan a rutas registradas', () {
      final rutas = MenuConfig.items
          .where((item) => !item.esSeccion)
          .map((item) => item.ruta);

      expect(rutas, containsAll([RouteNames.home, RouteNames.perfil]));
    });
  });

  group('ValidadoresHelpers', () {
    test('validarCorreo', () {
      expect(
        ValidadoresHelpers.validarCorreo(''),
        FormularioStrings.ingresaCorreo,
      );
      expect(
        ValidadoresHelpers.validarCorreo('abc'),
        FormularioStrings.correoInvalido,
      );
      expect(ValidadoresHelpers.validarCorreo('a@b.co'), isNull);
    });
  });

  group('AuthHelpers', () {
    test('validarConfirmacion', () {
      expect(
        AuthHelpers.validarConfirmacion('x', 'y'),
        AuthStrings.contrasenasNoCoinciden,
      );
      expect(AuthHelpers.validarConfirmacion('x', 'x'), isNull);
    });
  });
}
