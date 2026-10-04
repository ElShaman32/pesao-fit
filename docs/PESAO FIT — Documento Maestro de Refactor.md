# 📘 PESAO FIT — Documento Maestro de Refactor

> **Propósito**: fuente única de verdad del refactor de UI con widgets compartidos. Si este chat se cierra, se retoma desde este documento + la pantalla que toque.

---

## 0. Cómo usar este documento

- **Sección 1–4**: contexto fijo. No cambia entre pantallas.
- **Sección 5–6**: catálogo de widgets y reglas. Consultar antes de tocar cualquier pantalla.
- **Sección 7**: bitácora de pantallas. Se actualiza cada vez que cerramos una.
- **Sección 8**: pendientes y decisiones abiertas.

---

## 1. Objetivo del refactor

Reemplazar progresivamente la UI "manual" (containers, IconButtons, ListTiles crudos) por widgets compartidos del kit `shared/widgets/`, **sin tocar lógica** (providers, controllers, rutas, datos). Pantalla por pantalla, validando compilación después de cada una.

**No se cambia**: lógica de negocio, providers, entidades, navegación.
**Sí se cambia**: estructura visual, widgets crudos por `Pesao*`, tokens por literales.

---

## 2. Arquitectura confirmada

### Router / Shells (`core/router/shells/`)
- Un `*_shell.dart` por rol: `owner_shell`, `nutritionist_shell`, `trainer_shell`, `admin_shell`, `client_shell`.
- Todos usan `RoleShellScaffold` (`shell_scaffold.dart`).
- `RoleShellScaffold` internamente usa:
  - `PesaoShell` (wrapper Scaffold genérico).
  - `PesaoBottomNav` (nav inferior fijo por rol).
  - `PesaoFab` (FAB **contextual** según ruta actual, vía `_fabForRoute` de cada shell).

### Pantallas de feature (`features/*/presentation/screens/`)
- Usan **`Scaffold` de Flutter directamente** (NO `PesaoShell`).
- Se dibujan a sí mismas su AppBar (o fila superior en homes).
- **NO** dibujan bottom nav ni FAB (los pone el shell del rol).

**Regla de oro:** pantalla = `Scaffold`. Shell = `PesaoShell`. **Nunca se cruzan.**

---

## 3. Esqueleto canónico de "home de rol"

Todas las homes (`OwnerHome`, `NutritionistHome`, `ClientHome`, `TrainerHome`, `AdminHome`) deben seguir EXACTAMENTE esta estructura:

```
┌─────────────────────────────────────────────────────────┐
│ [PesaoAvatar 44]  [greeting con nombre]        [Campana]│  ← fila superior
│                                                         │
│ (si !isOnline) OfflineBanner                            │
│                                                         │
│ [StatCard] [StatCard] [StatCard]  ← tappables si aplica │
│                                                         │
│ [PesaoCard(glow) — acción primaria del rol]             │
│                                                         │
│ [Secciones específicas del rol]                         │
└─────────────────────────────────────────────────────────┘
```

### Reglas fijas

1. `Scaffold` de Flutter con `backgroundColor: AppColors.background`.
2. `SafeArea` → `RefreshIndicator` → `CustomScrollView`.
3. Fila superior con:
   - `PesaoAvatar(size: 44)` a la izquierda.
   - `Expanded(Text(greeting, AppTypography.title))` al centro.
   - `PesaoIconButton(icon: AppIcons.notificationsOutline)` a la derecha.
4. `OfflineBanner` como sliver, con `padding: EdgeInsets.all(AppDimens.l)`, solo si `!isOnline`.
5. Estados:
   - Loading + sin datos → `_SkeletonSliver` (usa `SkeletonLoader` + `SkeletonBox`).
   - Error + sin datos → `SliverFillRemaining(child: ErrorState(onRetry: ...))`.
   - Con datos → `_SuccessSliver`.
6. StatCards: fila de 3, cada una dentro de `Expanded`. `onTap` cuando exista destino de navegación.
7. PrimaryCard: `PesaoCard(glow: bool)` — nunca `Container` manual.
8. Sección inferior: `SectionHeader` + contenido, o `EmptyState` si aplica.
9. **Cero widgets crudos**: nada de `IconButton`, `Container` con `BoxDecoration` para cards, `SkeletonBox` local.
10. **Cero literales** de color/espaciado: siempre `AppColors.*` / `AppDimens.*`.

