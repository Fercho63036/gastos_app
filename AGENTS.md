# AGENTS.md — gastos_app (Flutter)

> Fuente única de verdad para todos los asistentes de IA en este proyecto.
> Solo convenciones técnicas; las reglas de negocio viven en la skill `mi-chuspa-requisitos` y no se duplican aquí.

---

## Asistentes de IA

| Asistente | Archivo que lee | Cómo llega aquí |
|---|---|---|
| Claude Code | `CLAUDE.md` | `@AGENTS.md` |
| Gemini CLI / Code Assist | `GEMINI.md` | `@AGENTS.md` |
| GitHub Copilot Chat | `.github/copilot-instructions.md` | Remite a este archivo |
| ChatGPT/Codex, Cursor, Windsurf | `AGENTS.md` | Lectura nativa |

- Los punteros solo redirigen aquí; nunca llevan reglas propias.
- Los skills de `.claude/skills/` son atajos derivados de este archivo; si alguno lo contradice, gana `AGENTS.md`.
- Una regla nueva se escribe aquí, no en un puntero, skill ni memoria de herramienta.
- Chats web (ChatGPT, Gemini, Claude.ai) no leen el repo: pegar este archivo en Instrucciones personalizadas / Proyecto / Gem.

---

## Stack

| Capa | Tecnología |
|---|---|
| Framework | Flutter / Dart |
| Estado | Provider (`ChangeNotifier` + `MultiProvider` en `app_widget.dart`) |
| Inyección | get_it (`lib/app/core/di/injection.dart`) |
| Rutas | go_router (`lib/app/core/routes/`) |
| Persistencia | sqflite (`AppDatabase` en `lib/app/core/database/`), shared_preferences |
| Gráficos | fl_chart |
| Diseño | `AppDimensions` (`core/constants/`), `ResponsiveHelper` (`core/utils/`), `AppColores` (`core/theme/`) |
| Reglas de estilo | `dart run tools/verificar_reglas.dart [rutas]` |

- No agregar dependencias ni cambiar la arquitectura sin consultar.
- Al refactorizar no cambiar la lógica de negocio.

---

## Arquitectura: Feature-First

```
lib/
  main.dart            ← solo inicializa y llama a runApp
  app/
    app_widget.dart    ← proveedores, tema, router
    core/              ← constants, theme, utils, di, database, routes, errors, config
    shared/            ← models, dto, repositories, services, widgets, layout, constants, utils
    features/<feature>/
      constants/<feature>_strings.dart     ← TODOS los textos visibles
      constants/<feature>_constants.dart   ← TODOS los números de lógica
      utils/<feature>_helpers.dart         ← funciones puras
      models/<nombre>_model.dart
      services/<nombre>_service.dart
      providers/<nombre>_provider.dart
      pages/<nombre>_page.dart
      widgets/[subcarpeta]/<nombre>_widget.dart
```

- Dependencia: `features` puede importar `core` y `shared`; `core` y `shared` nunca importan un feature.
- Un feature no importa páginas, providers ni widgets de otro; lo común sube a `shared`.
- Capas: `page/widget` (UI) → `provider` (estado) → `service/repository` → `AppDatabase`. La UI nunca toca `sqflite` ni `AppDatabase`.
- La UI no contiene lógica de negocio: los cálculos viven en services/helpers.
- No crear archivos barrel; importar directamente.
- Providers y servicios nuevos se registran en `injection.dart` / `MultiProvider`.

---

## Nomenclatura

- Código en español (`Movimiento`, `PeriodoMes`, `ResumenMes`); excepción: nombres que exige Flutter/Dart.
- Archivos: `snake_case.dart` con sufijo de tipo (`[nombre]_[tipo].dart`).
- Clases: PascalCase. Métodos y variables: camelCase. Privados con `_`.
- Variables con nombre completo (`colorScheme`, `screenWidth`), nunca `cs`, `w`, `tt`.
- Nombres descriptivos: `BotonPrimarioWidget`, no `Boton1`.

---

## Comentarios Banner

Cada constante, clase, constructor y método lleva un banner en mayúsculas de **80 columnas fijas** (incluido `// `), con el texto centrado y relleno de `*` (si sobra uno, va a la derecha):

```dart
// ******************************** CONSTRUCTOR ********************************
const MovimientoModel({required this.monto});
```

