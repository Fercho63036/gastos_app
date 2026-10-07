# MI Chuspa — Requisitos funcionales (versión corregida)

App Android (Flutter), personal, local, sin backend. Todos los montos en bolivianos (Bs). Tema claro y oscuro.

Estado: ✅ pantalla ya desarrollada · 🔲 pendiente de desarrollar · ⚠️ por confirmar
(El estado vivo y actualizable está en `estado.md`; este archivo es el texto de referencia de cada RF, no lo edites al avanzar.)

## Acceso y cuenta

- **RF-01** ✅ Iniciar sesión con correo electrónico y contraseña (con botón para mostrar/ocultar contraseña). *(Corregido: antes decía "usuario y contraseña".)*
- **RF-23** ✅ Crear cuenta con nombre completo, correo, contraseña y confirmar contraseña.
- **RF-24** ✅ Recuperar contraseña ingresando correo y nueva contraseña (2 veces), todo local. ⚠️ Sin verificación por código: quien tenga el teléfono y sepa el correo podría cambiarla. (Ver decisión adoptada en SKILL.md.)
- **RF-25** ✅ Cerrar sesión desde el menú lateral.
- **RF-26** ✅ Cambiar entre tema claro y oscuro con el botón de sol.
- **RF-27** 🔲 Pantalla Perfil (contenido por definir).

## Presupuesto y entradas

- **RF-02** 🔲 Monto del mes editable en cualquier momento (subir o bajar). ⚠️ Ver "puntos por confirmar".
- **RF-03** 🔲 Cada recarga o ampliación se registra como entrada (fecha, monto, motivo opcional). ⚠️ Ver "puntos por confirmar".
- **RF-04** 🔲 El mes se inicia manualmente. El saldo sobrante se arrastra hasta que recargues.
- **RF-05** 🔲 Todos los montos en bolivianos (Bs).

## Gastos

- **RF-06** 🔲 Registrar gasto con monto, descripción y categoría. Fecha y hora automáticas del teléfono.
- **RF-07** 🔲 Categorías: comida, pasajes, diversión, ropa, deportes y otros.
- **RF-08** 🔲 Los gastos no se borran. Se editan monto, descripción, categoría y estado.
- **RF-09** 🔲 Anular y reactivar un gasto. Un gasto anulado no cuenta en el saldo y no se elimina.
- **RF-10** 🔲 Cada gasto descuenta automáticamente del saldo.
- **RF-11** 🔲 Cada gasto guarda un ID único y fecha y hora internos, no editables.
- **RF-12** 🔲 Al editar un monto, el saldo, las alertas y los gráficos se recalculan al instante.
- **RF-13** 🔲 Cada edición crea un registro de historial: ID del gasto, fecha y hora, campo editado, valor anterior y valor nuevo.

## Listados

- **RF-14** 🔲 Gastos en tres vistas: Hoy, Semana y Mes, con fecha y hora. (La pantalla "Gastos" existe solo con el estado vacío; la opción "Lista de gastos" está en el menú.)
- **RF-15** 🔲 Semana de 7 días corridos.

## Piso y alertas

- **RF-16** 🔲 Piso editable (50 Bs por defecto). Gastable = saldo − piso.
- **RF-17** 🔲 Se puede gastar por debajo del piso, sin bloqueo.
- **RF-18** 🔲 Notificaciones al llegar al 20%, 15%, 10%, 5% y 0% del gastable (estilo batería). ⚠️ Ver "puntos por confirmar".
- **RF-19** 🔲 Saldo en rojo desde el 20% hacia abajo.
- **RF-20** 🔲 Bajo el piso, cada vez que se abre la app sale un aviso de que ya no deberías gastar más.

## Resumen y listado

- **RF-21** 🔲 Gráfico circular por categoría y barras por día, semana o mes.
- **RF-22** 🔲 Listado de gastos filtrable por Semana, Mes y Año, con entradas, resumen por categoría e historial de ediciones, todo dentro de la app (sin Excel).

## Puntos por confirmar (ver decisiones adoptadas en SKILL.md)

- RF-02 y RF-03 se pisaban. Propuesta adoptada: el monto del mes es el dinero inicial, las entradas se suman aparte y el saldo = monto del mes + entradas − gastos activos.
- Base del porcentaje (RF-18). Propuesta adoptada: calcular el % sobre (monto del mes + entradas − piso). Cada recarga recalcula el 100%.
- Seguridad de la cuenta (RF-24). Decisión adoptada: se deja sin pregunta de seguridad ni respaldo.

## Pendientes de antes (genuinamente abiertos, preguntar a Ariel si la tarea los toca)

- ¿El historial de ediciones se ve dentro de la app (decidido: dentro de la app)?
- ¿Las categorías son fijas o puedes crear las tuyas?
- ¿Vista Año dentro del listado? (decidido: sí, filtro Semana/Mes/Año)
