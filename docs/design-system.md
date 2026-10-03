# PESAO FIT - Design System "Dark Athletic Luxe" (Fuente Única de Verdad UI)

Regla de oro: NINGUNA pantalla se entrega si no cumple este documento al 100%.
Si hay conflicto entre documentos: este documento gana en TODO lo visual.

## 1. Principios
1. Dark Athletic Luxe: oscuro premium, deportivo, sin ruido visual.
2. Glanceable: la info clave se lee en 1 segundo (números grandes, labels pequeños).
3. Offline visible: la app SIEMPRE avisa su estado de conexión sin asustar.
4. Tono venezolano cercano: microcopy suave, de tú, con alma (máx. 1 emoji por mensaje).
5. Ligero en gama baja: cero BackdropFilter, cero shaders, cero blurs pesados.
6. Accesible: WCAG AA, targets 48x48, texto escalable 200%, patrón + color.

## 2. Tokens de Color (core/theme/app_colors.dart)
| Token | Valor | Uso |
|---|---|---|
| background | #0B0B10 | Fondo app (OLED opcional: #000000) |
| surface | #16161D | Cards, bottom sheets |
| surfaceHigh | #1E1E28 | Inputs, tiles elevados |
| outline | rgba(139,92,246,0.15) | Bordes de cards |
| primary | #8B5CF6 | MARCA y ACCIÓN: FAB, tab activo, pills, anillos, glows |
| primaryText | #A78BFA | Morado en TEXTO pequeño sobre oscuro (AA) |
| onPrimary | #FFFFFF | Texto/ícono sobre primary |
| success | #22C55E | SOLO éxito: racha, pago verificado, set completado, sync OK |
| successText | #4ADE80 | Verde en texto pequeño |
| onSuccess | #0B0B10 | Texto sobre success |
| warning | #F59E0B | Alertas: pago por vencer, señal débil, macro grasas |
| warningText | #FBBF24 | Ámbar en texto pequeño |
| error | #EF4444 | Errores y acciones destructivas |
| errorText | #F87171 | Rojo en texto pequeño |
| textPrimary | #F4F4F5 | Texto principal |
| textSecondary | #A1A1AA | Texto secundario |
| textDisabled | #52525B | Deshabilitados |
| macroProtein / macroCarbs / macroFats | #8B5CF6 / #22C55E / #F59E0B | Anillo de macros |

SEMÁNTICA INNEGOCIABLE: el verde NUNCA es acción genérica; siempre significa "lo lograste".
Pares de contraste aprobados: textPrimary|textSecondary|primaryText|successText|errorText sobre
background/surface; onPrimary sobre primary; onSuccess sobre success.

## 3. Tipografía (assets/fonts/ embebidas, NO Google Fonts por red)
Manrope (UI) + Barlow Condensed (display). Números SIEMPRE con FontFeature.tabularFigures().
| Estilo | Fuente | Peso | Tamaño | Uso |
|---|---|---|---|---|
| display | Barlow Condensed | 700 | 32 | Títulos de pantalla, héroes |
| headline | Manrope | 800 | 24 | Encabezados de dashboard |
| title | Manrope | 700 | 18 | AppBar, títulos de card |
| body | Manrope | 500 | 14 | Texto general |
| bodySmall | Manrope | 500 | 12 | Secundarios |
| label | Manrope | 700 | 12 | Botones, badges |
| overline | Manrope | 700 | 10 | Mayúsculas, tracking 1.5 |
| numberL / numberM | Manrope | 800 | 28 / 20 | kcal, kg, repes (tabular) |

## 4. Espaciado, radios y alturas
Grid 4pt: xs4 s8 m12 l16 xl24 xxl32 xxxl48. Padding horizontal de pantalla: 16.
Radios: pill 999 | card 16 | button 12 | input 12 | sheet(top) 24 | avatar circular.
Alturas: button 48 | input 52 | appbar 56 | bottomNav 64 | FAB 56 | tile 56-64.
Touch target mínimo 48x48. Above the fold: máximo 3 cards antes del scroll.

## 5. Elevación, bordes y glow
Sin sombras negras pesadas. Profundidad = borde outline + superficie más clara.
Glow primario: BoxShadow color primary al 20%, blur 24, spread 0 (solo FAB, card primaria, anillos).
PROHIBIDO: BackdropFilter, ImageFilter.blur, shaders, dynamicColor (Material You).

## 6. Íconos y motion
Material Icons (variante rounded cuando exista): 16 / 20 / 24 / 32. Nav activo 24, inactivo 24 regular.
Motion: fast 150ms easeOut | medium 250ms easeInOut | sheet 300ms easeOutCubic | hero 350ms.

