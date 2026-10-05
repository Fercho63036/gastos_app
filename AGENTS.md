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

### Stack detectado en gastos_app (2026-10-05)

- Estado: `provider` (ChangeNotifier + MultiProvider en `app.dart`)
- DI: manual, vía `MultiProvider` en `lib/app.dart`
- Persistencia: SQLite con `sqflite` (`DatabaseHelper` en core)
- Sistema de diseño: `AppDimensions` y `ResponsiveHelper` **no existen aún** → proponer crearlos en core/ antes de usarlos
- Idioma: el código existente usa nombres en inglés (`Expense`, `ExpensesProvider`); confirmar con el usuario antes de mezclar idiomas
- Desvíos actuales respecto a la estructura objetivo: el código vive en `lib/core` y `lib/features` (no `lib/app/...`), usa `presentation/screens` en lugar de `pages`, y `Expense.amount` es `double` (debe migrar a centavos `int`)

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
- Sin comentarios obvios; solo comentar el "por qué".
- Sin código muerto, sin `dynamic` ni `!` sin justificación.
- Errores manejados de forma explícita; nunca `catch` vacío.
- Para dinero no usar `double`; usar enteros (centavos) o `Decimal`.

## 6. Orden de imports

1. Flutter/Dart
2. Paquetes externos
3. Core
4. Shared
5. Feature (relativos)

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
