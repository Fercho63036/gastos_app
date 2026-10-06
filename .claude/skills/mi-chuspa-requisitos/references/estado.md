# Estado vivo de implementación — MI Chuspa

Actualiza este archivo (no `requisitos.md`) cada vez que se completa, se corrige o se decide algo distinto a la spec sobre un RF. Última actualización: 2026-10-06 (auditoría de código real contra RF-01 a RF-21).

## Completados (verificado contra código)

- [x] RF-01 — Login con correo y contraseña (`lib/app/features/auth/pages/login_page.dart`)
- [x] RF-23 — Crear cuenta (`lib/app/features/auth/pages/registrar_page.dart`)
- [x] RF-24 — Recuperar contraseña (sin verificación, decisión aceptada) (`lib/app/features/auth/pages/recuperar_contrasena_page.dart`)
- [x] RF-25 — Cerrar sesión (`lib/app/shared/layout/widgets/drawer/cerrar_sesion_tile_widget.dart`)
- [x] RF-26 — Cambiar tema claro/oscuro (`lib/app/shared/layout/providers/theme_provider.dart`)
- [x] RF-03 — Entradas/recargas con fecha, monto, motivo opcional (`lib/app/features/movimientos/pages/nueva_entrada_page.dart`, `providers/nueva_entrada_provider.dart`)
- [x] RF-04 — Inicio manual de mes con arrastre de saldo (`lib/app/features/periodo/pages/iniciar_mes_page.dart`, `iniciar_mes_provider.dart`; `PeriodoMes.saldoInicialCentavos = arrastradoCentavos + montoMesCentavos`)
- [x] RF-05 — Montos en Bs en toda la UI (`lib/app/core/utils/formato_helpers.dart`)
- [x] RF-06 — Alta de gasto con monto/descripción/categoría, fecha/hora automáticas (`lib/app/features/movimientos/pages/nuevo_gasto_page.dart`, `providers/nuevo_gasto_provider.dart`)
- [x] RF-07 — Categorías fijas: comida, pasajes, diversión, ropa, deportes, otros (`lib/app/shared/models/categoria_movimiento.dart`)
- [x] RF-08 / RF-09 — Anular/reactivar sin borrar; anulado no cuenta en saldo (`estado_movimiento.dart`, `detalle_gasto_page.dart`, `resumen_helpers.dart` → `ResumenHelpers.vigentes`)
- [x] RF-10 — Descuento automático del saldo (`resumen_helpers.dart` → `saldo = ingresado - gastos`)
- [x] RF-11 — ID y fecha/hora no editables tras creación (`movimiento_model.dart`: `id`/`fecha` fuera de `copyWith`; candado visual en `detalle_gasto_page.dart`)
- [x] RF-12 — Saldo/alertas/gráficos recalculados al instante sin refresh manual (`MovimientosService extends ChangeNotifier`, `InicioProvider` escucha `InicioService.cambios`)
- [x] RF-13 — Historial de edición (ID, fecha/hora, campo, valor anterior/nuevo) (`edicion_movimiento_model.dart`, `campo_edicion.dart`, `EdicionesHelpers.diferencias`, mostrado en `historial_ediciones_widget.dart`)
- [x] RF-14 — Vistas Hoy / Semana / Mes (`lib/app/features/inicio/models/periodo_filtro.dart`, `inicio_page.dart`)
- [x] RF-15 — Semana de 7 días corridos, no semana calendario (`inicio_helpers.dart` → `desdeDePeriodo`)
- [x] RF-17 — Se puede gastar bajo el piso sin bloqueo (`PeriodoHelpers.validar` solo rechaza piso > saldo inicial; nada impide `gastable` negativo)

## Parcial (falta terminar)

- [ ] RF-16 — Piso editable y `gastable = saldo − piso` ya funcionan (`iniciar_mes_page.dart`, `ResumenHelpers.calcular`). Falta: (a) default de 50 Bs cuando no hay mes anterior — hoy `PeriodoHelpers.pisoPrecargado` devuelve `''`; (b) el piso solo se edita dentro del flujo "Iniciar mes", no en cualquier momento del mes en curso.

## Pendientes, en orden de la fase que les corresponde

- [ ] RF-02 — Monto del mes editable en cualquier momento (hoy solo se fija al iniciar mes; no hay pantalla para subirlo/bajarlo después)
- [ ] RF-18, RF-19, RF-20 — Alertas tipo batería (20/15/10/5/0%), saldo en rojo bajo 20%, aviso al abrir la app bajo el piso — no existe lógica de umbrales ni diálogo de aviso
- [ ] RF-21 — Gráficos (circular por categoría, barras por día/semana/mes) — no existe carpeta de resumen/gráficos ni librería de charts en uso
- [ ] RF-22 — Exportación a Excel
- [ ] RF-27 — Pantalla Perfil (definir contenido con Ariel antes de construir)

## Fases (actualizado contra el código real)

- Fase 1 (modelo de datos base) — **completa**: `Movimiento`, `EdicionMovimiento`, `CategoriaMovimiento`, `PeriodoMes` ya existen en `lib/app/shared/models/`.
- Fase 2 (presupuesto y entradas) — **completa excepto RF-02** (ver arriba).
- Fase 3 (gastos: alta/edición/anulación/historial) — **completa**.
- Fase 4 (listados) — **completa**.
- Fase 5 (piso y alertas) — **en curso**: RF-16 parcial, RF-17 completo, RF-18/19/20 pendientes. Siguiente trabajo real del proyecto.
- Fase 6 (resumen y gráficos) — pendiente (RF-21).
- Fase 7 (exportación a Excel) — pendiente (RF-22).
- Fase 8 (perfil) — pendiente (RF-27).

## Desviaciones acordadas respecto a la spec original

(Ninguna registrada todavía. RF-16 se deja como "parcial", no como desviación: el comportamiento objetivo sigue siendo el de la spec, solo falta completar el default de 50 Bs y permitir editar el piso fuera de "Iniciar mes".)

## Nota sobre código legado (no tocado en esta auditoría)

Existe un árbol de código sin usar desde el bootstrap de la app: `lib/core/` (incluye `database_helper.dart`) y `lib/features/expenses/` (modelo `Expense` con `amount` en `double`, en vez de centavos enteros como el `Movimiento` activo). No está referenciado desde `lib/app/...`, que es el árbol activo. Queda pendiente decidir si se elimina.
