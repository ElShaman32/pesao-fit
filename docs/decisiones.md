# PESAO FIT - Decisiones Arquitectónicas (v4)

> Última actualización: F2-A/B/C + F4-A/B/C + Planificador semanal.

## ADR-001: Base de datos multi-tenant con RLS
**Contexto:** Un solo backend para muchos gimnasios.
**Decisión:** Una cuenta Supabase con aislamiento por `gym_id` + Row Level Security.
**Consecuencias:** Escala simple, sin duplicar infraestructura. Sharding futuro por región si se necesita.

## ADR-002: Pagos manuales con comprobantes
**Contexto:** Venezuela no tiene Stripe/MercadoPago.
**Decisión:** Pagos por transferencia/Pago Móvil. Cliente sube foto del comprobante. Dueño verifica manualmente.
**Consecuencias:** Sin pasarela automática. Flujo de aprobación/rechazo con motivo. Auditoría completa en `audit_logs`.

## ADR-003: Multi-tenant RLS
**Contexto:** Aislar datos entre gimnasios.
**Decisión:** Funciones `is_gym_member()`, `get_gym_role()`, `is_active_gym_owner()`, `is_superadmin()`, `has_client_membership()`, `can_view_profile()`.
**Consecuencias:** Políticas granulares por tabla. Sin fugas entre tenants.

## ADR-004: Pagos manuales con verificación del dueño
**Contexto:** El dueño necesita confirmar pagos antes de activar clientes.
**Decisión:** Tabla `payments` con estados `pending/verified/rejected`. Funciones `approve_payment()` y `reject_payment()`.
**Consecuencias:** `approve_payment` actualiza saldo de suscripción, extiende vencimiento, reactiva cliente. `reject_payment` guarda motivo visible para el cliente.

## ADR-005: Moneda dual
**Contexto:** Venezuela maneja Bs y USD simultáneamente.
**Decisión:** `amount_usd` y `amount_bs` en pagos. `rate_used` guarda la tasa aplicada al momento.
**Consecuencias:** Auditoría clara. El cliente siempre ve ambos montos.

## ADR-006: Notificaciones multi-canal
**Contexto:** FCM falla en Venezuela.
**Decisión:** OneSignal push + fallback email. Radioweb como alternativa.
**Consecuencias:** Sin dependencia de FCM. Cobertura amplia.

## ADR-007: IA con Gemini
**Contexto:** OpenAI bloquea Venezuela.
**Decisión:** Gemini API con cache de respuestas.
**Consecuencias:** Sin bloqueo geográfico. Cache reduce costos.

## ADR-008: Cloudinary upload directo unsigned
**Contexto:** Supabase Storage tiene límite de 1GB en free tier.
**Decisión:** Subida directa desde el cliente a Cloudinary con preset unsigned. NUNCA por Edge Function.
**Consecuencias:** Sin consumo de banda de Supabase. Transformaciones automáticas. Dos cuentas separadas.

## ADR-009: Tema Dark Athletic Luxe
**Contexto:** Identidad visual de marca fitness.
**Decisión:** Morado #8B5CF6 como marca. Verde #22C55E SOLO para éxito. Fondo #0B0B10.
**Consecuencias:** Consistencia visual. No se negocia en marca blanca.

## ADR-010: UI Kit Pesao* propio
**Contexto:** Material Design genérico no transmite la marca.
**Decisión:** Componentes Pesao* construidos sobre tokens. BackdropFilter y shaders PROHIBIDOS.
**Consecuencias:** Rendimiento en gama baja. Identidad propia. Glow con BoxShadow barato.

## ADR-011: 5 estados obligatorios por pantalla
**Contexto:** UX consistente en toda la app.
**Decisión:** Toda pantalla maneja idle, loading, success, failure, offline.
**Consecuencias:** Sin pantallas vacías o rotas. Skeleton loaders en todo.

## ADR-012: Microcopy venezolano suave
**Contexto:** La app debe sentirse cercana, no corporativa.
**Decisión:** Español venezolano. Emojis en mensajes pero NO en semantics. Errores suaves, nunca agresivos.
**Consecuencias:** `semanticsLabel` siempre sin emoji. TalkBack lee limpio.

