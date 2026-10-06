# Estado vivo de implementación — MI Chuspa

Actualiza este archivo (no `requisitos.md`) cada vez que se completa, se corrige o se decide algo distinto a la spec sobre un RF. Última actualización: 2026-10-06 (auditoría de código real contra RF-01 a RF-21). Actualizado: 2026-10-07 (RF-16 completado, luego ajustado a solo lectura en Inicio). Actualizado: 2026-10-06 (RF-21 completado).

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
- [x] RF-02 — Monto del mes editable en cualquier momento, subiendo o bajando (ver "Desviaciones acordadas": se implementa en la pantalla "Iniciar Mes", con modo de edición in-place)
- [x] RF-16 — Piso editable y `gastable = saldo − piso` funcionan. Sin default (lo define el usuario). La tarjeta de Inicio (`fila_gastable_piso_widget.dart`) es solo lectura (Gastable/Gastado/Piso, sin tocar); el piso se edita exclusivamente desde "Iniciar/Editar mes" (`iniciar_mes_page.dart`, `ResumenHelpers.calcular`). El `MovimientosService.actualizarPiso` y `DialogoEditarPisoWidget` quedaron sin usar desde Inicio tras este ajuste — pendiente decidir si se eliminan.
- [x] RF-21 — Gráficos: circular por categoría y barras por día, con selector Hoy/Semana/Mes (mismo `PeriodoFiltro` de Inicio) y acceso desde el menú lateral. Nueva feature `lib/app/features/resumen/` (`resumen_page.dart`, `resumen_provider.dart`, `resumen_service.dart`, `resumen_helpers.dart`, `widgets/grafico_categorias_widget.dart`, `widgets/grafico_barras_widget.dart`, `widgets/leyenda_categorias_widget.dart`) usando `fl_chart`. Reutiliza `CategoriaMovimiento` (color/nombre), `AgrupacionHelpers.agruparPorDia` y el filtro de vigentes; se agregó `MovimientosService.listarVigentesDesde` (no paginado) para alimentar los gráficos. Ruta `/resumen` y entrada "Resumen" en `menu_config.dart`.

## Pendientes, en orden de la fase que les corresponde

- [ ] RF-18, RF-19, RF-20 — Alertas tipo batería (20/15/10/5/0%), saldo en rojo bajo 20%, aviso al abrir la app bajo el piso — no existe lógica de umbrales ni diálogo de aviso
- [ ] RF-22 — Exportación a Excel
- [ ] RF-27 — Pantalla Perfil (definir contenido con Ariel antes de construir)

## Fases (actualizado contra el código real)

- Fase 1 (modelo de datos base) — **completa**: `Movimiento`, `EdicionMovimiento`, `CategoriaMovimiento`, `PeriodoMes` ya existen en `lib/app/shared/models/`.
- Fase 2 (presupuesto y entradas) — **completa**, incluyendo RF-02 (ver "Desviaciones acordadas").
- Fase 3 (gastos: alta/edición/anulación/historial) — **completa**.
- Fase 4 (listados) — **completa**.
- Fase 5 (piso y alertas) — **en curso**: RF-16 completo, RF-17 completo, RF-18/19/20 pendientes. Siguiente trabajo real del proyecto.
- Fase 6 (resumen y gráficos) — **completa** (RF-21).
- Fase 7 (exportación a Excel) — pendiente (RF-22).
- Fase 8 (perfil) — pendiente (RF-27).

## Desviaciones acordadas respecto a la spec original

- **RF-02 se resuelve en "Iniciar Mes", no en "Entrada"** (decisión final de Ariel, 2026-10-06, tras dos intentos previos descartados — ver historial abajo): "Iniciar Mes" (`iniciar_mes_page.dart` / `iniciar_mes_provider.dart`) ahora tiene dos modos, decididos por `PeriodoHelpers.esMesActual(periodoActual, ahora)` (¿el período vigente es del mes calendario actual?):
  - **Sin período del mes actual** (primera vez en el mes): modo "Iniciar mes" de siempre — crea un período nuevo, arrastrando `resumen.saldoCentavos` del período anterior.
  - **Con período del mes actual**: modo "Editar monto del mes" — precarga el `montoMesCentavos`/`pisoCentavos` vigentes y, al guardar, **actualiza esa misma fila in-place** (`MovimientosService.actualizarMontoMes` → `MovimientosRepositorio.actualizarMontoMes` → `MovimientosAlmacen.actualizarPeriodoActual`, UPDATE sobre la fila de mayor id en `periodos`), sin tocar el arrastre ni crear una fila nueva. Esto resuelve RF-02 ("editable en cualquier momento, subiendo o bajando") de forma directa.
  - **"Entrada" (`nueva_entrada_page.dart` / `nueva_entrada_provider.dart`) vuelve a ser solo RF-03**: pantalla simple para sumar un ingreso extra (campo vacío al abrir, se suma tal cual al saldo vía un `Movimiento` con `esEntrada: true`, sin delta ni precarga de saldo).
  - **Historial de decisiones sobre RF-02 (para que una sesión futura no lo reintente):** (1) primer intento: fusionar RF-02+RF-03 en "Entrada", precargando `montoMesCentavos + entradas` — descartado porque ese valor no coincidía con el saldo real visto en inicio (excluía arrastre y gastos). (2) segundo intento: misma fusión pero precargando `saldoCentavos` (sí coincidía con "Te queda este mes") — descartado por Ariel porque "Entrada" e "Iniciar Mes" terminaban manejando el mismo dato por caminos distintos, lo cual es confuso. (3) diseño final (el de arriba): cada pantalla maneja su propio dato — "Iniciar Mes" el monto del mes (con modo edición in-place), "Entrada" solo ingresos extra.
  - RF-16 queda completo: el piso se define y edita únicamente desde "Iniciar/Editar mes" (modo "Editar monto del mes", que incluye el campo de piso); la tarjeta de Inicio solo lo muestra, sin edición directa ahí.
- **El saldo total nunca puede quedar negativo** (corrección de bug sobre RF-10, 2026-10-06): crear o editar un gasto que haría que `resumen.saldoCentavos` ("Te queda este mes") quede negativo se bloquea con el error "El gasto supera el saldo disponible este mes" (`MovimientosHelpers.validarTopeSaldo`, usado en `NuevoGastoProvider.guardar` y `DetalleGastoProvider._guardarBorrador`). El piso (RF-17) sigue sin bloquear nada — son dos límites independientes: el piso solo dispara avisos visuales (RF-18/19/20, pendientes), el saldo total sí bloquea.

## Nota sobre código legado (no tocado en esta auditoría)

Existe un árbol de código sin usar desde el bootstrap de la app: `lib/core/` (incluye `database_helper.dart`) y `lib/features/expenses/` (modelo `Expense` con `amount` en `double`, en vez de centavos enteros como el `Movimiento` activo). No está referenciado desde `lib/app/...`, que es el árbol activo. Queda pendiente decidir si se elimina.