## 7. Catálogo de componentes (shared/widgets/ = kit Pesao*)
PesaoButton (primary/secondary/ghost/danger; estados enabled/disabled/loading-shimmer; h48; r12;
icon opcional), PesaoIconButton, PesaoCard (superficie+borde; tint gradiente opcional; glow opcional),
PesaoStatCard (ícono+label+numberL tabular+sub), PesaoInput (label, helper, error suave, h52, prefijo),
PesaoSearchBar, PesaoAppBar (transparente, sin elevación, acciones), PesaoBottomNav (4 tabs + slot
central FAB via Stack; activo=primaryText+dot), PesaoFAB (contextual por rol, h56, primary, glow),
PesaoShell (Scaffold base: appbar slot + banner slot + body + bottomNav + FAB), OfflineBanner (pill
morada flotante superior: "Modo sin conexión — tus datos se sincronizan solos 📶"), PesaoBadge
(success/warning/error/brand con ícono+texto), PesaoAvatar (Cloudinary w_200,h_200,c_fill,q_auto,
f_auto; ring opcional), PesaoChip/Pill, WeekPills (selector L-D; hoy=outline, seleccionado=primary
fill, día cumplido=dot success), MacroRing (CustomPainter SweepGradient, kcal numberL al centro),
PesaoProgress, SkeletonLoader (shimmer morado, replica layout real), EmptyState (ícono+microcopy+
CTA), ErrorState (microcopy suave + PesaoButton "Reintentar"), PesaoToast (borde semántico),
ConfirmDialog, PesaoBottomSheet (r24 top), SectionHeader (título + "Ver todo"), PesaoListTile,
PesaoTabs, ChartCard (fl_chart línea, relleno gradiente primary 20%).
| `PesaoBadge` | `PesaoBadgeVariant` | Etiqueta de estado semántica |
| `PesaoTabs` | — | Tabs internos para sub-vistas |
| `PesaoChip` | — | Chip de filtro seleccionable |
| `PesaoSkeleton` | — | Placeholder de carga con forma |
| `PesaoProgressBar` | — | Barra de progreso con label |
| `PesaoEmptyState` | icon, title, body, cta | Estado vacío con CTA |
| `PesaoErrorState` | title, body, onRetry | Estado de error con reintento |
| `PesaoBottomSheet` | title, child | Sheet modal estándar |
| `PesaoDropdown` | label, options, selected | Selector desplegable |
| `PesaoSegmentedControl` | options, selected | Control segmentado |

### Componentes de negocio (features)

Estos NO van en `shared/widgets/`. Viven en su feature correspondiente.

| Componente | Feature | Uso |
|---|---|---|
| `SubscriptionCard` | `memberships/` | Card de suscripción del cliente: plan, saldo, vencimiento, CTA pagar |
| `PaymentStatusBadge` | `payments/` | Badge de estado de pago (pending/verified/rejected) |
| `PaymentListTile` | `payments/` | Tile de pago en lista del dueño |
| `MuscleGroupChip` | `routines/` | Chip de grupo muscular (pecho, espalda, piernas...) |
| `ExerciseListTile` | `routines/` | Tile de ejercicio en listas con badge global/personalizado |
| `RoutineExerciseEditor` | `routines/` | Editor inline de ejercicio dentro de rutina (series/reps/peso/descanso/notas) |
| `ExercisePickerSheet` | `routines/` | Bottom sheet para elegir ejercicios con filtro por grupo muscular y búsqueda |
| `DayAssignmentSheet` | `routines/` | Bottom sheet para asignar rutina/descanso a un día del planificador |
| `PlanCard` | `routines/` | Card de plan de entrenamiento en lista del entrenador |
| `DayCard` | `routines/` | Card de día en el editor semanal del planificador |
| `AssignPlanSheet` | `memberships/` | Bottom sheet para asignar plan de membresía a un cliente |
| `ImagePickerField` | `shared/widgets/` | Campo de selección de imagen (cámara/galería) con preview |
| `UploadPaymentSheet` | `payments/` | Sheet completo de subida de comprobante de pago |
| `ClientSelector` | `shared/widgets/` | Bottom sheet para seleccionar un cliente del gym |

## 8. Componentes fitness (shared/components/)
ExerciseCard, SetTracker (fila kg/reps/check; check completo=success), RestTimerSheet (bottom sheet
con anillo primary countdown, botón +1min, vibración al fin), MealCard, MacroTracker, PaymentCard
(estados: pendiente=warning, verificado=success, rechazado=error), ProgressPhotoCard, StreakBadge.