### Lo que NO es fijo
- Número de StatCards (3 por defecto, admin puede tener 4).
- Secciones inferiores (cada rol las suyas).
- Copy y contenido.

---

## 4. Tipos y providers confirmados

### `connectivityProvider`
- Tipo: `AsyncValue<bool>` (viene de `Stream<bool>`).
- Uso: `final isOnline = ref.watch(connectivityProvider).value ?? true;`
- ⚠️ **NO** usar `connectivity is bool`.

### `authProvider`
- `ChangeNotifier` global. Propiedades: `userFullName`, `avatarUrl`, `userGymId`, `isLoggedIn`, `isInitializing`.

### Entidades del dominio (por feature)
- `OwnerDashboardStats`, `NutritionistStats`, `ClientDashboardStats`, `TrainingPlan`, `TrainingPlanDay`.
- Se pasan **tipadas** a los widgets. **Nunca `dynamic`.**

---

## 5. Catálogo de widgets (estado real)

### 🟢 En uso en pantallas de feature

| Widget | Uso | Notas |
|---|---|---|
| `PesaoAvatar` | `name`, `imageUrl`, `size`, `ringColor`, `semanticLabel` | ⚠️ NO existe `fallbackText` |
| `PesaoIconButton` | `icon`, `semanticLabel`, `onPressed`, `badgeCount`, `isSelected` | Reemplaza `IconButton` |
| `PesaoButton` | `label`, `onPressed`, `variant`, `icon`, `loading`, `isExpanded` | Variantes: primary/secondary/ghost/danger |
| `PesaoCard` | `child`, `padding=16`, `glow`, `primaryTint`, `onTap` | ⚠️ Ya trae padding; NO anidar `Padding` |
| `PesaoStatCard` | `icon`, `label`, `value`, `sub`, `footer`, `onTap` | Tappable |
| `PesaoListTile` | `title`, `subtitle`, `leading`, `trailing`, `onTap` | ⚠️ Fondo `surfaceHigh` + borde; NO va en `PesaoCard` |
| `SectionHeader` | `title`, `onSeeAll` | — |
| `EmptyState` | `icon`, `title`, `body`, `actionLabel`, `onAction` | Usa `Center` interno |
| `ErrorState` | `icon`, `title`, `body`, `actionLabel`, `onRetry` | Usa `Center` interno |
| `OfflineBanner` | sin parámetros | — |
| `SkeletonLoader` + `SkeletonBox` / `SkeletonLine` / `SkeletonCircle` / `SkeletonCard` / `SkeletonListTile` | `child` dentro del loader | Primitivas deben ir DENTRO del `SkeletonLoader` |
| `showPesaoToast` | `message`, `semanticLabel`, `variant`, `icon` | — |
| `showConfirmDialog` | `title`, `message`, `confirmLabel`, `cancelLabel`, `isDestructive` | Retorna `Future<bool>` |
| `showPesaoBottomSheet` + `PesaoBottomSheetHeader` | `builder`, `title` | — |

### 🟢 En uso SOLO en shells (router/shells/)

| Widget | Uso |
|---|---|
| `PesaoShell` | Solo dentro de `RoleShellScaffold`. NO usar en pantallas. |
| `PesaoBottomNav` | Solo dentro de `RoleShellScaffold`. 4 tabs exactos. |
| `PesaoFab` | Solo dentro de `RoleShellScaffold`. Acción contextual por ruta. |

### 🟡 Disponibles (aún no vistos en pantalla)

| Widget | Cuándo usar |
|---|---|
| `PesaoInput` | Formularios. `label`, `hint`, `errorText`, etc. |
| `PesaoSearchBar` | Listas con búsqueda. |
| `PesaoChip` | Filtros, selección múltiple. |
| `PesaoTabs` | Navegación horizontal por tabs. |
| `PesaoBadge` | Estados semánticos (success/warning/error/brand). |
| `PesaoProgress` | Progreso determinístico (NO spinner). |
| `WeekPills` | Selector de día (rutinas/nutrición). |
| `MacroRing` | Solo nutrición. Anillo de macros. |
| `ChartCard` | Series temporales (peso, kcal). |
| `ImagePickerField` | Subida de imágenes. |
| `PesaoAppBar` | Solo si una pantalla no-home lo requiere. |

### 🔴 Descartados
Ninguno confirmado hasta ahora. `PesaoFab` y `PesaoShell` **NO están descartados** — son infraestructura del shell.

---

## 6. Anti-patrones (prohibidos)

