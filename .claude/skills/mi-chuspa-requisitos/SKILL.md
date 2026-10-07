---
name: mi-chuspa-requisitos
description: Especificación y plan de migración/implementación para "MI Chuspa", la app Flutter de control de gastos personales de Ariel (login, presupuesto, gastos, alertas tipo batería, listado de gastos por Semana/Mes/Año). Usa esta skill SIEMPRE que trabajes en código, pantallas, modelos de datos, lógica de saldo/alertas o listado de gastos de MI Chuspa, aunque el pedido sea algo puntual como "agrega la pantalla de perfil" o "arregla el cálculo del saldo" — esos requisitos puntuales dependen de reglas definidas aquí (RF-01 a RF-27) que no deben romperse ni reinterpretarse sobre la marcha.
---

# MI Chuspa — Skill de implementación

Esta skill es la fuente de verdad del proyecto. Antes de escribir o modificar código de MI Chuspa, léela completa (y `references/requisitos.md` para el texto exacto de cada RF) para no reinventar reglas de negocio ya decididas ni romper algo que ya funciona.

## Qué es el proyecto

App Android en Flutter, **personal, local, sin backend**. Todos los montos en bolivianos (Bs). Soporta tema claro y oscuro. Ariel ya tiene un proyecto Flutter base con varias pantallas construidas (ver estado abajo).

## Cómo usar esta skill en una tarea

1. Identifica qué RF(s) toca la tarea pedida (`references/requisitos.md` tiene el texto completo y el estado ✅/🔲/⚠️ de cada uno).
2. Revisa el código existente en el proyecto **antes** de asumir cómo está estructurado: busca el gestor de estado y la librería de almacenamiento local que ya se estén usando (por ejemplo Provider/Riverpod/Bloc, sqflite/Hive/SharedPreferences) y sigue ese mismo patrón — no introduzcas una librería distinta sin que Ariel lo pida.
3. Si el proyecto ya usa (o va a usar) una arquitectura por capas, consulta también la skill `flutter-clean-architecture` para la organización de carpetas.
4. Respeta las "Reglas que no se rompen" de abajo: son invariantes del negocio, no detalles de UI.
5. Al terminar un RF, actualiza su estado en `references/estado.md` (de 🔲 a ✅), para que la próxima sesión sepa qué falta.

## Reglas de negocio que no se rompen

Estas reglas atraviesan varios RF y son fáciles de romper por accidente al tocar un solo módulo:

- **Nunca se borra un gasto físicamente.** Solo se "anula" (y se puede reactivar). Un gasto anulado no cuenta en el saldo (RF-09).
- **Toda edición de un gasto queda registrada**: ID del gasto, fecha/hora, campo editado, valor anterior y valor nuevo (RF-13). Esto implica que el modelo de datos necesita una tabla/colección de historial separada desde el inicio, no como agregado después.
- **El saldo, las alertas y los gráficos se recalculan al instante** ante cualquier edición o nuevo gasto/entrada (RF-12) — no deben quedar desincronizados ni requerir refrescar manualmente.
- **El piso de ahorro nunca bloquea un gasto** (RF-17); solo dispara avisos visuales (RF-19, RF-20).
- **Fecha/hora de un gasto son automáticas e inmutables** una vez creado (RF-11); lo editable es monto, descripción, categoría y estado.
- **Todo es local**: no hay llamadas a backend ni sincronización en la nube en ningún RF.

## Decisiones adoptadas sobre los puntos pendientes de confirmar

El documento de requisitos dejaba 3 puntos abiertos. Para no bloquear la implementación, esta skill adopta estas decisiones como spec de trabajo. Si Ariel decide otra cosa, se actualiza este archivo (no se decide de nuevo en cada sesión):

