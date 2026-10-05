import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:gastos_app/app/core/routes/route_names.dart';

import '../../constants/auth_strings.dart';

class VolverLoginWidget extends StatelessWidget {
  const VolverLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.go(RouteNames.auth),
      child: const Text(AuthStrings.volverALogin),
    );
  }
}
