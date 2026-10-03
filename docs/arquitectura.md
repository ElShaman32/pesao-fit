## PESAO FIT - Arquitectura Técnica (v4)

> Última actualización: F2-A/B/C + F4-A/B/C + Planificador semanal.

## Flujo

[UI Flutter/PesaoKit] -> [Presentation Providers @riverpod] -> [Domain Usecases] ->
[Data Repositories] -> [Supabase / Cloudinary] + [Drift Cache offline]

## Backend (Supabase)

PostgreSQL 25 tablas | Auth email/password | Storage (temporales/exportaciones) |
Realtime (chat/notifs) | Edge Functions SOLO lógica de negocio: verify-payment, send-reminder,
generate-nutrition-plan, approve-gym, sync-exchange-rate. NUNCA para subir fotos.

## Cloudinary (x2)

- **Cuenta 1** `pesao-fit-perfiles`: avatars, gyms, exercises.
- **Cuenta 2** `pesao-fit-progreso`: progress, receipts (comprobantes de pago).
- Preset unsigned `pesao_fit_preset` en ambas cuentas.
- Transformaciones:
  - Avatares: `w_200,h_200,c_fill,q_auto,f_auto`
  - Cards: `w_400,q_auto,f_auto`
  - Comprobantes: `w_1000,h_1400,c_limit,q_auto,f_auto`
- Siempre comprimir.

## Tasa BCV (ADR-017 actualizado)

- **Automática**: 
  La app verifica si tiene una tasa cacheada de hace < 4 horas. Si sí, usa la cache (0 llamadas). Si no, llama a dolarAPI UNA vez y cachea (`https://dolarapi.com/v1/ven/ve/average`), inserta histórico
  en `exchange_rates` y actualiza `gym_settings.bcv_rate`.
- **Override manual**: columna `gym_settings.bcv_rate_override` (nullable).
  Si está seteada, se usa en lugar de la tasa automática.
  El dueño la configura desde "Configuración del gym" (pendiente F7).
- **Registro del pago**: la columna `payments.rate_used` guarda la tasa
  aplicada al momento del pago (auto o manual) para auditoría.

## Frontend

Clean Architecture + Feature-First | Riverpod codegen | GoRouter con
StatefulShellRoute.indexedStack por rol (4 tabs + FAB contextual) |
UI kit Pesao* (design-system.md) | l10n gen-l10n arb es_VE | fuentes embebidas
en assets | Drift offline (rutinas 7d, planes 3d, cola de sync diferida) |
Result<T> (idle/loading/success/failure) en todo repository.

## Estructura de carpetas

```
lib/
  core/
    theme/            # app_colors, app_typography, app_dimens, app_shadows, app_theme, app_icons
    l10n/             # app_es_VE.arb + generado (AppStrings)
    router/           # app_router, route_names, shells/ (client|trainer|owner|nutritionist|admin)
    providers/        # connectivity_provider, theme_mode_provider (OLED), white_label_provider,
                      # auth_provider (AuthNotifier), database_provider, supabase_provider,
                      # cloudinary_provider
    constants/ exceptions/ utils/ services/
    database/         # app_database.dart + tables/ (15 tablas Drift)
  features/
    auth|home|gym|clients|staff|routines|nutrition|payments|memberships|admin/
      domain/ (entities, repositories)
      data/ (models, datasources, repositories)
      presentation/ (screens/, widgets/, providers/)
  shared/
    widgets/          # kit Pesao* (26+ componentes)
    components/       # exercise_card, set_tracker, rest_timer_sheet, meal_card, macro_tracker,
                      # payment_card, progress_photo_card, subscription_card, week_pills
```

## Navegación

**Stack público:** splash, onboarding, terms, login, register, forgotPassword,
gymDiscovery, gymDetail, ownerApplication, applicationPending.

**Shells autenticados por rol** (tabs+FAB según design-system.md §9):
- Cliente: Inicio / Rutina / Nutrición / Perfil
- Entrenador: Inicio / Clientes / Rutinas / Perfil
- Dueño: Inicio / Clientes / Pagos / Perfil
- Nutricionista: Inicio / Clientes / Planes / Perfil
- Superadmin: Inicio / Gimnasios / Pagos / Perfil

