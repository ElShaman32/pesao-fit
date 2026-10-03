c# PESAO FIT — Convenciones de Código y Estilo (v4)

> Última actualización: F2-A/B/C + F4-A/B/C + Planificador semanal.

## §1 Idiomas y textos

- Código: INGLES. Comentarios: español. UI: español venezolano.
- Toda cadena visible viene de `AppStrings` (gen-l10n, arb es_VE). CERO
  strings hardcoded.
- Microcopy suave: "Tranquilo, suele pasar" / "No te preocupes". Nunca
  "Error fatal" / "Fallo del sistema".
- Emojis permitidos en mensajes, PROHIBIDOS en semanticsLabel (TalkBack).

## §2 Arquitectura limpia

Capas: Presentation -> Domain -> Data. La UI nunca toca Supabase ni
Cloudinary directamente.

- **Domain:** entidades POCO + Equatable, interfaces de repositorio. Sin
  imports de Flutter ni de Supabase.
- **Data:** datasources (Supabase/Cloudinary), implementación de
  repositorios. Aquí vive el try/catch.
- **Presentation:** widgets, screens, providers @riverpod. Solo consume
  `Result<T>` del repositorio.

Features nuevas en este proyecto:
`auth | home | gym | clients | staff | routines | nutrition | payments | memberships | admin`

## §3 Estructura de carpetas

```
lib/
  core/
    theme/ providers/ router/ l10n/ database/ constants/ exceptions/ utils/ services/
  features/
    auth/ home/ gym/ clients/ staff/ routines/ nutrition/ payments/ memberships/ admin/
      domain/
        entities/
        repositories/
      data/
        datasources/
        repositories/
      presentation/
        screens/
        widgets/
        providers/
  shared/
    widgets/     # kit Pesao*
    components/  # componentes de negocio reutilizables
```

Regla: si un widget se usa en 2+ features, va a `shared/widgets/`. Si es de
un solo feature, se queda en `features/X/presentation/widgets/`.

## §4 Nomenclatura

- Archivos: snake_case. Clases: PascalCase. Variables/métodos: camelCase.
- Providers: `xxxControllerProvider` (keepAlive) o `xxxProvider` (autoDispose).
- Entidades: sustantivo singular en inglés (`Exercise`, `Routine`, `TrainingPlan`).
- Repositories: `XxxRepository` (interfaz) / `XxxRepositoryImpl` (implementación).
- Datasources: `XxxRemoteDatasource` / `XxxLocalDatasource`.
- Screens: `XxxScreen`. Widgets: `XxxCard`, `XxxTile`, `XxxSheet`, `XxxDialog`.
- Métodos privados: `_prefijoConGuionBajo`. NUNCA `_prefijo_con_underscores`.
- Constantes de rutas: `RouteNames.xxxYyy` en `route_names.dart`.

## §5 Manejo de estado

- Riverpod codegen (`@riverpod` / `@Riverpod(keepAlive: true)`).
- Controllers keepAlive con listener de `authProvider` para recargar al
  cambiar sesión/gym.
- Estado de pantalla: `AsyncValue<T>` para listas/detalles. Estado custom
  con `copyWith` para formularios.
- NUNCA `setState` para datos que vienen de repositorio. Solo para estado
  local de UI (texto de un campo, visibilidad de un error inline).
- Providers nuevos:
  - `exercisesControllerProvider`, `routinesControllerProvider` (F2-A)
  - `trainingPlansControllerProvider`, `clientTrainingPlanControllerProvider` (F2-C)
  - `membershipPlansControllerProvider`, `clientSubscriptionControllerProvider` (F4-C)
  - `ownerPaymentsControllerProvider`, `clientPaymentUploadControllerProvider` (F4-A/B)
  - `ownerStaffControllerProvider`, `ownerClientsControllerProvider` (Staff/Clientes)
  `workoutsRepositoryProvider`, `workoutExecutionControllerProvider` (F2-D)

## §6 Manejo de errores