| ❌ | ✅ |
|---|---|
| `PesaoCard(child: Padding(child: ...))` | `PesaoCard(child: ...)` |
| `PesaoCard(child: PesaoListTile(...))` | `PesaoListTile(...)` directo |
| `PesaoAvatar(fallbackText: 'N')` | `PesaoAvatar(name: 'Nombre')` |
| `SizedBox` dentro de `SkeletonLoader` | `SkeletonBox` |
| `CircularProgressIndicator` | `SkeletonLoader` |
| `IconButton` | `PesaoIconButton` |
| `ListTile` | `PesaoListTile` |
| `showDialog` + `AlertDialog` | `showConfirmDialog` |
| `ScaffoldMessenger.showSnackBar` | `showPesaoToast` |
| `Container` con `BoxDecoration` para una card | `PesaoCard` |
| `Column` con `Icon` + `Text` para "vacío" | `EmptyState` |
| `Column` con `Icon` + `Text` para "error" | `ErrorState` |
| `PesaoShell` en pantalla de feature | `Scaffold` de Flutter |
| `connectivity is bool` | `connectivity.value ?? true` |
| `dynamic stats` | Tipar con entidad real |
| `Text('Buenos días 👋')` hardcodeado | `l10n.greetingMorning(name)` |
| `Color(0xFF...)` literal | `AppColors.*` |
| `EdgeInsets.all(16)` | `EdgeInsets.all(AppDimens.l)` |

---

### Sección 6b — Uso de íconos (regla de 3 usos)

- **Navegación, tabs, estados globales** → siempre `AppIcons.*`.
- **Ícono en 3+ pantallas** → promover a `AppIcons` (editar `app_icons.dart`).
- **Ícono específico de una pantalla** → literal `Icons.xxx` con `// TODO: promover a AppIcons si se reutiliza`.
- **Nunca forzar un token** semánticamente incorrecto solo para evitar el literal.

**Anti-patrón:**
```dart
// ❌ Mal: usar warning para decir "sin sesiones"
Icon(AppIcons.warning, ...)
```

**Correcto:**
```dart
// ✅ Bien: literal explícito + TODO
Icon(Icons.event_busy_rounded, ...) // TODO: promover a AppIcons
```

---

## 7. Bitácora de pantallas


| # | Pantalla | Estado |
|---|---|---|
| 1 | `OwnerHomeScreen` | ✅ Completada |
| 2 | `NutritionistHomeScreen` | ✅ Completada |
| 3 | `ClientHomeScreen` | ✅ Completada |
| 4 | `TrainerHomeScreen` | ✅ Completada |


---


## 8. Decisiones y pendientes

### Decisiones cerradas
- ✅ Camino A: homes de rol con estructura unificada.
- ✅ Owner-style para fila superior (avatar + saludo + campana).
- ✅ StatCards tappables desde ya (usar `RouteNames.*`).
- ✅ Pantallas usan `Scaffold`, shells usan `PesaoShell`.
- ✅ AppBar de home = fila superior custom, NO `PesaoAppBar`.
- ✅ StatCards tappables con `RouteNames.*` en todas las homes donde exista destino.
- ✅ `connectivityProvider` es `AsyncValue<bool>`; uso canónico `connectivityAsync.value ?? true`.
- ✅ Fila superior canónica: `PesaoAvatar(44)` + `Expanded(Text(greeting))` + `PesaoIconButton(notificationsOutline)`.
- ✅ Errores con `ErrorState` inline en `SliverFillRemaining`.
- ✅ Skeletons con `SkeletonLoader` + `SkeletonBox`, envueltos en `SliverToBoxAdapter` (nunca `SliverList` con box widgets).

### Pendientes
- ⏳ Confirmar `RouteNames` disponibles para StatCards tappables (owner: `ownerClients`, `ownerPayments`; client: `clientRoutine`; nutritionist: por definir).
- ⏳ Migrar saludo hardcodeado de `NutritionistHomeScreen` a `AppStrings`.
- ⏳ Definir estructura de homes restantes (trainer, admin) cuando lleguemos.
- ⏳ Homes restantes: `AdminHomeScreen` (si existe), y verificar si hay más roles.
- ⏳ Migrar saludo hardcodeado de `NutritionistHomeScreen` (quedó en `AppStrings` en el último pase, así que ya no aplica 

### Archivos que NO tengo pero puedo necesitar
- `AppStrings` (para confirmar keys cuando falle).
- `RouteNames` (para StatCards tappables).
- Pantallas de feature que aún no me has pasado.

---