- El texto es el nombre del bloque o método en mayúsculas, no una explicación.
- Se genera con `dart run tools/verificar_reglas.dart --banner "TEXTO"` y se corrige con `--normalizar <rutas>`.
- Los campos de una clase se agrupan bajo un único banner `PROPIEDADES`.
- La indentación del banner es la del bloque que encabeza.
- Cero comentarios explicativos inline, cero emojis, cero código comentado.
- Cero historial del cambio (`// se cambió para arreglar...`, `// nuevo`, `// antes era`): eso va en el commit.

### Imports

Cada grupo lleva su banner y los imports van **pegados debajo**, sin líneas en blanco entre ellos ni entre grupos. Solo se emiten los grupos con imports. Orden fijo: `DART → FLUTTER → LIBRERIAS → CORE → SHARED → FEATURE`, y alfabético dentro de cada grupo.

```dart
// *********************************** DART ************************************
import 'dart:async';
// ********************************** FLUTTER **********************************
import 'package:flutter/material.dart';
// ********************************* LIBRERIAS *********************************
import 'package:provider/provider.dart';
// *********************************** CORE ************************************
import 'package:gastos_app/app/core/constants/app_dimensions.dart';
// ********************************** SHARED ***********************************
import 'package:gastos_app/app/shared/models/movimiento_model.dart';
// ********************************** FEATURE **********************************
import 'package:gastos_app/app/features/inicio/constants/inicio_strings.dart';
```

- `DART`: `dart:*`. `FLUTTER`: `package:flutter/*`. `LIBRERIAS`: resto de paquetes de terceros (incluye `flutter_test`).
- `CORE`: `gastos_app/app/core/`. `SHARED`: `gastos_app/app/shared/`. `FEATURE`: el resto del proyecto (`app/features/`, `app/app_widget.dart`) y rutas relativas del mismo directorio.
- Se usan imports `package:gastos_app/...`, nunca rutas relativas largas (`../../`).

---

## Límites de tamaño

- Máx **200 líneas** por archivo; máx **30 líneas** por método/función.
- Si se supera: extraer widget, helper `_x` o dividir en archivos. Un `build` grande se parte en widgets (header/body/footer) en `widgets/`, no en métodos que devuelvan widgets grandes.
- Más de 3 widgets relacionados → agrupar en subcarpeta.

---

## Clean code

- Un archivo, una responsabilidad; un widget = un archivo (salvo helpers privados pequeños).
- Funciones pequeñas con un solo nivel de abstracción; nombres que dicen qué hacen.
- Sin números ni textos mágicos:
  - Todo texto visible → `[Feature]Strings` (`Text('Guardar')` está prohibido).
  - Todo número de UI (padding, radius, icon, font, elevation, border) → `AppDimensions`.
  - Todo número de lógica → `[Feature]Constants` (`if (x > 8000)` está prohibido).
  - Todo breakpoint → `ResponsiveHelper.isMobile/isTablet/isDesktop(context)`, `paddingAll`, `fontSize`, `spacing`, `columnCount`; nunca `MediaQuery` suelto para decidir layout.
- Dinero nunca en `double`: enteros (centavos) o `Decimal`.
- `const` siempre que se pueda; widgets pequeños.
- Errores manejados explícitamente; nunca `catch` vacío.
- `late`, `!` y `dynamic` solo cuando no hay alternativa; preferir tipos explícitos.

### Principios y patrones

- **SRP**: una clase, una razón para cambiar. La lógica va en provider/service/helpers; el widget solo pinta.
- **OCP**: se extiende con parámetros, callbacks, enums o composición; nunca copiando un archivo para variarlo.
- **DIP**: la UI no instancia services ni repositories; dependen de inyección (get_it, Provider).
- **DRY**: el bloque que aparece por segunda vez se extrae; tres copias es incumplimiento.
- Composición sobre herencia.
- Guard clauses y retorno temprano en vez de `if` anidados; máx 3 niveles de anidación.
- Máx 4 parámetros por método; si hay más, agrupar en un modelo u objeto de configuración.
- Un widget privado (`_Seccion`) vive en un solo archivo; si se necesita en un segundo, sube a `widgets/`.

---

## Reutilización de widgets y componentes