## 9. Shell y navegación por rol (GoRouter StatefulShellRoute.indexedStack)
| Rol | Tab1 | Tab2 | Tab3 | Tab4 | FAB contextual |
|---|---|---|---|---|---|
| cliente | Inicio | Rutina | Nutrición | Perfil | Registrar ejercicio |
| entrenador | Inicio | Clientes | Rutinas | Perfil | Nueva rutina |
| dueño | Inicio | Clientes | Pagos | Perfil | Agregar cliente |
| nutricionista | Inicio | Clientes | Planes | Perfil | Nuevo plan |
| superadmin | Inicio | Gimnasios | Pagos | Perfil | Agregar gimnasio |
El FAB es UNO por shell, pero su acción se adapta a la pantalla visible dentro de ese shell. Tabs conservan estado (indexedStack).

### FAB contextual por ruta (v4)

El FAB se deriva de la ruta actual en cada shell mediante `_fabForRoute()`.
No se usa `PesaoFabController` global (ADR-045).

**Cliente:**

| Ruta | Icono | Acción |
|---|---|---|
| `/client/home` | `upload_file` | Abre sheet de subida de pago |
| `/client/routine` | `add` | Comenzar/retomar workout del día |
| `/client/nutrition` | `add` | Futuro: registrar comida (F3) |
| `/client/profile` | `add` | Sin acción |

**Entrenador:**

| Ruta | Icono | Acción |
|---|---|---|
| `/trainer/routines` | `add` | Nuevo plan de entrenamiento |
| `/trainer/routines/plan-create` | `add` | Sin acción (form tiene botón) |
| `/trainer/routines/plan/:planId` | `add` | Sin acción |
| `/trainer/routines/templates` | `add` | Nueva rutina (plantilla) |
| `/trainer/routines/templates/create` | `add` | Sin acción |
| `/trainer/routines/templates/:routineId` | `add` | Sin acción |
| `/trainer/exercises` | `fitness_center` | Crear ejercicio personalizado |
| `/trainer/exercises/create` | `fitness_center` | Sin acción |

**Dueño:**

| Ruta | Icono | Acción |
|---|---|---|
| `/owner/home` | `add` | Agregar cliente |
| `/owner/staff` | `person_add` | Agregar staff |
| `/owner/staff/add` | `add` | Sin acción |
| `/owner/clients` | `person_add` | Agregar cliente |
| `/owner/clients/add` | `add` | Sin acción |
| `/owner/clients/:membershipId` | `add` | Sin acción |
| `/owner/payments` | `add` | Sin acción (futuro: registrar pago manual) |
| `/owner/payments/:paymentId` | `add` | Sin acción |
| `/owner/plans` | `playlist_add` | Crear plan de membresía |
| `/owner/plans/create` | `add` | Sin acción |

**Nutricionista:**

| Ruta | Icono | Acción |
|---|---|---|
| `/nutritionist/home` | `add` | Futuro F3 |
| `/nutritionist/clients` | `add` | Futuro F3 |
| `/nutritionist/plans` | `add` | Futuro F3 |
| `/nutritionist/profile` | `add` | Sin acción |

## 10. Plantilla de Dashboard (pantalla Inicio de cada rol, en orden)
1) AppBar: PesaoAvatar + saludo por hora ("¡Buenos días, {nombre}! 👋") + campana con badge.
2) Slot OfflineBanner (condicional por connectivityProvider).
3) Fila de 2-3 PesaoStatCard según rol (cliente: kcal hoy / racha / próximo entreno; dueño: clientes
activos / pagos por verificar / ingresos del mes; entrenador: clientes asignados / sesiones hoy;
nutricionista: planes activos; superadmin: gimnasios / suscripciones activas).
4) PrimaryCard "acción de hoy" con CTA (cliente: "Entreno de hoy → Comenzar"; dueño: "Comprobantes
por verificar"; entrenador: "Sesiones de hoy"; etc.) con glow primary.
5) Sección secundaria (SectionHeader + lista corta).
6) Bajo el fold: feed/comunidad con paginación infinita.

### Estado actual de dashboards (v4)

| Rol | Stats | PrimaryCard | Sección secundaria |
|---|---|---|---|
| **Superadmin** | Gyms activos, solicitudes pending, suscripciones activas | Solicitudes KYC pendientes | Últimos gyms registrados |
| **Dueño** | Clientes activos, pagos pendientes, ingresos Bs | Comprobantes por verificar | Mi equipo (staff) + Planes del gym |
| **Entrenador** | Sesiones hoy, rutinas activas, clientes asignados | Próxima sesión del día | Planificador semanal |
| **Cliente** | Kcal hoy, racha días, próximo entreno | Tu rutina (plan activo) + Suscripción del gym | Sección "Hoy" |
| **Nutricionista** | Todo placeholder hasta F3 | Todo placeholder hasta F3 | Todo placeholder hasta F3 |

**Dashboard del cliente (v4):**
- `SubscriptionCard`: muestra plan de membresía, saldo (debe/al día/crédito),
  vencimiento, botón "Pagar" que abre `UploadPaymentSheet`.
- StatCard "Próximo entreno": muestra el nombre de la rutina del día actual
  desde el planificador semanal. Si no hay plan, muestra "—".
