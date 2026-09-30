# PESAO FIT - Documento Maestro (v3)

1. Visión
Superapp fitness multi-tenant: dueños de gimnasios, entrenadores, nutricionistas y clientes.
Adaptada a Venezuela: pagos manuales, moneda local/USD, notificaciones alternativas.
UI: español venezolano. Código: INGLES.

2. Roles
Leonel (superadmin) | Dueño | Entrenador | Nutricionista | Cliente.

3. Modelo de negocio
Pluma (gratis, 5 clientes, 1 entrenador) | Hierro ($15-25, 50 clientes, 3 entrenadores, nutrición,
chat, reportes) | Macizo ($40-60, ilimitado, sucursales, reservas, QR, IA, wearables).

4. Fases
F1 Fundación: splash, onboarding+terminos, auth email/password, registro de dueño con KYC manual,
gimnasios/entrenadores/clientes, rutinas básicas, panel Leonel.
F2 Núcleo fitness: progreso, rest timer, historial, gráficos.
F3 Nutrición: alimentos, planes semanales, macros.
F4 Monetización: pagos manuales, recordatorios, suscripciones.
F5 Comunidad: insignias, retos, rankings, feed.
F6 Avanzado: wearables, QR, reportes.

Estado actual de dashboards (todos con datos placeholder hasta conectar módulos):
- Superadmin: ✅ funcional (stats reales de gyms/solicitudes/suscripciones)
- Cliente: ✅ funcional (stats placeholder, se conecta en F2/F3)
- Dueño: ✅ funcional (clientes reales, pagos placeholder hasta F4)
- Entrenador: ✅ funcional (clientes reales, sesiones/rutinas placeholder hasta F2)
- Nutricionista: ✅ funcional (todo placeholder hasta F3)

5. Tecnologías
Flutter | Supabase (PostgreSQL/Auth/Storage/Realtime) | Cloudinary x2 (upload directo unsigned) |
OneSignal (fallback email) | Gemini API con cache | Drift (offline SQL/NoSQL) | Riverpod codegen | GoRouter |
Freezed+json_serializable | fl_chart | fuentes Manrope+Barlow Condensed embebidas | gen-l10n es_VE.

6. Sistema de Diseño y UX (RESUMEN — detalle en design-system.md)
Tema "Dark Athletic Luxe": morado #8B5CF6 = marca/acción; verde #22C55E = SOLO éxito; fondo
#0B0B10 (OLED opcional). Kit propio Pesao* (botones, cards, inputs, bottom nav, FAB contextual,
skeletons, banners, modales). Shell por rol: 4 tabs + FAB. Dashboard template y screen template
con 5 estados obligatorios. Microcopy venezolano suave. DoD de 15 puntos por pantalla.

7. Base de datos (20 tablas)
profiles, gyms, memberships, plans, subscriptions, payments, routines, exercises,
routine_exercises, workouts, workout_exercises, body_measurements, progress_photos, notifications,
chats, messages, gym_settings, audit_logs, exchange_rates, gym_applications.
RLS con is_gym_member/get_gym_role. Vistas: active_members, pending_payments.
Triggers: update_updated_at_column, on_auth_user_created, handle_new_user, log_payment_change.

Tabla gym_settings: marca blanca + tasa BCV por gimnasio (ADR-017/030).
Tabla audit_logs: auditoría de pagos y acciones críticas (disputas, compliance).
Tabla exchange_rates: histórico de tasas BCV por gimnasio (ADR-017).
Tabla gym_applications: solicitudes de registro de dueños con KYC manual (ADR-036).

8. Pantallas (45)
8 públicas | 5 superadmin | 6 dueño | 7 entrenador | 6 nutricionista | 8 cliente | 5 modales
(biometric, confirmDialog, imageViewer, paymentUpload, restTimer).
TODA pantalla se construye con screen template + DoD de design-system.md.

9. Integraciones
Tasa BCV (auto API o manual por gimnasio, tabla exchange_rates) | n8n opcional | Radioweb |
Clipboard para datos de pago | Sentry (crash reporting); sin analytics de producto en el MVP.

10. Métricas
50 gimnasios/6 meses | 1.000 clientes/1 año | conversión Pluma→Hierro 30%.

11. Flujo de registro de dueños (KYC manual — ADR-036)
1. Dueño se registra (email/password) → cuenta creada, sin rol.
2. Onboarding → elige "Soy dueño" → "Crear mi gimnasio".
3. Formulario de solicitud: datos personales (teléfono) + datos del gimnasio
   (nombre, RIF opcional, dirección, estado/ciudad, teléfono, Instagram, foto, GPS opcional).
4. Envía solicitud → estado "pending" en gym_applications.
5. Pantalla de espera: "Tu solicitud está en revisión, te contactaremos en 24-48h".
6. Superadmin (Leonel) revisa en panel: ve datos, llama/visita, aprueba o rechaza.
7. Al aprobar: se crea gym + membership owner + subscription Pluma + notificación al dueño.
8. Al rechazar: notificación con motivo; cooldown de 7 días para reintentar.

12. Flujo de registro de clientes
1. Cliente se registra (email/password) → cuenta creada, sin rol.
2. Onboarding → elige "Soy cliente" → busca su gimnasio (gym discovery ADR-013).
3. Solicita membresía como client → el dueño aprueba o el sistema auto-aprueba (según config).
4. Al aprobar: se crea membership client → cliente accede a su dashboard.

13. Flujo de alta de staff (ADR-035)
Entrenadores y nutricionistas NO se auto-registran. El dueño los crea/invita desde su panel
de gestión de staff, respetando el límite del plan activo (Pluma=1, Hierro=3, Macizo=ilimitado).

14. REGLA DE ORO
Ninguna pantalla se marca como terminada sin el checklist DoD completo (design-system.md §14).
