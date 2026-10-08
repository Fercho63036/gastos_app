# Gastos App

Aplicación Flutter para registrar y gestionar gastos personales con almacenamiento local.

## Requisitos

- Flutter 3.41.6+ (Dart SDK ^3.11.4)
- Java JDK 17
- Android SDK API 24+

## Instalación

```bash
flutter pub get
```

## Ejecutar

```bash
flutter clean
flutter pub get

# Android
flutter run -d emulator-5554

# iOS
flutter run -d ios

# Auto
flutter run
```

## Dependencias Principales

- `provider: ^6.1.2` - Gestión de estado
- `sqflite: ^2.4.1` - Persistencia local (SQLite)
- `path: ^1.9.0` - Manejo de rutas
- `path_provider: ^2.1.4` - Directorios del sistema

## Estructura

```
lib/
├── main.dart
└── app/
    ├── app_widget.dart       # MultiProvider + GoRouter (punto de entrada)
    ├── core/                 # constants, database, theme, di, routes, utils
    ├── shared/               # models, widgets, services, repos compartidos
    └── features/
        ├── auth/             # login, registro, recuperar contraseña
        ├── inicio/           # pantalla principal con movimientos y saldo
        ├── movimientos/      # nuevo gasto, nueva entrada, detalle
        ├── perfil/           # ver y editar perfil de usuario
        ├── periodo/          # iniciar mes / periodo
        └── resumen/          # gráficas de gastos por categoría y por día
```

Las reglas de arquitectura para desarrolladores e IAs están en [AGENTS.md](AGENTS.md).

## Comandos Útiles

```bash
# Ver dispositivos
flutter devices

# Analizar código
flutter analyze

# Ejecutar tests
flutter test

# Construir APK
flutter build apk --release

# Limpiar proyecto
flutter clean
```

## Configuración Android

Definida en `android/app/build.gradle.kts`:

- minSdk: 24 (valor por defecto de Flutter)
- targetSdk: 36 (valor por defecto de Flutter)
- Java: 17
