# 📘 Catálogo de Widgets — PESAO FIT

## Reglas globales (aplican a TODO)

1. **Nunca** uses widgets crudos de Material (`IconButton`, `ListTile`, `TextField`, `ElevatedButton`, `Card`, `Dialog`, `SnackBar`, `BottomSheet`, `CircularProgressIndicator`) si existe un `Pesao*` equivalente. El analyzer no lo detecta, pero rompe el DS.
2. **Textos siempre desde `AppStrings.of(context)`**. Los widgets aceptan `String?` pero nunca hardcodees copy en pantalla.
3. **Iconos desde `AppIcons.*`** cuando exista el token. Si no existe, usa `Icons.*` con comentario `// TODO: agregar token`.
4. **Colores y espaciados desde `AppColors.*` y `AppDimens.*`**. Cero literales (`16`, `Color(0x...)`).
5. **Padding**: `PesaoCard`, `PesaoListTile`, `PesaoButton` ya traen padding interno. **NO anidar `Padding` dentro de ellos** salvo que quieras más aire intencional.
6. **Touch target**: cualquier `GestureDetector` custom debe respetar `AppDimens.touchTarget` (48).

---

## 1. Superficies y contenedores

### `PesaoCard`
```dart
PesaoCard({
  required Widget child,
  EdgeInsetsGeometry padding = const EdgeInsets.all(AppDimens.l),
  EdgeInsetsGeometry margin = EdgeInsets.zero,
  bool glow = false,             // solo card primaria
  bool primaryTint = false,      // gradiente morado suave
  VoidCallback? onTap,
  Color borderColor = AppColors.outline,
})
```
- **Cuándo usar**: cualquier contenedor destacado. Es el `Card` oficial.
- **`glow: true`**: solo 1 por pantalla, para la card de acción principal.
- **`primaryTint: true`**: para diferenciar visualmente sin glow.
- **`onTap`**: convierte la card en botón (semántica incluida).
- ⚠️ **NO meter `Padding` interno** salvo intención: ya trae `AppDimens.l`.

### PesaoShell → 🟢 EN USO (infraestructura)
- Solo se usa dentro de RoleShellScaffold.
- Las pantallas de feature NO lo invocan.
- Si una pantalla necesita Scaffold, usa Scaffold de Flutter directo
  (porque el shell del rol ya está encima).

### `PesaoAppBar`
```dart
PesaoAppBar({
  String? title,
  Widget? leading,
  List<Widget>? actions,
  PreferredSizeWidget? bottom,
})
```
- **Cuándo usar**: siempre. Transparente, sin elevación, tipografía `title`.
- **`title`**: texto plano; el estilo ya está aplicado.

---

## 2. Acciones

### `PesaoButton`
```dart
PesaoButton({
  required String label,
  required VoidCallback? onPressed,   // null = disabled
  PesaoButtonVariant variant = PesaoButtonVariant.primary,
  IconData? icon,
  bool loading = false,
  bool isExpanded = true,
})
enum PesaoButtonVariant { primary, secondary, ghost, danger }
```
- **`primary`**: acción principal (morado).
- **`secondary`**: superficie + borde outline.
- **`ghost`**: sin fondo, texto morado.
- **`danger`**: rojo, SOLO acciones destructivas.
- **`isExpanded: false`**: cuando va dentro de una fila con otros elementos.

### `PesaoIconButton`
```dart
PesaoIconButton({
  required IconData icon,
  required String semanticLabel,
  VoidCallback? onPressed,
  double iconSize = 24,
  Color? iconColor,
  int? badgeCount,      // >0 muestra badge (9+ si supera 9)
  bool isSelected = false,
})
```
- **Cuándo usar**: cualquier ícono táctil (campana, menú, atrás).
- **Reemplaza**: `IconButton` de Material.
- **`badgeCount`**: para notificaciones no leídas.

### PesaoFab → 🟢 EN USO (restringido)
- Solo se usa dentro de RoleShellScaffold (router/shells/shell_scaffold.dart).
- Las pantallas de feature NO lo invocan.
- La acción la calcula cada *_shell.dart según la ruta actual.
- NO usar en pantallas.

---

## 3. Formularios

