# Contrato del API — gastos_app

La app ya habla con interfaces que tienen esta forma:

- `MovimientosRepositorio`, en `lib/app/shared/repositories/movimientos_repositorio.dart`
- `AuthRepositorio`, en `lib/app/features/auth/repositories/auth_repositorio.dart`

Hoy las implementan versiones locales sobre SQLite (`*LocalRepositorio`). Para conectar el backend se implementan estas interfaces llamando a los endpoints de abajo y se registran en `_registrarRepositorios()` (`lib/app/core/di/injection.dart`).

El (de)serializado ya está hecho y probado en `lib/app/shared/dto/` y `lib/app/features/auth/dto/`.

## Convenciones

| Tema | Regla |
|---|---|
| Formato | JSON con claves `snake_case` (`ApiClaves`, `AuthClaves`) |
| Dinero | Siempre `int` en **centavos** (`2500` = Bs 25,00). Nunca decimales |
| Fechas | ISO-8601 en UTC (`2026-10-05T17:20:00.000Z`). La app convierte a hora local |
| Ids | El servidor elige el tipo; la app lo trata como texto |
| Categoría | `comida`, `pasajes`, `diversion`, `ropa`, `deportes`, `otros`, `entrada` |
| Auth | Header `Authorization: Bearer <token>` en todo salvo `/auth/*` |
| Paginación | `pagina` empieza en 1. Respuesta `{"datos": [...], "total": n}` |

## Errores → `AppException` (`lib/app/core/errors/app_exception.dart`)

| HTTP | Excepción | Cuerpo esperado |
|---|---|---|
| sin red / timeout | `SinConexionException` | — |
| 401 | `NoAutorizadoException` (el ApiClient debe llamar `AuthProvider.logout()`) | — |
| 404 | `NoEncontradoException` | `{"mensaje": "..."}` opcional |
| 422 | `ValidacionException(mensaje)` | `{"mensaje": "No hay cambios para guardar"}` |
| 5xx | `ServidorException` | — |

La UI muestra `mensaje` tal cual, así que para 422 el texto debe venir listo para el usuario.

## Reglas de negocio que pasan al servidor

Hoy viven en `MovimientosLocalRepositorio` y su lógica de referencia está en `ResumenHelpers` y `EdicionesHelpers`:

1. **Código**: `G-0007` para gastos y `E-0008` para entradas (prefijo + id con 4 dígitos).
2. **Fecha** del movimiento y del periodo: la hora del servidor al crearlo.
3. **Resumen**: cuentan los movimientos **no anulados** con `fecha >= periodo.inicio`.
   - `ingresado = arrastrado + monto_mes + Σ entradas`
   - `saldo = ingresado − Σ gastos`
   - `gastable = saldo − piso`
   - `gastable_total = ingresado − piso`
   - Sin mes iniciado, todo vale 0 y cuentan todos los movimientos.
4. **Historial**: al editar, por cada campo que cambió (en este orden: `monto`, `descripcion`, `categoria`, `estado`) se antepone `{campo, valor_anterior, valor_nuevo, fecha}` con valores **crudos**:
   - `monto`: centavos en texto (`"2500"`)
   - `descripcion`: el título
   - `categoria`: su `name`
   - `estado`: `activo` o `anulado`
   
   Si no cambió nada, se responde 422.
5. **Iniciar mes**: `arrastrado_centavos = saldo actual`, `inicio = ahora`.
6. **Validaciones** (la app también las aplica, pero el servidor manda):
   - monto ≥ 1
   - descripción no vacía en los gastos
   - `piso ≤ arrastrado + monto_mes`

## Endpoints

### Movimientos

**`GET /resumen`** → `200`
```json
{"saldo_centavos": 124550, "gastable_centavos": 119550, "gastable_total_centavos": 192800, "piso_centavos": 5000}
```

**`GET /movimientos?desde=<ISO>&pagina=1&por_pagina=8`** → `200`

Del más reciente al más antiguo (`fecha DESC, id DESC`). Incluye los anulados.
```json
{"datos": [Movimiento], "total": 23}
```

**`GET /movimientos/{id}`** → `200 Movimiento` · `404`

**`POST /movimientos`** → `201 Movimiento`
```json
{"titulo": "Almuerzo", "categoria": "comida", "monto_centavos": 2500, "es_entrada": false}
```

**`PATCH /movimientos/{id}`** → `200 Movimiento` (con `ediciones` ya actualizadas) · `404` · `422`
```json
{"titulo": "Almuerzo", "categoria": "pasajes", "monto_centavos": 2500, "anulado": true}
```

**Movimiento**
```json
{
  "id": "7", "codigo": "G-0007", "titulo": "Almuerzo", "categoria": "comida",
  "monto_centavos": 2500, "fecha": "2026-10-05T17:20:00.000Z",
  "anulado": false, "es_entrada": false,
  "ediciones": [
    {"campo": "monto", "valor_anterior": "2000", "valor_nuevo": "2500", "fecha": "2026-10-05T17:45:00.000Z"}
  ]
}
```
`ediciones` va de la más reciente a la más antigua. En el listado puede venir vacío para aligerar la respuesta, porque la app solo lo usa en el detalle.

### Periodos

**`GET /periodos/actual`** → `200 Periodo` · `204` si nunca se inició un mes

**`POST /periodos`** → `201 Periodo`
```json
{"monto_mes_centavos": 190000, "piso_centavos": 5000}
```

**Periodo**
```json
{"inicio": "2026-10-01T12:00:00.000Z", "arrastrado_centavos": 8500, "monto_mes_centavos": 190000, "piso_centavos": 5000}
```

### Auth

| Endpoint | Cuerpo | Respuesta |
|---|---|---|
| `POST /auth/login` | `{"correo", "contrasena"}` | `200 Sesion` · `401` |
| `POST /auth/registro` | `{"nombre", "correo", "contrasena"}` | `201` · `422` (correo ya usado) |
| `POST /auth/recuperar` | `{"correo", "contrasena"}` (nueva) | `200` · `404` |
| `POST /auth/logout` | — (token en el header) | `204` |

**Sesion**
```json
{"token": "eyJ...", "usuario": {"correo": "a@b.co", "nombre": "Ana"}}
```

## Pasos para conectar

1. `flutter pub add dio` (y se recomienda `flutter_secure_storage` para el token).
2. `lib/app/core/api/api_client.dart`:
   - base URL desde `--dart-define=API_BASE_URL`
   - interceptor con `Authorization` (el token se lee de `StorageService.leerTokenSesion()`)
   - conversión de errores HTTP a `AppException` según la tabla de arriba
3. `MovimientosApiRepositorio` y `AuthApiRepositorio` implementan las interfaces usando los DTOs.
4. Cambiar los dos registros en `_registrarRepositorios()`.
5. Borrar `lib/app/shared/repositories/local/`, `AuthLocalRepositorio` y, si ya no se usan, `MovimientosSqliteAlmacen` y `AppDatabase`.
