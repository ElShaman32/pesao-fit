# PESAO FIT - Registro de Decisiones (ADR) (v3)

### ADR-001 Flutter | ADR-002 Supabase | ADR-003 multi-tenant RLS | ADR-004 pagos manuales |
### ADR-005 planes Pluma/Hierro/Macizo | ADR-006 email/password | ADR-007 OneSignal+email |
### ADR-008 Cloudinary x2 upload directo | ADR-009 UI español VE, código inglés |
### ADR-010 Dark Athletic Luxe | ADR-011 biometría solo clientes/staff | ADR-012 offline-first Drift |
### ADR-013 gym discovery | ADR-014 sesión Supabase nativa | ADR-015 Sentry para crash reporting; sin analytics de producto en el MVP |
### ADR-016 Edge Functions solo negocio | ADR-017 tasa BCV por gimnasio | ADR-018 Clean+Feature-First |

### ADR-019: Cambiar "Isar" por "Drift".
Motivo: Isar fue abandonado y no soporta Dart 3.7+ ni Web. Drift ofrece soporte Web nativo, transacciones ACID robustas para la cola de sync diferida y es el estándar actual de la industria Flutter.

### ADR-022 Semántica de color: morado=marca/acción, verde=SOLO éxito, ámbar=alerta, rojo=error.
Motivo: lenguaje visual consistente; el verde siempre significa "lo lograste".

### ADR-023 Fuente única UI: design-system.md + tokens en core/theme. Motivo: 45 pantallas sin retrabajo.

### ADR-024 Shell: StatefulShellRoute.indexedStack, 4 tabs + FAB contextual por rol. Motivo: estado por tab conservado y acción primaria siempre a mano.

### ADR-025 Tipografía: Manrope + Barlow Condensed embebidas en assets, tabularFigures en números.
Motivo: funciona offline y los números no "bailan".

### ADR-026 Kit propio Pesao*: prohibido Material crudo para button/card/input; prohibido
BackdropFilter/shaders/dynamicColor. Motivo: consistencia + gama baja.

### ADR-027 Textos: gen-l10n con arb único es_VE (AppStrings). Motivo: microcopy centralizado y
preparado para i18n futura.

### ADR-028 Carga percibida: skeletons shimmer en vez de spinners. Motivo: redes 3G; sensación de velocidad.

### ADR-029 Modo OLED opcional (#000000). Motivo: batería en gama media.

### ADR-030 Marca blanca limitada: gimnasio cambia primary+logo; semánticos y tipografía fijos.
Motivo: personalización sin romper accesibilidad.

### ADR-031 Gráficos: fl_chart; anillos (MacroRing, RestTimer) con CustomPainter. Motivo: ligero y control total.

### ADR-032 Definition of Done: ninguna pantalla se entrega sin el checklist de 15 puntos.
Motivo: eliminar correcciones posteriores.

### ADR-033 Base de datos local: migración de Isar a Drift. Motivo: Isar está abandonado, genera conflictos de dependencias con Dart 3.7+ (freezed/analyzer) y carece de soporte nativo para Web. Drift garantiza soporte Web/Mobile unificado, type-safety y transacciones ACID robustas para la cola de sincronización diferida.

### ADR-034 GoRouter 18.x: StatefulShellRoute sin parentNavigatorKey, con GlobalKey estables fuera de la función.
Motivo: En GoRouter 18.x, `StatefulShellRoute.indexedStack` no debe usar `parentNavigatorKey` apuntando a una key creada dentro del builder o de la función que construye el shell, porque eso rompe el registro de rutas de los branches (error "no routes for location"). La solución correcta es declarar `GlobalKey<NavigatorState>` estables como variables de nivel de archivo (fuera de la función `buildXxxShell()`), y usarlas directamente en cada `StatefulShellBranch.navigatorKey`. No se necesita `parentNavigatorKey` en el shell. Esto garantiza que las claves persistan durante toda la vida de la app y GoRouter pueda resolver correctamente las rutas de cada tab.

### ADR-035 Alta de staff controlada por el dueño.
Motivo: Los planes limitan el número de entrenadores por gimnasio (Pluma=1, Hierro=3, Macizo=ilimitado), lo cual es la palanca de monetización principal (conversión Pluma→Hierro 30%). La seguridad multi-tenant (ADR-003) exige que el dueño valide quién accede a datos de sus clientes. El contexto venezolano requiere control manual del equipo. Por tanto, entrenadores y nutricionistas NO se auto-registran desde el registro público; son creados/invitados por el dueño desde su panel de gestión de staff, respetando el límite del plan activo. El registro público solo ofrece dos caminos: "Soy dueño" o "Soy cliente".

### ADR-036 Aprobación manual de gimnasios (KYC).
Motivo: Contexto venezolano sin servicios de verificación automatizada confiables; prevención de spam y gimnasios falsos; oportunidad de venta en el contacto inicial (llamada/visita); coherencia con pagos manuales (ADR-004). Los dueños envían una solicitud con datos personales y del gimnasio (tabla gym_applications); el superadmin (Leonel) verifica por llamada/visita y aprueba o rechaza. Solo al aprobarse se crea el gym, la membership de owner y la subscription en plan Pluma. Incluye medidas anti-spam: 1 solicitud activa por email, 1 por teléfono, cooldown de 7 días tras rechazo.

### ADR-037 AuthUser como clase POCO + Equatable (sin Freezed).
Motivo: La entidad AuthUser tiene solo 6 campos primitivos y no necesita las capacidades avanzadas de Freezed (union types, copyWith complejo). Freezed 4.x + freezed_annotation 3.x generaba conflictos con el analyzer de Dart 3.13+ que impedían la compilación. Una clase Dart pura con Equatable proporciona la misma API (copyWith, ==, toJson, fromJson) sin dependencias de codegen, eliminando el riesgo de errores de tooling. El resto del proyecto sigue usando Freezed donde aporta valor real (modelos complejos).

### ADR-038 Drift cachea 15 de 20 tablas (no todas).
Motivo: Drift es caché offline, no réplica completa. Solo las tablas que se LEEN frecuentemente sin internet necesitan estar en Drift. Tablas en Drift (15): profiles, gyms, memberships, plans, subscriptions, exercises, routines, routine_exercises, workouts, workout_exercises, body_measurements, progress_photos, notifications, exchange_rates, gym_settings. Tablas NO en Drift (5): payments (cola de sync), chats (Realtime), messages (Realtime), audit_logs (solo lectura admin), gym_applications (solo red).

### ADR-039: Superadmin vía profiles.is_superadmin + función SECURITY DEFINER.
Motivo: Referenciar auth.users directamente en políticas RLS causa "permission denied" porque el rol authenticated no tiene acceso a esa tabla. La solución estándar es un flag en profiles + función SECURITY DEFINER que puede leer sin permisos directos.
