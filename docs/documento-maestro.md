# PESAO FIT — Documento Maestro (v4)

> Última actualización: F2-A/B/C + F4-A/B/C + Planificador semanal completos.

## Visión

Superapp fitness multi-tenant: dueños de gimnasios, entrenadores, nutricionistas y clientes.
Adaptada a Venezuela: pagos manuales, moneda local/USD, notificaciones alternativas.
UI: español venezolano. Código: INGLES.

## Roles

Leonel (superadmin) | Dueño | Entrenador | Nutricionista | Cliente.

## Modelo de negocio

| Feature | Pluma (gratis) | Hierro ($15-25) | Macizo ($40-60) |
|---|---|---|---|
| Clientes | 5 | 50 | Ilimitado |
| Entrenadores | 1 | 3 | Ilimitado |
| Nutricionistas | 0 | 1 | Ilimitado |
| Planes de membresía del gym | 1 | 2 | Ilimitado |
| Plantillas de rutina | 5 | 30 | Ilimitado |
| Semanas por plan de entrenamiento | 2 | 8 | Ilimitado |
| Duplicar semanas | ❌ | ✅ | ✅ |
| Nutrición | ❌ | ✅ | ✅ |
| Chat | ❌ | ✅ | ✅ |
| Reportes | ❌ | ✅ | ✅ |
| Sucursales / QR / IA / Wearables | ❌ | ❌ | ✅ |

### Membresías del gimnasio (F4-C)

El dueño crea planes de membresía para sus clientes (ej: "Solo Gym $15", "Con Coach $30").
Cada cliente tiene una suscripción con saldo acumulativo:
- `balance_usd > 0` → el cliente debe dinero.
- `balance_usd = 0` → está al día.
- `balance_usd < 0` → tiene crédito a favor (pagó por adelantado).

El saldo se reduce con cada pago aprobado y se incrementa al iniciar un nuevo período.
Límite de planes por tier: Pluma=1, Hierro=2, Macizo=ilimitado.

### Planificador semanal (F2-C)

El entrenador crea rutinas (plantillas reutilizables) y las asigna a días de semanas
dentro de un plan de entrenamiento por cliente. Una rutina puede usarse en múltiples
días/semanas sin duplicarla. Semanas pueden duplicarse (feature de Hierro/Macizo).
El cliente ve su plan activo con la semana actual y el día de hoy resaltado.

## Estado actual del proyecto

| Módulo | Estado | Detalle |
|---|---|---|
| F1 Fundación | ✅ Completo | Auth, KYC, gym discovery, 5 dashboards, shells |
| F2-A Rutinas + Ejercicios | ✅ Completo | Biblioteca 33 ejercicios globales + personalizados, CRUD rutinas |
| F2-B Vista del cliente | ✅ Completo | Tab Rutina conectada, dashboard con próximo entreno real |
| F2-C Planificador semanal | ✅ Completo | Planes por cliente, semanas, días, duplicar semanas |
| F4-A Pagos del dueño | ✅ Completo | Lista de comprobantes, aprobar/rechazar con motivo |
| F4-B Comprobantes cliente | ✅ Completo | Subida a Cloudinary, sheet de pago con monto automático |
| F4-C Membresías del gym | ✅ Completo | Planes del gym, suscripciones, saldo, assign_plan_to_client |
| Gestión de Staff | ✅ Completo | Listar, invitar, activar/desactivar, límites por tier |
| Gestión de Clientes | ✅ Completo | Listar, agregar, detalle, activar/desactivar |
| F2-D Ejecución de rutina | ⏳ Pendiente | Marcar sets, rest timer, registrar workout |
| F3 Nutrición | ⏳ Pendiente | Alimentos, planes, macros |
| F5 Comunidad | ⏳ Pendiente | Insignias, retos, rankings |
| F6 Avanzado | ⏳ Pendiente | Wearables, QR, reportes |

### Dashboards

| Rol | Estado |
|---|---|
| Superadmin | ✅ Stats reales de gyms/solicitudes/suscripciones |
| Dueño | ✅ Clientes reales, pagos reales, planes de membresía, planificador |
| Entrenador | ✅ Planificador semanal completo, rutinas, ejercicios |
| Cliente | ✅ Suscripción real, plan de entrenamiento, próximo entreno |
| Nutricionista | ⏳ Todo placeholder hasta F3 |

## Fases

### F1 Fundación ✅
Splash, onboarding+términos, auth email/password, registro de dueño con KYC manual,
gym discovery, shells por rol con FAB contextual, dashboards.

### F2 Núcleo fitness
- F2-A ✅: Biblioteca de ejercicios (33 globales + personalizados por gym), CRUD de rutinas
  como plantillas reutilizables (`routines.client_id` nullable).