| Workouts/* | fetch-error, fetch-active-error, fetch-sets-error, start-error, already-active, toggle-set-error, finish-error, no-active |

### Jerarquía de excepciones

```dart
sealed class AppException implements Exception {
  final String? code;      // Para AppStrings (UI)
  final String? message;   // Para logs/Sentry (NUNCA se muestra al usuario)
  final Object? cause;     // Excepción original
}

final class NetworkException extends AppException {}
final class UnauthorizedException extends AppException {}
final class ValidationException extends AppException {}
final class NotFoundException extends AppException {}
final class UnknownException extends AppException {}
```

### Patrón correcto en repositories

```dart
// ✅ CORRECTO
try {
  final data = await _remote.fetchSomething();
  return Result.success(data);
} on AppException catch (e) {
  return Result.failure(e);
} catch (e) {
  return Result.failure(
    UnknownException(
      code: 'Feature/action-error',
      message: 'Descripción técnica para logs',
      cause: e,
    ),
  );
}

// ❌ INCORRECTO (no sigue convenciones)
catch (e) {
  return Result.failure(AppException.unknown('texto suelto: $e'));
}
```

### Códigos de error por feature

Formato: `Feature/action-error`. La UI mapea `code` a `AppStrings`.

| Namespace | Códigos |
|---|---|
| `Auth/*` | `login-error`, `register-error`, `logout-error` |
| `Staff/*` | `fetch-error`, `invite-error`, `activate-error`, `deactivate-error` |
| `Clients/*` | `fetch-error`, `add-error`, `activate-error`, `deactivate-error` |
| `Payments/*` | `fetch-error`, `approve-error`, `reject-error`, `upload-error`, `no-gym` |
| `MembershipPlans/*` | `fetch-error`, `create-error`, `update-error`, `delete-error`, `assign-error` |
| `Exercises/*` | `fetch-error`, `create-error`, `update-error`, `delete-error` |
| `Routines/*` | `fetch-error`, `fetch-detail-error`, `create-error`, `update-error`, `deactivate-error`, `fetch-client-error`, `no-gym` |
| `TrainingPlans/*` | `fetch-error`, `fetch-detail-error`, `create-error`, `update-error`, `deactivate-error`, `week-limit-reached`, `duplicate-locked`, `add-week-error`, `duplicate-error`, `delete-week-error`, `assign-day-error`, `fetch-client-error`, `advance-week-error`, `no-gym` |
| `Gym/*` | `fetch-error`, `update-error` |
| `Admin/*` | `fetch-error`, `approve-error`, `reject-error` |

### Reglas de error

1. El datasource lanza la excepción cruda. El repository la atrapa y la
   envuelve en `UnknownException` con `code` y `cause`.
2. La UI NUNCA muestra `error.message`. Mapea `error.code` a `AppStrings`.
3. Si el `code` no tiene traducción en AppStrings, se muestra un fallback
   genérico suave: "No pudimos completar la acción".
4. `debugPrint` con emoji en datasource para debugging:
   `debugPrint('❌ FEATURE method: $e')`.

### Regla de UPSERT con onConflict

Supabase `upsert()` usa la **primary key** por defecto para detectar
conflictos. Si la tabla tiene una constraint UNIQUE en otras columnas,
se DEBE especificar `onConflict` explícitamente:

```dart
// ✅ CORRECTO: upsert por columnas de la constraint UNIQUE
await _client.from('training_plan_days').upsert(
  {'week_id': weekId, 'day_of_week': day, ...},
  onConflict: 'week_id,day_of_week',
);

// ❌ INCORRECTO: intenta INSERT y falla con duplicate key
await _client.from('training_plan_days').upsert(
  {'week_id': weekId, 'day_of_week': day, ...},
);
```

## §7 Testing

- Unit tests para repositories y usecases.
- Widget tests para componentes Pesao*.
- Integration tests para flujos críticos (auth, pagos, planificador).
- NUNCA testear con credenciales reales de Supabase. Usar mocks.

## §8 Git

- Commits atómicos. Mensaje en inglés: `feat:`, `fix:`, `refactor:`,
  `docs:`, `chore:`.
- Branch por feature: `feat/f2c-planner`, `fix/payment-upsert`.
- PR con descripción de qué cambia y por qué.
- NUNCA commitear `.env`, `google-services.json`, credenciales.

## §9 Performance

- `const` en todo widget que no depende de estado.
- Lazy loading de imágenes con `CachedNetworkImage`.
- Listas con `ListView.builder`, NUNCA `Column` con `children` para >10 items.
- Evitar rebuilds innecesarios: `Consumer` solo donde se necesita.
- Imágenes de Cloudinary siempre con transformación (nunca la original).
- Downsample de gráficos fl_chart a <=100 puntos por serie.

## §10 Accesibilidad

- `semanticLabel` en todo botón/icono interactivo. SIN emoji en semantics.
- Contraste mínimo 4.5:1 para texto normal, 3:1 para texto grande.
- Touch targets mínimo 48x48.
- Focus visible en navegación por teclado (web).
- `ExcludeSemantics` en decoración pura.

## §11 Seguridad

- RLS en TODAS las tablas. Sin excepción.
- Funciones SQL con `SECURITY DEFINER` para lógica de negocio.
- NUNCA exponer `service_role` key en el cliente.
- Validación de entrada en el servidor (funciones SQL), no solo en el cliente.
- Cloudinary preset unsigned con restricciones de tamaño y tipo.
- `.env` en `.gitignore`. Credenciales NUNCA en código.

## §12 DoD (Definition of Done)

15 puntos obligatorios antes de marcar una pantalla como terminada:

1. 5 estados: idle, loading, success, failure, offline.
2. Skeleton loader que replica el layout real.
3. OfflineBanner visible cuando no hay conexión.
4. Pull-to-refresh funcional.
5. EmptyState con CTA cuando la lista está vacía.
6. ErrorState con botón de reintento.
7. Todos los textos desde AppStrings (cero hardcoded).
8. Semantics en botones e iconos interactivos.
9. Tokens de theme (cero colores/tamaños hardcoded).
10. Solo componentes Pesao* (cero widgets Material directos).
11. Result<T> en el repositorio (cero excepciones lanzadas).
12. Provider con listener de authProvider.
13. FAB contextual correcto para la ruta.
14. Navegación con context.push (nunca Navigator.push).
15. flutter analyze sin errores ni warnings.

## §13 Tasa BCV

- La tasa se obtiene de dolarAPI (`https://dolarapi.com/v1/ven/ve/average`).
- Se cachea localmente con TTL de 4 horas. Si la cache es fresca, no se
  llama a la API.
- El dueño puede sobreescribir la tasa manualmente
  (`gym_settings.bcv_rate_override`). Si está seteada, tiene prioridad.
- Al registrar un pago, se guarda la tasa aplicada en `payments.rate_used`.
- Si dolarAPI falla y no hay cache, se muestra un error suave y se permite
  intentar de nuevo. NUNCA se usa una tasa hardcodeada.

## §14 Crash reporting

- Sentry para crash reporting y breadcrumbs.
- El `TODO: Inicializar Sentry` en `main.dart` se activa en fase de producción.
- NO se usa Crashlytics ni Firebase para esto.
- Sin analytics de producto en el MVP.
```