## ADR-013: DoD de 15 puntos
**Contexto:** Evitar entregar pantallas incompletas.
**Decisión:** Checklist de 15 puntos obligatorio antes de marcar pantalla como terminada.
**Consecuencias:** Calidad consistente. Sin deuda de UX.

## ADR-014: Fuentes embebidas
**Contexto:** Google Fonts por red falla offline.
**Decisión:** Manrope + Barlow Condensed embebidas en `assets/fonts/`.
**Consecuencias:** Sin dependencia de red para tipografía.

## ADR-015: Sentry para crash reporting
**Contexto:** Necesitamos visibilidad de errores en producción.
**Decisión:** Sentry para crash reporting y breadcrumbs.
**Consecuencias:** Sin analytics de producto en el MVP. Solo crashes.

## ADR-016: Edge Functions solo para lógica de negocio
**Contexto:** Evitar abusar de Edge Functions.
**Decisión:** Solo verify-payment, send-reminder, generate-nutrition-plan, approve-gym. NUNCA para subir fotos.
**Consecuencias:** Cloudinary maneja imágenes. Supabase Storage solo para temporales.

## ADR-017: Tasa BCV directa con cache + override manual
**Contexto:** Necesitamos la tasa BCV vigente para pagos en Bs. Actualizado en v4.
**Decisión:** Llamada directa a dolarAPI desde la app con cache local de 4 horas. Override manual opcional por gimnasio (`gym_settings.bcv_rate_override`).
**Consecuencias:** Cero costo de infraestructura. Sin Edge Function para el MVP. Si crecemos, migramos a Edge Function con cron. Ver ADR-043.

## ADR-018: Offline-first con Drift
**Contexto:** Venezuela tiene conectividad intermitente.
**Decisión:** Cache Drift para lecturas. Cola de sync para escrituras. 15 tablas en Drift.
**Consecuencias:** La app funciona sin internet para datos cacheados. Pagos y chats requieren conexión.

## ADR-019: Marca blanca limitada
**Contexto:** Gimnasios quieren personalizar la app.
**Decisión:** Solo primary color y logo son personalizables. Success/warning/error, tipografías y radios FIJOS.
**Consecuencias:** La marca PESAO FIT se mantiene reconocible. Sin romper accesibilidad.

## ADR-020: Riverpod codegen
**Contexto:** Gestión de estado predecible.
**Decisión:** `@riverpod` con codegen. Providers keepAlive para datos que sobreviven a navegación.
**Consecuencias:** Sin setState disperso. Estado centralizado y testeable.

## ADR-021: GoRouter con StatefulShellRoute
**Contexto:** Navegación por tabs con estado independiente.
**Decisión:** `StatefulShellRoute.indexedStack` por rol. 4 tabs + FAB contextual.
**Consecuencias:** Cada tab mantiene su estado. Navegación profunda sin perder contexto.

## ADR-022: Autenticación solo email/password
**Contexto:** OAuth (Google/Facebook) falla en Venezuela.
**Decisión:** SOLO email/password. Sin OAuth en el MVP.
**Consecuencias:** Registro simple. Sin dependencia de terceros para auth.

## ADR-023: Onboarding con dos caminos
**Contexto:** Dueños y clientes tienen flujos de registro distintos.
**Decisión:** Onboarding pregunta "Soy cliente" o "Soy dueño". Clientes van a gym discovery. Dueños van a solicitud KYC.
**Consecuencias:** Entrenadores/nutricionistas NO se auto-registran. Ver ADR-035.

## ADR-024: KYC manual para dueños
**Contexto:** Validar que el gimnasio es real antes de activarlo.
**Decisión:** Solicitud → estado "pending" → superadmin revisa → aprueba o rechaza.
**Consecuencias:** Tabla `gym_applications`. Edge Function `approve-gym` garantiza transaccionalidad. Cooldown de 7 días tras rechazo.