**Modales/Sheets:** biometric, confirmDialog, imageViewer, paymentUpload,
restTimer, exercisePicker, dayAssignment, assignPlan, clientSelector, imagePickerField.

**Onboarding tiene dos caminos:** "Soy cliente" (gym discovery) y "Soy dueño"
(solicitud KYC). Entrenadores/nutricionistas son creados por el dueño (ADR-035).

## FAB contextual por ruta

El FAB del shell deriva su acción de la ruta actual:
- Dashboard del dueño → Agregar cliente
- Pantalla Mi equipo → Agregar staff
- Pantalla Clientes → Agregar cliente
- Pantalla Pagos → (futuro: registrar pago manual)
- Pantalla Planes del gym → Crear plan
- Pantalla Rutinas (entrenador) → Nuevo plan de entrenamiento
- Pantalla Plantillas de rutina → Nueva rutina
- Pantalla Ejercicios → Crear ejercicio personalizado
- Dashboard del cliente → Subir comprobante de pago
Tab Rutina del cliente → Comenzar/retomar workout del día

## Offline-first

`connectivityProvider` global -> `OfflineBanner` automático.
Lecturas: cache Drift primero, red después.
Escrituras sin red: cola Drift + worker de reintento; al sincronizar OK ->
badge/toast success.

Web: Soporte nativo vía Drift/Wasm, compartiendo el 100% del código de
persistencia con Mobile.

Drift cachea 15 de 25 tablas (ADR-038): solo las que se leen frecuentemente
sin internet.

**Tablas en Drift (15):** profiles, gyms, memberships, plans, subscriptions,
exercises, routines, routine_exercises, workouts, workout_exercises,
body_measurements, progress_photos, notifications, exchange_rates, gym_settings.

**Tablas NO en Drift (10):** payments (cola de sync), chats (Realtime),
messages (Realtime), audit_logs (solo lectura admin), gym_applications
(solo red), gym_membership_plans, client_subscriptions, training_plans,
training_plan_weeks, training_plan_days.

## Marca blanca

`white_label_provider`: el gimnasio puede cambiar primary (+glow) y logo;
success/warning/error, tipografías y radios quedan FIJOS (no se negocian).
Datos en tabla `gym_settings`.

## Autenticación

AuthNotifier (ChangeNotifier singleton) envuelve AuthRepository y escucha el
stream de Supabase Auth en tiempo real. GoRouter lo usa como refreshListenable
para re-evaluar redirects en login/logout.

El registro público solo ofrece dos caminos: "Soy dueño" o "Soy cliente"
(ADR-035). Entrenadores/nutricionistas son creados por el dueño desde su panel.

AuthUser es una clase POCO + Equatable (ADR-037), no Freezed.

## Flujo KYC de dueños (ADR-036)

Registro → Onboarding "Soy dueño" → Formulario de solicitud (gym_applications) →
Estado "pending" → Superadmin revisa (llamada/visita) → Aprobar
(crea gym+membership+subscription) o Rechazar (notificación + cooldown 7 días).
Edge Function `approve-gym` garantiza transaccionalidad.

## Flujo de pagos manuales (F4 completo)

1. Cliente abre sheet de pago → ve su plan, saldo pendiente, tasa BCV vigente.
2. Elige monto (puede pagar parcial o adelantado).
3. Toma foto del comprobante → sube a Cloudinary cuenta 2 (preset unsigned).
4. Inserta pago en Supabase con `subscription_id` y `payment_kind = 'client_membership'`.
5. Dueño ve comprobante pendiente en tab Pagos.
6. Dueño aprueba → `approve_payment()` reduce saldo, extiende vencimiento, reactiva cliente.
7. Dueño rechaza → `reject_payment()` con motivo → cliente ve el motivo.
8. Auditoría: `log_payment_change` inserta en `audit_logs`.

## Flujo de membresías del gym (F4-C)