- Antes de crear un widget se busca (`grep`/explorador) en este orden: `lib/app/shared/widgets/<categoria>/`, `features/<feature>/widgets/`; solo si no existe, se crea.
- Un widget usado en 2 o más features se mueve a `lib/app/shared/widgets/<categoria>/`; un feature nunca importa widgets de otro feature.
- Las variantes se resuelven con parámetros (`child`, callbacks, enums), no con archivos duplicados ni sufijos `_v2`, `_nuevo`, `_copia`.
- Un widget recibe datos y callbacks por constructor; no lee providers ni services, salvo el widget contenedor de su feature.
- Botones, tarjetas, campos de formulario, listas, progreso y estados vacío/carga/error se reutilizan de `shared/widgets/`; no se reimplementan por pantalla.
- Radios, paddings, sombras y tamaños repetidos son constantes con nombre (`AppDimensions` o `constants/`).
- Si dos pantallas casi iguales difieren en poco, se unifican en un único widget parametrizado.
- Revisión manual obligatoria antes de entregar: confirmar que no se duplicó un widget existente.

---

## Servicios, repositorios y errores

- Un service por feature en `services/`; el acceso a SQLite vive en repositories (`shared/repositories/`) vía `AppDatabase`.
- Cada operación captura el error de la base y lanza una `Exception` con mensaje en español tomado de `constants/*_strings.dart`; nunca se traga el error.
- Los providers exponen estado (`cargando`, `error`, datos) y llaman a `notifyListeners()`; no navegan ni muestran diálogos.

---

## Colores

- Todo color se define únicamente en `AppColores` (`lib/app/core/theme/app_colores.dart`); `AppTema` lo toma de ahí.
- Fuera de `lib/app/core/theme/` no se escribe `Color(0x…)`, `Color.fromARGB`, `Colors.<nombre>` ni hex sueltos; solo se permite `Colors.transparent`.
- En widgets: `Theme.of(context).colorScheme` cuando exista el rol; si no, `AppColores.<token>`.
- Color nuevo: se agrega primero como token en `AppColores` (con su variante oscura si aplica), nunca en el widget.
- Cambiar la paleta implica editar solo `app_colores.dart`.

---

## Tests

- Tests en `test/` espejo de `lib/`, con los mismos banners e imports.
- Un test por service/provider nuevo; la UI crítica con `testWidgets`.

---

## Verificación automática

`dart run tools/verificar_reglas.dart [rutas]` (sin rutas revisa `lib`, `test` y `tools`) comprueba: nombre `snake_case`, ≤ 200 líneas por archivo, ≤ 30 por método, todo comentario es un banner de 80 columnas centrado, sin comentarios inline ni emojis, y grupos de imports bajo su banner, en orden, alfabéticos y sin líneas en blanco.

- Todo archivo nuevo o tocado debe salir con 0 incumplimientos antes de entregar, además de `flutter analyze` sin warnings.
- `--colores` (revisa `lib`) falla si hay `Color(0x…)`, `Color.fromARGB` o `Colors.x` (salvo `transparent`) fuera de `lib/app/core/theme/`.
- `--normalizar <rutas>` reescribe los banners existentes (incluido el formato antiguo `/*** TEXTO ***/`) al formato de 80 columnas.
- Regla nueva verificable → se añade en `tools/reglas/` y se documenta aquí.
- El código antiguo se migra al tocarlo; no mezclar migración masiva con cambios funcionales.

---

## Formato de entrega

1. **Árbol de carpetas** de lo creado o movido.
2. **Código completo** de cada archivo con su ruta, sin `...` ni `// resto del código`.
3. Orden: constants/utils → models/services/providers → widgets por carpeta → page.
4. Comandos a ejecutar si aplica (`flutter pub get`, `dart run tools/verificar_reglas.dart <rutas>`).
5. Al crear una feature nueva se trabaja por fases (constants/utils → models/services → providers → widgets → page → tests) y se entrega solo la fase pedida.
6. Una nota breve de decisiones no obvias, sin explicaciones largas. Respuestas en español.

### Checklist antes de entregar

- [ ] Archivos en las carpetas correctas con nomenclatura `[nombre]_[tipo].dart`
- [ ] `dart run tools/verificar_reglas.dart <rutas tocadas>` con 0 incumplimientos
- [ ] Sin strings, números ni breakpoints hardcodeados; usa `AppDimensions` y `ResponsiveHelper`
- [ ] Sin colores fuera de `AppColores`
- [ ] No se duplicó un widget existente
- [ ] Misma funcionalidad que el original
- [ ] Providers/servicios nuevos registrados en DI
- [ ] `flutter analyze` sin warnings