## ADR-025: Planes PESAO FIT (Pluma/Hierro/Macizo)
**Contexto:** Monetización de la plataforma.
**Decisión:** Tres tiers con límites progresivos. Pluma gratis, Hierro $15-25, Macizo $40-60.
**Consecuencias:** Límites en clientes, staff, planes de membresía, plantillas de rutina, semanas por plan. Ver ADR-044.

## ADR-026: Dashboard template
**Contexto:** Todos los dashboards deben verse consistentes.
**Decisión:** Template con avatar+saludo, 3 StatCards, PrimaryCard, sección secundaria.
**Consecuencias:** 5 dashboards con la misma estructura. Datos reales donde aplica.

## ADR-027: Skeleton loaders
**Contexto:** Evitar spinners genéricos.
**Decisión:** Skeletons que replican el layout real de la pantalla.
**Consecuencias:** Percepción de carga más rápida. Sin spinners sueltos.

## ADR-028: OfflineBanner global
**Contexto:** El usuario debe saber cuando no hay conexión.
**Decisión:** `connectivityProvider` global. `OfflineBanner` se muestra automáticamente en todas las pantallas.
**Consecuencias:** Sin lógica de conectividad repetida por pantalla.

## ADR-029: Toasts semánticos
**Contexto:** Feedback de acciones sin bloquear la UI.
**Decisión:** `showPesaoToast()` con variantes success/error/warning/info. `semanticLabel` sin emoji.
**Consecuencias:** Accesibilidad. Feedback consistente.

## ADR-030: Confirm dialogs para acciones destructivas
**Contexto:** Evitar acciones accidentales.
**Decisión:** `showConfirmDialog()` con título, mensaje, confirmLabel, cancelLabel, isDestructive.
**Consecuencias:** Sin diálogos nativos de Android/iOS. Todo con estética PESAO FIT.

## ADR-031: Result<T> en todo repository
**Contexto:** Manejo de errores predecible.
**Decisión:** `Result<T>` con estados idle/loading/success/failure. Repositories NUNCA lanzan excepciones.
**Consecuencias:** La UI maneja errores con `when()`. Sin try/catch en widgets.

## ADR-032: AppException con código y mensaje
**Contexto:** Errores técnicos no deben mostrarse al usuario.
**Decisión:** `AppException` sealed con `code` (para AppStrings) y `message` (para logs). Subtipos: Network, Unauthorized, Validation, NotFound, Unknown.
**Consecuencias:** La UI mapea `code` a microcopy suave. Sentry recibe el mensaje técnico.

## ADR-033: FAB contextual por ruta
**Contexto:** El FAB debe cambiar según la pantalla visible. Actualizado en v4.
**Decisión:** Función `_fabForRoute()` en cada shell deriva icon+acción de la ruta actual. Sin `PesaoFabController` global.
**Consecuencias:** Más simple, más predecible, menos estado global. Ver ADR-045.

## ADR-034: GlobalKey estables para StatefulShellRoute
**Contexto:** GoRouter 18.x rompe con parentNavigatorKey dinámico.
**Decisión:** GlobalKey estables por tab, creadas una sola vez a nivel de módulo.
**Consecuencias:** Sin recreación de navigators. Estado de tabs se preserva.

## ADR-035: Staff creado por el dueño
**Contexto:** Entrenadores/nutricionistas no deben auto-registrarse.
**Decisión:** El dueño crea/invita staff desde su panel. Límite por tier (Pluma=1, Hierro=3, Macizo=ilimitado).
**Consecuencias:** Sin registro público de staff. `set_staff_active()` para activar/desactivar.

## ADR-036: KYC de dueños con superadmin
**Contexto:** Validar gimnasios antes de activarlos.
**Decisión:** Flujo solicitud → pending → superadmin revisa → aprueba/rechaza. Edge Function `approve-gym`.
**Consecuencias:** Sin gimnasios fantasma. Cooldown de 7 días tras rechazo.

## ADR-037: POCO + Equatable para entidades simples
**Contexto:** Freezed 4.x tiene conflictos con Dart 3.13+.
**Decisión:** Entidades con <=6 campos usan POCO + Equatable. Sin Freezed para datos simples.
**Consecuencias:** Menos codegen. Menos puntos de fallo. AuthUser es POCO.