1. Dueño crea planes de membresía (nombre, precio USD, duración, flags).
2. Límite por tier: Pluma=1, Hierro=2, Macizo=ilimitado.
3. Dueño asigna plan a cliente → `assign_plan_to_client()`.
4. Se crea `client_subscriptions` con saldo inicial = precio del plan.
5. Cliente ve su plan en dashboard (SubscriptionCard) con saldo y vencimiento.
6. Al pagar y ser aprobado, saldo se reduce automáticamente.
7. Pagos parciales dejan saldo positivo (debe). Pagos adelantados dejan saldo
   negativo (crédito a favor).

## Flujo de planificador semanal (F2-C)

1. Entrenador crea rutinas (plantillas reutilizables) con ejercicios, series,
   reps, peso, descanso. Biblioteca base de 33 ejercicios globales +
   ejercicios personalizados por gym.
2. Entrenador crea plan de entrenamiento para un cliente.
3. Agrega semanas al plan (límite por tier: Pluma=2, Hierro=8, Macizo=ilimitado).
4. En cada semana, asigna rutinas a días (L-D), marca descansos, agrega notas.
5. Puede duplicar semanas (feature de Hierro/Macizo).
6. Cliente ve su plan activo con la semana actual y el día de hoy resaltado.
7. Dashboard del cliente muestra "Próximo entreno" real desde el plan.

## Flujo de ejecución de workout (F2-D)

1. Cliente ve su plan en tab Rutina → día de hoy tiene botón "Comenzar".
2. Toca "Comenzar" → start_workout() crea workout y pre-carga sets desde la rutina.
3. Navega a WorkoutExecutionScreen → marca sets completados (toggle optimista).
4. Después de cada set con descanso → RestTimerSheet (anillo countdown, +1min, vibración).
5. "Terminar entreno" → finish_workout() → toast de éxito.
6. Si sale a mitad, el workout queda activo y puede retomarse con get_active_workout().

## Integraciones y escalabilidad

- Tasa BCV: dolarAPI vía Edge Function `sync-exchange-rate` + override manual
  opcional por gimnasio.
- n8n opcional para automatizaciones.
- Radioweb para notificaciones.
- Clipboard para datos de pago.
- Sentry para crash reporting.
- Sin analytics de producto en el MVP.

Una cuenta Supabase + RLS multi-tenant; si se excede, plan Pro; sharding
futuro por región.

---

## PESAO FIT - Errores Conocidos y Limitaciones (v4)

1. Firebase inestable en VE -> Supabase.
2. Stripe/MercadoPago no -> pagos manuales.
3. FCM falla -> OneSignal + email.
4. OpenAI bloquea VE -> Gemini o proxy.
5. Supabase free 1GB -> Cloudinary + compresión.
6. Tasa fluctúa -> dolarAPI + override manual opcional por gimnasio.
7. Límite Pluma -> aviso upgrade a Hierro.
8. Vencidos -> suspensión a 7 días con aviso.
9. Sin videos propios -> biblioteca base + YouTube/Vimeo/Cloudinary.
10. OAuth falla -> SOLO email/password.
11. Offline en registro -> cola Drift.
12. Biometría no soportada -> fallback login manual.
13. Límites Cloudinary -> comprimir y transformaciones optimizadas.
14. Límite Edge Functions -> NO subir fotos por ahí.
15. BackdropFilter/shaders tumban gama baja -> PROHIBIDOS en el kit; glow con
    BoxShadow barato.
16. Google Fonts por red falla offline -> fuentes embebidas en assets/fonts.
17. dynamicColor (Material You) pisa la marca blanca -> deshabilitado.
18. TalkBack lee los emojis del microcopy -> semanticsLabel sin emoji siempre.
19. fl_chart con muchos puntos lagea -> downsampling a <=100 puntos por serie.
20. Freezed 4.x + freezed_annotation 3.x conflicto con Dart 3.13+ -> AuthUser
    usa POCO+Equatable (ADR-037).
21. GoRouter 18.x StatefulShellRoute rompe con parentNavigatorKey dinámico ->
    GlobalKey estables (ADR-034).
22. `upsert()` de Supabase usa PK por defecto; para UPSERT por otras columnas
    se requiere `onConflict: 'col1,col2'` explícito.
```