### `PesaoInput`
```dart
PesaoInput({
  TextEditingController? controller,
  String? label,
  String? hint,
  String? helper,
  String? errorText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool obscureText = false,
  bool enabled = true,
  TextInputType? keyboardType,
  TextInputAction? textInputAction,
  ValueChanged<String>? onChanged,
  ValueChanged<String>? onSubmitted,
  FocusNode? focusNode,
  bool autocorrect = true,
  TextCapitalization textCapitalization = TextCapitalization.none,
  List<TextInputFormatter>? inputFormatters,
})
```
- **Cuándo usar**: cualquier campo de texto. `label` arriba, `errorText` abajo con ícono.

### `PesaoSearchBar`
```dart
PesaoSearchBar({
  TextEditingController? controller,   // si no, crea uno interno
  String? hintText,                    // default: AppStrings.commonSearch
  ValueChanged<String>? onChanged,
  ValueChanged<String>? onSubmitted,
  bool autofocus = false,
  bool enabled = true,
})
```
- **Cuándo usar**: cualquier búsqueda. Ya trae ícono de lupa y botón "x".

### `ImagePickerField`
```dart
ImagePickerField({
  required Uint8List? imageBytes,
  required String pickLabel,
  required String replaceLabel,
  required ValueChanged<Uint8List> onImagePicked,
  String? error,
  VoidCallback? onImageCleared,
})
```
- **Cuándo usar**: subida de imágenes. El padre mantiene los bytes.

### `PesaoChip`
```dart
PesaoChip({
  required String label,
  bool selected = false,
  IconData? icon,
  VoidCallback? onTap,
})
```
- **Cuándo usar**: filtros, selección múltiple, tags. Pill 32px.

### `PesaoTabs`
```dart
PesaoTabs({
  required List<String> tabs,        // mínimo 2
  required int selectedIndex,
  required ValueChanged<int> onChanged,
})
```
- **Cuándo usar**: navegación por tabs horizontales. 4 tabs máx recomendado.

---

## 4. Listas y datos

### `PesaoListTile`
```dart
PesaoListTile({
  required String title,
  String? subtitle,
  Widget? leading,
  Widget? trailing,
  VoidCallback? onTap,
  bool enabled = true,
})
```
- **Cuándo usar**: filas de lista con fondo `surfaceHigh` y borde propio.
- ⚠️ **NO va dentro de `PesaoCard`** → doble borde + doble fondo.
- **Reemplaza**: `ListTile` de Material.

### `PesaoStatCard`
```dart
PesaoStatCard({
  required IconData icon,
  required String label,
  required String value,      // formateado como String
  String? sub,
  Widget? footer,             // badge, progreso, etc.
  VoidCallback? onTap,
})
```
- **Cuándo usar**: métricas tipo "1.850 clientes", "12 pendientes".
- **Ya incluye**: ícono circular, número grande tabular (`AppTypography.numberL`).
- **En fila**: envuélvelo en `Expanded` para que quepan 2-3 en `Row`.

### `SectionHeader`
```dart
SectionHeader({
  required String title,
  VoidCallback? onSeeAll,
})
```
- **Cuándo usar**: título de sección + "Ver todo" opcional.
- **`onSeeAll: null`** → no muestra el botón.

### `PesaoBadge`
```dart
PesaoBadge({
  required String label,
  PesaoBadgeVariant variant = PesaoBadgeVariant.brand,
  IconData? icon,
})
enum PesaoBadgeVariant { success, warning, error, brand }
```
- **Cuándo usar**: estados semánticos (aprobado, vencido, activo).
- **`success` SOLO éxito**, nunca acción.

### `PesaoProgress`
```dart
PesaoProgress({
  required double value,               // 0.0 a 1.0
  PesaoProgressVariant variant = PesaoProgressVariant.brand,
  double height = 8,
  String? semanticLabel,
})
enum PesaoProgressVariant { brand, success, warning }
```
- **Cuándo usar**: progreso determinístico. **NO** es spinner; para carga usa `SkeletonLoader`.

### `WeekPills`
```dart
WeekPills({
  required List<String> dayLabels,     // 7 labels exactos
  required int todayIndex,             // 0=Lun, 6=Dom
  required int selectedIndex,
  required ValueChanged<int> onSelected,
  Set<int> completedDays = const {},
})
```
- **Cuándo usar**: selector de día en rutinas/nutrición.

### `ChartCard`
```dart
ChartCard({
  required String title,
  required List<double> values,        // mínimo 2
  String? subtitle,
  double height = 180,
})
```
- **Cuándo usar**: series temporales (peso, kcal, progreso). Downsamples >100 puntos.

---

## 5. Estados (crucial)