## ADR-038: Drift cachea 15 de 25 tablas
**Contexto:** No todo necesita estar offline.
**Decisión:** Solo tablas de lectura frecuente en Drift. Pagos, chats, audit_logs NO se cachean.
**Consecuencias:** Offline útil sin inflar la base local. Pagos siempre frescos.

## ADR-039: Biometría opcional con fallback
**Contexto:** No todos los dispositivos soportan biometría.
**Decisión:** Biometría como opción. Fallback a login manual si no está disponible.
**Consecuencias:** Sin bloquear usuarios sin hardware compatible.

## ADR-040: Cloudinary cuenta 2 para comprobantes de pago
**Contexto:** Los comprobantes de pago son imágenes sensibles que el cliente sube.
**Decisión:** Cloudinary cuenta 2 (`pesao-fit-progreso`) con upload directo unsigned. `public_id` = `{payment_id}`.
**Consecuencias:** Sin consumo de Supabase Storage. Transformación de compresión al subir. El dueño ve la imagen desde `receipt_url`.

## ADR-041: Membresías del gym con saldo acumulativo
**Contexto:** Gimnasios venezolanos manejan pagos parciales y adelantados.
**Decisión:** Tabla `client_subscriptions` con `balance_usd` acumulativo. Positivo = debe, negativo = crédito a favor.
**Consecuencias:** Un solo campo maneja deuda y crédito. `approve_payment()` actualiza saldo automáticamente. `assign_plan_to_client()` reutiliza suscripciones cancelled/expired para evitar conflictos de UNIQUE constraint.

## ADR-042: Planificador semanal con plantillas reutilizables
**Contexto:** Entrenadores con 20-50 clientes no pueden asignar rutinas manualmente cada día.
**Decisión:** Separar rutinas (plantillas reutilizables) de planes de entrenamiento (asignación a días/semanas). `routines.client_id` ahora nullable.
**Consecuencias:** Una rutina se usa en múltiples días/semanas sin duplicarla. `duplicate_plan_week()` copia semana completa. `training_plan_days` con UNIQUE(week_id, day_of_week). UPSERT requiere `onConflict` explícito.

## ADR-043: Tasa BCV directa con cache local
**Contexto:** Edge Functions añaden complejidad innecesaria para el MVP.
**Decisión:** Llamada directa a dolarAPI desde la app con cache local de 4 horas. Override manual opcional por gimnasio.
**Consecuencias:** Cero costo de infraestructura. Sin cron. Sin Edge Function. Suficiente para MVP. Si crecemos a >1000 usuarios activos, migramos a Edge Function con cron. Actualiza ADR-017.

## ADR-044: Límites de planificador por tier
**Contexto:** Monetización del planificador semanal.
**Decisión:** Pluma: 5 plantillas, 2 semanas/plan, sin duplicar. Hierro: 30 plantillas, 8 semanas, duplicar OK. Macizo: ilimitado.
**Consecuencias:** Palanca de conversión natural. El entrenador que necesita >2 semanas o duplicación upgradea a Hierro.

## ADR-045: FAB contextual sin PesaoFabController
**Contexto:** El patrón anterior con `PesaoFabController` global era propenso a desincronización.
**Decisión:** Cada shell tiene una función `_fabForRoute(path, context)` que deriva el FAB de la ruta actual. Sin controlador global.
**Consecuencias:** El FAB siempre refleja la pantalla visible. Sin estado compartido entre pantallas. Más fácil de mantener.

## ADR-046: Ejecución de workout con sets pre-cargados y toggle optimista
Contexto: El cliente necesita ejecutar su rutina marcando sets, con respuesta instantánea.
Decisión: start_workout() pre-carga todos los sets en workout_exercises. El toggle de sets es optimista (actualiza UI inmediatamente, persiste en background, revierte si falla). Rest timer con anillo CustomPainter + HapticFeedback.
Consecuencias: UI responsiva sin esperar red. RestTimerSheet sin dependencias externas (vibración nativa).