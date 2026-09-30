# PESAO FIT - Arquitectura Técnica (v3)

1. Flujo
[UI Flutter/PesaoKit] -> [Presentation Providers @riverpod] -> [Domain Usecases] ->
[Data Repositories] -> [Supabase / Cloudinary] + [Drift Cache offline]

2. Backend (Supabase)
PostgreSQL 20 tablas | Auth email/password | Storage (temporales/exportaciones) |
Realtime (chat/notifs) | Edge Functions SOLO lógica de negocio: verify-payment, send-reminder,
generate-nutrition-plan, approve-gym. NUNCA para subir fotos.

3. Cloudinary
Cuenta 1 pesao-fit-perfiles (avatars/gyms/exercises) | Cuenta 2 pesao-fit-progreso (progress/
receipts). Preset unsigned pesao_fit_preset. Transformaciones: w_200,h_200,c_fill,q_auto,f_auto
(avatares); w_400,q_auto,f_auto (cards); comprimir siempre.

4. Frontend
Clean Architecture + Feature-First | Riverpod codegen | GoRouter con StatefulShellRoute
.indexedStack por rol (4 tabs + FAB contextual) | UI kit Pesao* (design-system.md) |
l10n gen-l10n arb es_VE | fuentes embebidas en assets | Drift offline (rutinas 7d, planes 3d,
cola de sync diferida) | Result<T> (idle/loading/success/failure) en todo repository.

5. Estructura de carpetas
lib/
  core/
    theme/            # app_colors, app_typography, app_dimens, app_shadows, app_theme, app_icons
    l10n/             # app_es.arb + generado (AppStrings)
    router/           # app_router, route_names, shells/ (client|trainer|owner|nutritionist|admin)
    providers/        # connectivity_provider, theme_mode_provider (OLED), white_label_provider,
                      # auth_provider (AuthNotifier), database_provider, supabase_provider
    constants/ exceptions/ utils/
    database/         # app_database.dart + tables/ (15 tablas Drift)
  features/
    auth|home|gym|clients|routines|nutrition|payments|admin/
      domain/ (entities, repositories)
      data/ (models, datasources, repositories)
      presentation/ (screens/, widgets/, providers/)
  shared/
    widgets/          # kit Pesao* (26 componentes)
    components/       # exercise_card, set_tracker, rest_timer_sheet, meal_card, macro_tracker,
                      # payment_card, progress_photo_card

6. Navegación
Stack público: splash, onboarding, terms, login, register, forgotPassword, gymDiscovery, gymDetail.
Shells autenticados por rol (tabs+FAB según design-system.md §9). Modales: biometric,
confirmDialog, imageViewer, paymentUpload, restTimerSheet.
Onboarding tiene dos caminos: "Soy cliente" (gym discovery) y "Soy dueño" (solicitud KYC).

7. Offline-first
connectivityProvider global -> OfflineBanner automático. Lecturas: cache Drift primero, red después.
Escrituras sin red: cola Drift + worker de reintento; al sincronizar OK -> badge/toast success.
Web: Soporte nativo vía Drift/Wasm, compartiendo el 100% del código de persistencia con Mobile.
Drift cachea 15 de 20 tablas (ADR-038): solo las que se leen frecuentemente sin internet.

8. Marca blanca
white_label_provider: el gimnasio puede cambiar primary (+glow) y logo; success/warning/error,
tipografías y radios quedan FIJOS (no se negocian). Datos en tabla gym_settings.

9. Autenticación
AuthNotifier (ChangeNotifier singleton) envuelve AuthRepository y escucha el stream de Supabase
Auth en tiempo real. GoRouter lo usa como refreshListenable para re-evaluar redirects en
login/logout. El registro público solo ofrece dos caminos: "Soy dueño" o "Soy cliente" (ADR-035).
Entrenadores/nutricionistas son creados por el dueño desde su panel.
AuthUser es una clase POCO + Equatable (ADR-037), no Freezed.

10. Flujo KYC de dueños (ADR-036)
Registro → Onboarding "Soy dueño" → Formulario de solicitud (gym_applications) →
Estado "pending" → Superadmin revisa (llamada/visita) → Aprobar (crea gym+membership+subscription)
o Rechazar (notificación + cooldown 7 días). Edge Function approve-gym garantiza transaccionalidad.

11. Integraciones y escalabilidad
Tasa BCV Edge Function -> exchange_rates | n8n opcional | Radioweb | Clipboard.
Una cuenta Supabase + RLS multi-tenant; si se excede, plan Pro; sharding futuro por región.

PESAO FIT - Errores Conocidos y Limitaciones (v3)
1 Firebase inestable en VE -> Supabase. |
2 Stripe/MercadoPago no -> pagos manuales. |
3 FCM falla -> OneSignal + email. |
4 OpenAI bloquea VE -> Gemini o proxy. |
5 Supabase free 1GB -> Cloudinary + compresión. |
6 Tasa fluctúa -> manual o API paralela. |
7 Límite Pluma -> aviso upgrade a Hierro. |
8 Vencidos -> suspensión a 7 días con aviso. |
9 Sin videos propios -> biblioteca base + YouTube/Vimeo/Cloudinary. |
10 OAuth falla -> SOLO email/password. |
11 Offline en registro -> cola Drift. |
12 Biometría no soportada -> fallback login manual. |
13 Límites Cloudinary -> comprimir y transformaciones optimizadas. |
14 Límite Edge Functions -> NO subir fotos por ahí.
15 BackdropFilter/shaders tumban gama baja -> PROHIBIDOS en el kit; glow con BoxShadow barato.
16 Google Fonts por red falla offline -> fuentes embebidas en assets/fonts.
17 dynamicColor (Material You) pisa la marca blanca -> deshabilitado.
18 TalkBack lee los emojis del microcopy -> semanticsLabel sin emoji siempre.
19 fl_chart con muchos puntos lagea -> downsampling a <=100 puntos por serie.
20 Freezed 4.x + freezed_annotation 3.x conflicto con Dart 3.13+ -> AuthUser usa POCO+Equatable (ADR-037).
21 GoRouter 18.x StatefulShellRoute rompe con parentNavigatorKey dinámico -> GlobalKey estables (ADR-034).
