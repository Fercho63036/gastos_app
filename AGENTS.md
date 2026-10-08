# AGENTS.md — Reglas para asistentes de IA (gastos_app)

> **Fuente única de verdad** para cualquier IA (Claude, ChatGPT/Codex, Gemini, Copilot, Cursor, etc.).
> `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md` y la skill de Claude solo apuntan aquí: **edita solo este archivo**.
> **Chats web** (ChatGPT, Gemini, Claude.ai) no leen el repo: pega este archivo en Instrucciones personalizadas / Proyecto / Gem.

# Flutter Clean Architecture (Feature-First)

Actúa como experto en Flutter y arquitectura de software. Al crear o refactorizar código, aplica estas reglas de forma estricta y mantén la funcionalidad exacta (no cambies lógica de negocio al refactorizar).

## 0. Adaptación al proyecto (hacer primero)

Antes de escribir código, detecta o pregunta una sola vez:

- Gestor de estado (Provider, Riverpod, BLoC...)
- Inyección de dependencias (GetIt, Riverpod, manual...)
- Persistencia (Drift, Isar, SQLite, API...)
- Clases del sistema de diseño existentes (p. ej. AppDimensions, ResponsiveHelper). Si no existen, propón crearlas en core/ antes de usarlas.
- Idioma de código (por defecto: nombres en español salvo que el proyecto use inglés)

Respeta el stack existente; no agregues dependencias ni cambies la arquitectura sin consultar.

### Stack detectado en gastos_app (2026-10-08)

- Estado: `provider` (ChangeNotifier + MultiProvider en `app_widget.dart`)
- DI: `get_it` + `injection.dart` en `lib/app/core/di/`
- Persistencia: SQLite con `sqflite` (`AppDatabase` en `lib/app/core/database/`)
- Rutas: `go_router` (`AppRouter` en `lib/app/core/routes/`)
- Sistema de diseño: `AppDimensions` en `lib/app/core/constants/`, `ResponsiveHelper` en `lib/app/core/utils/`
- Idioma: el código usa nombres en español (`Movimiento`, `PeriodoMes`, `ResumenMes`, etc.)

## 1. Estructura obligatoria

```
lib/app/
├── core/            # constants, theme, utils (ResponsiveHelper), di, errors
├── shared/          # models y widgets compartidos entre features
└── features/[feature]/
    ├── constants/
    │   ├── [feature]_strings.dart     # TODOS los textos visibles
    │   └── [feature]_constants.dart   # TODOS los números de lógica
    ├── utils/[feature]_helpers.dart   # funciones puras
    ├── models/[nombre]_model.dart
    ├── services/[nombre]_service.dart
    ├── providers/[nombre]_provider.dart
    ├── pages/[nombre]_page.dart       # scaffolds principales
    └── widgets/
        ├── [subcategoria]/            # agrupar si hay +3 widgets relacionados
        └── [feature]_widget.dart
```

Regla de dependencias: presentation → domain ← data. La UI no contiene lógica de negocio; los cálculos viven en services/helpers/use cases.

## 2. Strings y constantes

- Todo texto visible → `[Feature]Strings`
- Todo número de UI (padding, radius, icon, font, elevation, border) → `AppDimensions`
- Todo número de lógica → `[Feature]Constants`
- Todo breakpoint → `ResponsiveHelper`
- Prohibido: `Text('Guardar')`, `EdgeInsets.all(16)`, `fontSize: 14`, `if (x > 8000)`.

## 3. Widgets

- Máximo 200 líneas por archivo; un widget = un archivo (excepto helpers privados pequeños).
- Dividir widgets grandes en header/body/footer u otras partes lógicas.
- Agrupar en subcarpetas si hay más de 3 relacionados.
- Extraer widgets en clases, no en métodos grandes que devuelvan widgets.
- Usar `const` siempre que sea posible.
- Nombres descriptivos: `BotonPrimarioWidget`, no `Boton1`.

## 4. Responsividad

- Nunca hardcodear breakpoints (400, 600, 1024) ni usar `MediaQuery` suelto para decidir layout.
- Usar `ResponsiveHelper.isMobile/isTablet/isDesktop(context)`, `paddingAll`, `fontSize`, `spacing`, `columnCount`.

## 5. Código limpio

- Funciones de máximo 30 líneas, una sola responsabilidad.
- Variables con nombres completos (`colorScheme`, `screenWidth`, no `cs`, `w`).
- Extraer código duplicado a helpers o métodos genéricos.
- Sin código muerto, sin `dynamic` ni `!` sin justificación.
- Errores manejados de forma explícita; nunca `catch` vacío.
- Para dinero no usar `double`; usar enteros (centavos) o `Decimal`.

### 5.1 Comentarios de encabezado (banner)

Cada método y cada bloque lógico de una clase (variables estáticas, variables de carga, validadores, etc.) lleva **un comentario de encabezado tipo banner** inmediatamente arriba, en mayúsculas, con asteriscos de relleno a ambos lados:

```dart
/*************************** VALIDADORES ***********************************/
/***************************** VARIABLES ESTATICAS *************************/
/******************************** VARIABLE DE CARGA *******************************************/
    /*************************** CARGAR *********************************************************/
    /***************************** MENSAJES TOAST SATISFACTORIAMENTE ****************************/
```

- El texto del banner es el **nombre del bloque o método en mayúsculas** (p. ej. `CARGAR`, `VALIDADORES`), no una explicación de qué hace el código.
- Esta regla reemplaza cualquier criterio de "solo comentar si no es obvio": el banner va siempre, en todo método y bloque relevante.
- Indentación del banner igual a la del bloque que encabeza (los banners de métodos dentro de una clase van indentados igual que el método).
- Dentro del cuerpo del método sigue prohibido comentar línea por línea lo que el código ya dice por sí mismo; el banner es la única excepción permitida.

### 5.2 Prohibido comentar el historial del cambio

- Nunca agregar comentarios que describan qué se modificó, por qué se tocó ese código ahora, o que hagan referencia a la tarea/fix en curso (ej. `// se cambió esto para arreglar el bug`, `// nuevo método`, `// antes estaba así`).
- Esa información va en el mensaje de commit o en la conversación, nunca en el código.
- Los únicos comentarios permitidos en el código son los banners de 5.1; todo lo demás queda prohibido, incluso si parece útil para el reviewer.

### 5.3 Colores

- Todo color se define únicamente en `AppColores` (`lib/app/core/theme/app_colores.dart`); `AppTema` lo toma de ahí.
- Prohibido `Color(0x...)`, `Colors.xxx` y hex sueltos en widgets, features o shared.
- En widgets usar `Theme.of(context).colorScheme` cuando exista el rol; si no, `AppColores.<token>`.
- Un color nuevo se agrega primero como token en `AppColores` (con su variante oscura si aplica), nunca directo en el widget.
- Cambiar la paleta implica editar solo `app_colores.dart`.

## 6. Orden de imports

1. Flutter/Dart
2. Paquetes externos
3. Core
4. Shared
5. Feature (relativos)

Cada grupo presente en el archivo lleva su banner de encabezado (mismo formato de 5.1) inmediatamente arriba, en mayúsculas:

```dart
/****************************** FLUTTER / DART ******************************/
import 'package:flutter/material.dart';

/*********************************** CORE ***********************************/
import 'package:gastos_app/app/core/utils/responsive_helper.dart';
```

- Solo se agrega el banner de un grupo si el archivo tiene al menos un import de ese grupo.
- No inventar grupos vacíos ni reordenar imports para agruparlos artificialmente.

## 7. Orden dentro de una clase

1. Propiedades finales
2. Constructor
3. Métodos privados (`_manejarX`, `_buildX`)
4. `build`

## 8. Flujo de trabajo

Al recibir código a refactorizar:

1. Analizar la estructura actual e identificar violaciones.
2. Extraer strings y constantes.
3. Reemplazar valores hardcodeados por `AppDimensions` y `ResponsiveHelper`.
4. Dividir en archivos si supera 200 líneas y organizar en carpetas.
5. Verificar con el checklist.

Al crear una feature nueva, trabajar por fases: constants/utils → models/services → providers → widgets → page → tests. Entregar solo la fase pedida.

## 9. Formato de entrega

- Árbol de carpetas resultante.
- Código completo de cada archivo con su ruta (nunca usar `...` ni `// más código`).
- Orden: constants/utils → models/services/providers → widgets por carpeta → page.
- Comandos a ejecutar si aplica (`flutter pub get`, `build_runner`).
- Sin explicaciones largas: solo una nota breve de decisiones no obvias.

## 10. Checklist antes de entregar

- [ ] Archivos en las carpetas correctas y con nomenclatura `[nombre]_[tipo].dart`
- [ ] Ningún archivo supera 200 líneas ni función 30 líneas
- [ ] Sin strings, números ni breakpoints hardcodeados
- [ ] Usa `AppDimensions` y `ResponsiveHelper`
- [ ] Sin colores hardcodeados fuera de `AppColores`
- [ ] Nombres descriptivos y sin código duplicado
- [ ] Misma funcionalidad que el original
- [ ] Providers/servicios registrados en DI si son nuevos
- [ ] `flutter analyze` sin warnings

## Errores comunes a evitar

- `16.0` en vez de `AppDimensions.paddingM`
- `width < 600` en vez de `ResponsiveHelper.isMobile(context)`
- Texto hardcodeado en vez de `[Feature]Strings`
- Archivos de 500 líneas sin dividir
- Variables cortas (`cs`, `tt`, `w`)
- Lógica de negocio dentro de widgets
- Cambiar la lógica al refactorizar
- Entregar sin pasar el checklist

## Tono

Sé preciso y directo, entrega código completo y ordenado, responde en español.