### `EmptyState`
```dart
EmptyState({
  IconData? icon,
  String? title,          // default: AppStrings.emptyGenericTitle
  String? body,
  String? actionLabel,
  VoidCallback? onAction,
})
```
- **Cuándo usar**: listas vacías, "aún no hay X".
- **Usa `Center` interno** → necesita altura acotada. Va bien en `Expanded`, `SliverFillRemaining`, o `Column` con padding.
- ⚠️ **NO** como ítem de `SliverList` (explotaría).

### `ErrorState`
```dart
ErrorState({
  IconData? icon,
  String? title,          // default: AppStrings.errorGenericTitle
  String? body,
  String? actionLabel,
  VoidCallback? onRetry,
})
```
- **Cuándo usar**: fallo de carga. Siempre con retry.
- Mismas restricciones que `EmptyState`.

### `SkeletonLoader` + primitivas
```dart
SkeletonLoader({
  required Widget child,
  String? semanticLabel,
  Duration duration = const Duration(milliseconds: 1200),
})

SkeletonBox({ double? width, double? height, BorderRadius, BoxShape })
SkeletonLine({ required double width, double height = 12 })
SkeletonCircle({ double size = 40 })
SkeletonCard({ required double height })
SkeletonListTile({ bool hasSubtitle = true })
```
- **Cuándo usar**: mientras carga. **NO** `CircularProgressIndicator`.
- **⚠️ Importante**: las primitivas (`SkeletonBox`, etc.) deben ir **dentro** de un `SkeletonLoader` para heredar el shimmer vía `InheritedWidget`.
- **En slivers**: `SliverToBoxAdapter(child: SkeletonLoader(...))`.

---

## 6. Diálogos y overlays

### `showConfirmDialog`
```dart
Future<bool> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String confirmLabel,
  required String cancelLabel,
  bool isDestructive = false,
})
```
- **Cuándo usar**: confirmaciones. `isDestructive: true` → botón rojo.
- **Retorna**: `true` si confirmó, `false` si canceló.
- **Reemplaza**: `showDialog` + `AlertDialog`.

### `showPesaoBottomSheet` + `PesaoBottomSheetHeader`
```dart
Future<T?> showPesaoBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isDismissible = true,
  bool enableDrag = true,
})

PesaoBottomSheetHeader({ String? title })
```
- **Cuándo usar**: modales inferiores. Radio superior 24, fondo surface.
- **Header**: handle + título. `title: null` → solo handle.

### `showPesaoToast`
```dart
void showPesaoToast(
  BuildContext context, {
  required String message,          // puede llevar emoji
  required String semanticLabel,    // NUNCA emoji
  PesaoToastVariant variant = PesaoToastVariant.brand,
  IconData? icon,
})
enum PesaoToastVariant { success, warning, error, brand }
```
- **Cuándo usar**: feedback breve. Flotante, 3 segundos.
- **Reemplaza**: `ScaffoldMessenger.showSnackBar`.

### `PesaoToast` (pieza visual)
- Solo si necesitas el widget standalone fuera de un SnackBar.

---

## 7. Navegación

### PesaoBottomNav → 🟢 EN USO (infraestructura)
- Solo se usa dentro de RoleShellScaffold.
- NO usar en pantallas.

### `PesaoAvatar`
```dart
PesaoAvatar({
  String? imageUrl,
  String? name,              // genera iniciales automáticamente
  double size = 40,
  Color? ringColor,
  String? semanticLabel,
})
```
- **Cuándo usar**: avatares de usuario. `name` → iniciales si no hay URL.
- ⚠️ **NO existe `fallbackText`** ni `child`. Es `name` y `imageUrl`.

---

## 8. Especializados (por feature)

### `MacroRing`
```dart
MacroRing({
  required double proteinGrams,
  required double carbsGrams,
  required double fatsGrams,
  required int totalKcal,
  String? centerSubtitle,
  double size = 160,
  double strokeWidth = 14,
})
```
- **Solo nutrición**. Anillo con 3 segmentos coloreados.

### `OfflineBanner`
```dart
const OfflineBanner()
```
- **Cuándo usar**: cuando `connectivityProvider` da `false`. Va dentro de `PesaoShell.banner` o como primer hijo del body.

---

## 9. Anti-patrones detectados en pantallas reales