- **RF-02/RF-03 (se pisaban):** el "monto del mes" es el dinero inicial del mes. Cada recarga se registra aparte como entrada. `saldo = monto del mes + suma de entradas − suma de gastos activos` (los anulados no restan).
- **RF-18 (base del porcentaje de alerta):** el gastable total se calcula como `monto del mes + entradas − piso`. El 100% de ese gastable se recalcula cada vez que hay una recarga (entrada nueva), no solo al inicio del mes.
- **RF-24 (seguridad de recuperación de contraseña):** se implementa tal como está especificado, **sin** pregunta de seguridad ni verificación adicional (es consistente con que la app es local y de un solo usuario). Esto es una decisión de producto aceptada, no un bug pendiente.

Puntos que siguen genuinamente abiertos (no asumas, pregúntale a Ariel si la tarea los toca):
- Si el historial de ediciones se muestra dentro de la app (decidido: sí, dentro de la app).
- Si las categorías son fijas (como están listadas en RF-07) o el usuario puede crear las suyas.
- Si debe existir una vista "Año" dentro de la app, (decidido: sí, filtro Semana/Mes/Año en el listado).

## Plan de migración / implementación por fases

Las fases están ordenadas por dependencia de datos, no por lo "visualmente importante": no tiene sentido construir alertas (fase 5) antes de que exista el modelo de datos de presupuesto y gastos (fases 1–3). Dentro de cada fase, los RF ya marcados ✅ en `references/estado.md` se saltan — pero igual conviene verificar que lo ya construido cumple exactamente la regla descrita (ej. RF-01 ahora es con correo, no "usuario", y RF-24 no tiene verificación por código).

**Fase 0 — Auditoría de lo ya implementado**
Antes de construir nada nuevo, revisa las pantallas ya hechas (login, crear cuenta, recuperar contraseña, cerrar sesión, cambio de tema) contra el texto exacto de RF-01, RF-23, RF-24, RF-25, RF-26 en `references/requisitos.md`. Si algo no calza (p. ej. el login todavía pide "usuario" en vez de correo), es deuda a corregir, no una tarea nueva.

**Fase 1 — Modelo de datos base**
Antes de cualquier pantalla nueva, define las entidades que todo lo demás necesita: Gasto, Entrada (recarga), Categoría, HistorialEdicion, y una Configuración (piso, monto del mes vigente, mes activo). Esto es lo que hace posible RF-02 a RF-13 sin retrabajo.

**Fase 2 — Presupuesto y entradas** (RF-02, RF-03, RF-04, RF-05)
Monto del mes editable, registro de entradas/recargas, inicio manual de mes con arrastre de saldo.

**Fase 3 — Gastos: alta, edición, anulación, historial** (RF-06 a RF-13)
CRUD de gastos con las reglas de "nunca se borra" y "toda edición se audita" desde el primer commit de este módulo, no agregadas después.

**Fase 4 — Listados** (RF-14, RF-15)
Vistas Hoy / Semana (7 días corridos) / Mes sobre los datos de la fase 3. La pantalla "Gastos" ya existe con estado vacío; aquí se conecta a datos reales.

**Fase 5 — Piso y alertas** (RF-16 a RF-20)
Depende de que el saldo y el gastable (fases 2 y 3) ya se calculen correctamente. Alertas tipo batería en 20/15/10/5/0%, rojo bajo 20%, aviso al abrir la app si está bajo el piso.

**Fase 6 — Resumen y gráficos** (RF-21)
Circular por categoría, barras por día/semana/mes. Es una vista de lectura sobre los datos ya existentes.

**Fase 7 — Listado de gastos por Semana/Mes/Año** (RF-22)
Listado dentro de la app filtrado por semana/mes/año con gastos, entradas, resumen por categoría e historial de ediciones. Sin exportación a Excel. Depende de que todo lo anterior ya tenga datos consistentes que listar.

**Fase 8 — Perfil** (RF-27)
Contenido por definir con Ariel antes de construirla; no asumas campos.

## Al cerrar una tarea

Actualiza `references/estado.md` marcando los RF que quedaron completos, y anota ahí (no en el código) cualquier desviación consciente de la spec que se haya acordado con Ariel durante la implementación.