- F2-B ✅: El cliente ve su rutina/plan asignado en tab Rutina. Dashboard muestra próximo entreno.
- F2-C ✅: Planificador semanal. Entrenador crea planes por cliente con semanas y días.
  Duplicación de semanas (Hierro/Macizo). Límites por tier.
- F2-D ⏳: Ejecución de rutina (marcar sets completados), rest timer, registro de workouts,
  historial, gráficos.

### F3 Nutrición ⏳
Alimentos, planes semanales, macros, consultas.

### F4 Monetización
- F4-A ✅: Verificación de pagos del dueño (lista con filtros, detalle con comprobante,
  aprobar/rechazar con motivo, auditoría).
- F4-B ✅: Subida de comprobantes del cliente (Cloudinary cuenta 2, sheet con monto
  automático según plan/saldo).
- F4-C ✅: Membresías del gimnasio. Planes del gym con precio/duración/flags.
  Suscripciones por cliente con saldo acumulativo. `approve_payment` actualiza saldo
  y extiende vencimiento.
- F4-D ⏳: Recordatorios de pago, suspensión automática a 7 días.

### F5 Comunidad ⏳
Insignias, retos, rankings, feed.

### F6 Avanzado ⏳
Wearables, QR, reportes.

## Tecnologías

Flutter | Supabase (PostgreSQL/Auth/Storage/Realtime) | Cloudinary x2 (upload directo unsigned) |
OneSignal (fallback email) | Gemini API con cache | Drift (offline SQL/NoSQL) | Riverpod codegen |
GoRouter | Freezed+json_serializable | fl_chart | fuentes Manrope+Barlow Condensed embebidas |
gen-l10n es_VE.

## Sistema de Diseño y UX (RESUMEN — detalle en design-system.md)

Tema "Dark Athletic Luxe": morado #8B5CF6 = marca/acción; verde #22C55E = SOLO éxito; fondo
#0B0B10 (OLED opcional). Kit propio Pesao* (botones, cards, inputs, bottom nav, FAB contextual,
skeletons, banners, modales). Shell por rol: 4 tabs + FAB. Dashboard template y screen template
con 5 estados obligatorios. Microcopy venezolano suave. DoD de 15 puntos por pantalla.

## Base de datos (25 tablas)

### Tablas principales (20)
profiles, gyms, memberships, plans, subscriptions, payments, routines, exercises,
routine_exercises, workouts, workout_exercises, body_measurements, progress_photos,
notifications, chats, messages, gym_settings, audit_logs, exchange_rates, gym_applications.

### Tablas nuevas (5)
| Tabla | Módulo | Descripción |
|---|---|---|
| `gym_membership_plans` | F4-C | Planes de membresía que el gym ofrece a sus clientes |
| `client_subscriptions` | F4-C | Suscripción activa del cliente con saldo acumulativo |
| `training_plans` | F2-C | Plan de entrenamiento asignado a un cliente |
| `training_plan_weeks` | F2-C | Semanas dentro de un plan (week_number, name) |
| `training_plan_days` | F2-C | Días dentro de una semana (day_of_week, routine_id, is_rest_day, notes) |

### Columnas agregadas a tablas existentes
| Tabla | Columnas nuevas |
|---|---|
| `plans` | `max_staff`, `max_membership_plans`, `max_routine_templates`, `max_plan_weeks`, `can_duplicate_weeks` |
| `payments` | `rejected_reason`, `payment_kind`, `subscription_id` |
| `routines` | `client_id` ahora NULLABLE (plantillas), `description`, `is_active` |
| `exercises` | `muscle_group`, `image_url`, `updated_at` |
| `gym_settings` | `bcv_rate` |

### RLS
`is_gym_member` / `get_gym_role` / `is_active_gym_owner` / `is_superadmin` /
`has_client_membership` / `can_view_profile`.
Políticas granulares en todas las tablas (SELECT/INSERT/UPDATE/DELETE separados donde aplica).

### Vistas
`active_members`, `pending_payments` (con `security_invoker = true`).

### Triggers
`update_updated_at_column` (en routines, workouts, exercises, gym_membership_plans,
client_subscriptions, training_plans), `on_auth_user_created`, `handle_new_user`,
`log_payment_change`, `trg_routines_updated_at`, `trg_workouts_updated_at`,
`trg_exercises_updated_at`, `trg_gmp_updated_at`, `trg_cs_updated_at`,
`trg_training_plans_updated_at`.