- PrimaryCard: muestra "Tu rutina" con conteo de ejercicios y CTA "Ver rutina"
  que navega a la tab Rutina. Si no hay plan, muestra estado vacío.


## 11. Plantilla de pantalla (TODA pantalla sin excepción)
Estructura: PesaoShell o Scaffold con PesaoAppBar → body SingleChildScrollView/CustomScroll con
padding 16 → contenido con componentes del kit.
Estados OBLIGATORIOS (5): loading (SkeletonLoader que replica el layout), error (ErrorState +
reintentar), empty (EmptyState + CTA), success (contenido), offline (data cacheada + OfflineBanner
+ escrituras en cola Isar). Se derivan del Result<T> del provider + connectivityProvider.

## 12. Microcopy venezolano (l10n es_VE, archivo app_es.arb)
Reglas: de tú; suave; máx. 1 emoji; nunca tecnicismos; siempre sugiere el siguiente paso.
Ejemplos: "Hmm, ese correo no parece válido 🤔" | "Parece que la señal está débil. Tus datos se
guardan y se sincronizan solos 📶" | "Aún no tienes rutinas asignadas. Cuando tu coach te arme una,
aparece aquí 💪" | "¡Pago verificado! Quedaste activo al instante ✅" | "¡Burda! 12 días seguidos 🔥".
SemanticsLabel SIEMPRE sin emoji (TalkBack).

## 13. Performance UI
const constructors; listas lazy + paginación; cached_network_image con transformaciones Cloudinary
(w_400,q_auto,f_auto cards; w_200 avatares); gráficos <=100 puntos (downsampling); imágenes lazy.

## 14. Definition of Done UI (checklist obligatorio al entregar CADA pantalla)
[ ] 1 Carpetas/rutas según arquitectura.md. [ ] 2 Código inglés, comentarios español.
[ ] 3 Textos solo desde AppStrings (arb es_VE). [ ] 4 Colores/tipografías solo tokens.
[ ] 5 Solo componentes Pesao* (nada de Material crudo para button/card/input).
[ ] 6 Provider @riverpod + Result<T>; nada de Supabase/Cloudinary en widgets.
[ ] 7 Los 5 estados implementados. [ ] 8 Ruta registrada en GoRouter + shell correcto.
[ ] 9 Accesibilidad: semantics, 48dp, AA, escalable. [ ] 10 Performance (const/lazy/cache).
[ ] 11 Microcopy venezolano suave. [ ] 12 dart format + línea 100.
[ ] 13 Sin BackdropFilter/shaders/dynamicColor. [ ] 14 Semantics sin emoji.
[ ] 15 Auto-revisión contra design-system.md antes de entregar.

## 15. Prohibiciones globales
Hardcodear hex/fuentes fuera de tokens | setState para lógica de negocio | Supabase o Cloudinary en
widgets | spinners clásicos (usar skeletons) | textos en inglés en UI | mensajes agresivos |
más de 1 FAB por shell | verde como acción genérica | blurs/shaders | OAuth (solo email/password).


## §27 Estado de implementación de pantallas (v4)

### Construidas y funcionales

**Públicas (10):**
Splash, Onboarding, Términos, Login, Registro, Forgot Password,
Gym Discovery, Gym Detail, Owner Application (KYC), Application Pending.

**Superadmin (3):**
Dashboard, Gym Applications list, Application detail.

**Dueño (13):**
Dashboard, Staff list, Staff add, Clients list, Client add, Client detail,
Payments list, Payment detail, Membership Plans list, Membership Plan form,
Training Plans list, Training Plan form, Plan Week Editor.

**Cliente (4):**
Dashboard, Client Routine Screen, Upload Payment Sheet.
Workout Execution Screen.

**Entrenador (8):**
Dashboard, Routines list, Routine form, Exercises list,
Exercise form, Training Plans list, Training Plan form, Plan Week Editor.

**Nutricionista (1):**
Dashboard (placeholder).

**Modales/Sheets (8):**
Confirm Dialog, Upload Payment Sheet, Exercise Picker Sheet,
Day Assignment Sheet, Assign Plan Sheet, Client Selector, Image Picker Field. Rest Timer Sheet.

**Total: ~45 pantallas/modales.**

### Pendientes

| Módulo | Pantallas pendientes |
|---|---|
| F2-D Ejecución | Historial + gráficos (ejecución y rest timer ya hechos) |
| F3 Nutrición | Todas las pantallas del nutricionista y del cliente |
| F5 Comunidad | Insignias, retos, rankings, feed |
| F6 Avanzado | Wearables, QR, reportes |
| Perfil | Edición de perfil, avatar, cambio de password (todos los roles) |
| Configuración | Configuración del gym (tasa manual, datos del gym) |