| ❌ Anti-patrón | ✅ Correcto |
|---|---|
| `PesaoCard(child: Padding(child: ...))` | `PesaoCard(child: ...)` (ya tiene padding) |
| `PesaoCard(child: PesaoListTile(...))` | `PesaoListTile(...)` directo |
| `PesaoAvatar(fallbackText: 'N')` | `PesaoAvatar(name: 'Nombre')` |
| `SizedBox(height: 80)` dentro de `SkeletonLoader` | `SkeletonBox(height: 80)` |
| `CircularProgressIndicator` | `SkeletonLoader` + `SkeletonBox` |
| `IconButton` | `PesaoIconButton` |
| `ListTile` | `PesaoListTile` |
| `showDialog` + `AlertDialog` | `showConfirmDialog` |
| `ScaffoldMessenger.showSnackBar` | `showPesaoToast` |
| `Text('Buenos días 👋')` hardcodeado | `l10n.greetingMorning(name)` |
| `Container` con `BoxDecoration` manual | `PesaoCard` |
| `Column` con `Icon` + `Text` para "vacío" | `EmptyState` |
| `Column` con `Icon` + `Text` para "error" | `ErrorState` |
| `SkeletonLoader` como ítem de `SliverList` | `SliverToBoxAdapter(child: SkeletonLoader(...))` |
| `EmptyState` como ítem de `SliverList` | Envolver en `SliverFillRemaining` o `SliverToBoxAdapter` con altura |
| Colores literales (`Color(0xFF...)`) | `AppColors.*` |
| `EdgeInsets.all(16)` | `EdgeInsets.all(AppDimens.l)` |

---

## 10. Providers — para no volver a equivocarme

### `connectivityProvider`
- **Tipo**: `AsyncValue<bool>` (viene de `Stream<bool>`).
- **Uso correcto**:
  ```dart
  final connectivityAsync = ref.watch(connectivityProvider);
  final isOnline = connectivityAsync.value ?? true;
  ```
- ⚠️ **NO** usar `connectivity is bool` — eso es falso, siempre es AsyncValue.

### `authProvider`
- Es un `ChangeNotifier` global (no Riverpod).
- Propiedades usadas: `userFullName`, `avatarUrl`, `userGymId`, `isLoggedIn`, `isInitializing`.
- **Acceso**: `authProvider.userFullName` directo (importado de `core/providers/auth_provider.dart`).

---

## 11. Theme — tokens disponibles

### `AppColors`
- Superficies: `background`, `oledBackground`, `surface`, `surfaceHigh`, `outline`
- Marca: `primary`, `primaryText`, `onPrimary`
- Éxito: `success`, `successText`, `onSuccess`
- Alertas: `warning`, `warningText`
- Errores: `error`, `errorText`
- Texto: `textPrimary`, `textSecondary`, `textDisabled`
- Macros: `macroProtein`, `macroCarbs`, `macroFats`

### `AppDimens`
- Espaciado: `xs=4, s=8, m=12, l=16, xl=24, xxl=32, xxxl=48, screenPadding=16`
- Radios: `radiusPill, radiusCard=16, radiusButton=12, radiusInput=12, radiusSheetTop=24` + sus `BorderRadius`
- Alturas: `buttonHeight=48, inputHeight=52, appBarHeight=56, bottomNavHeight=64, fabSize=56, tileMinHeight=56`
- Accesibilidad: `touchTarget=48`
- Bordes: `strokeWidth=1`

### `AppTypography`
- `display` (Barlow 32/700), `headline` (Manrope 24/800), `title` (18/700)
- `body` (14/500), `bodySmall` (12/500), `label` (12/700), `overline` (10/700)
- `numberL` (28/800 tabular), `numberM` (20/800 tabular)

### `AppShadows`
- `primaryGlow` — usar SOLO vía `PesaoCard(glow: true)`, `PesaoFab`.

### `AppIcons`
- Tokens por categoría: navegación, acciones, estados, fitness, macros, auth, media, otros.
- Ej: `home`, `homeOutline`, `add`, `close`, `search`, `success`, `error`, `offline`, `notifications`, `notificationsOutline`, `clients`, `clientsOutline`, `payments`, `plans`, `chart`, `timer`, `streak`, `kcal`, `weight`, `water`, `protein`, `carbs`, `fats`, `camera`, `qr`, `star`, `verified`, etc.

### Patrón obligatorio para pantallas de feature
Toda pantalla bajo features/*/presentation/screens/ DEBE:
1. Retornar Scaffold de Flutter (NO PesaoShell).
2. Usar SafeArea + (CustomScrollView | SingleChildScrollView).
3. Dibujar su propio PesaoAppBar como sliver superior (si aplica).
4. NO dibujar bottom nav ni FAB (los pone el shell del rol).

---