### Funciones SQL clave
| Función | Uso |
|---|---|
| `approve_payment(payment_id)` | Verifica pago, actualiza saldo de suscripción, extiende vencimiento, reactiva cliente |
| `reject_payment(payment_id, reason)` | Rechaza pago con motivo |
| `assign_plan_to_client(user_id, gym_id, plan_id)` | Asigna plan de membresía, cancela anterior, reutiliza suscripciones cancelled/expired |
| `get_client_balance(user_id, gym_id)` | Devuelve JSON con plan, saldo, vencimiento |
| `duplicate_plan_week(week_id, new_number, name)` | Duplica semana con todos sus días (valida tier) |
| `get_client_current_week(user_id, gym_id)` | Devuelve JSON con semana actual del cliente |
| `can_add_staff / can_add_client / can_add_membership_plan` | Validan límites de tier |
| `can_add_routine_template / can_add_plan_week / can_duplicate_weeks` | Validan límites del planificador |
| `set_staff_active / set_client_active` | Activar/desactivar membresías |

## Pantallas — Estado real

### Construidas y funcionales

**Públicas (10):**
Splash, Onboarding, Términos, Login, Registro, Forgot Password,
Gym Discovery, Gym Detail, Owner Application (KYC), Application Pending.

**Superadmin (3):**
Dashboard, Gym Applications list, Application detail (aprobar/rechazar).

**Dueño (13):**
Dashboard, Staff list, Staff add, Clients list, Client add, Client detail,
Payments list, Payment detail, Membership Plans list, Membership Plan form,
Training Plans list, Training Plan form, Plan Week Editor.

**Cliente (3):**
Dashboard, Client Routine Screen (tab Rutina), Upload Payment Sheet.

**Entrenador (8):**
Dashboard, Routines list (plantillas), Routine form, Exercises list,
Exercise form, Training Plans list, Training Plan form, Plan Week Editor.

**Nutricionista (1):**
Dashboard (placeholder).

**Modales/Sheets (7):**
Confirm Dialog, Upload Payment Sheet, Exercise Picker Sheet, Day Assignment Sheet,
Assign Plan Sheet, Client Selector, Image Picker Field.

**Total construido: ~45 pantallas/modales.**

### Pendientes de construir
- Nutricionista: todas las pantallas de F3.
- Cliente: ejecución de rutina (F2-D), nutrición (F3), perfil editable.
- Dueño: perfil editable, configuración del gym.
- Superadmin: panel de pagos de suscripciones de gyms.

## Flujos principales

### Flujo de pagos manuales (F4 completo)
1. Cliente abre sheet de pago → ve su plan, saldo pendiente, tasa BCV.
2. Elige monto (puede pagar parcial o adelantado).
3. Toma foto del comprobante → sube a Cloudinary (cuenta 2, preset unsigned).
4. Inserta pago en Supabase con `subscription_id` y `payment_kind = 'client_membership'`.
5. Dueño ve comprobante pendiente en tab Pagos.
6. Dueño aprueba → `approve_payment()` reduce saldo, extiende vencimiento, reactiva cliente.
7. Dueño rechaza → `reject_payment()` con motivo → cliente ve el motivo.

### Flujo de membresías del gym (F4-C)
1. Dueño crea planes de membresía (nombre, precio USD, duración, flags).
2. Dueño asigna plan a cliente → `assign_plan_to_client()`.
3. Cliente ve su plan en dashboard (SubscriptionCard) con saldo y vencimiento.
4. Al pagar y ser aprobado, saldo se reduce automáticamente.

### Flujo de planificador semanal (F2-C)
1. Entrenador crea rutinas (plantillas) con ejercicios, series, reps, peso, descanso.
2. Entrenador crea plan de entrenamiento para un cliente.
3. Agrega semanas al plan (límite por tier).
4. En cada semana, asigna rutinas a días (L-D), marca descansos, agrega notas.
5. Puede duplicar semanas (Hierro/Macizo).
6. Cliente ve su plan activo con la semana actual y el día de hoy resaltado.

### Flujo de alta de staff (ADR-035)
Entrenadores y nutricionistas NO se auto-registran. El dueño los crea/invita desde su panel
de gestión de staff, respetando el límite del plan activo (Pluma=1, Hierro=3, Macizo=ilimitado).

### Flujo KYC de dueños (ADR-036)
Registro → Onboarding "Soy dueño" → Formulario de solicitud → Estado "pending" →
Superadmin revisa → Aprobar (crea gym+membership+subscription Pluma) o Rechazar (cooldown 7 días).

### Flujo de registro de clientes
Registro → Onboarding "Soy cliente" → Gym discovery → Solicita membresía →
Dueño aprueba → Cliente accede a su dashboard.

## Integraciones

Tasa BCV API dolarAPI | opcional (manual por gimnasio, tabla `gym_settings.bcv_rate`) | Radioweb |
Clipboard para datos de pago | (crash reporting); sin analytics de producto en el MVP.

## Métricas

50 gimnasios/6 meses | 1.000 clientes/1 año | conversión Pluma→Hierro 30%.

## REGLA DE ORO

Ninguna pantalla se marca como terminada sin el checklist DoD completo (design-system.md §14).