# PESAO FIT — Traspaso de Contexto (Post-F1 Dashboards)

## 🏗️ Estado del proyecto

### ✅ Infraestructura completa
- **Supabase**: 20 tablas + RLS + triggers + funciones helper.
- **Drift**: 15 tablas offline (ADR-038), provider global configurado.
- **Cloudinary**: 2 cuentas configuradas (perfiles + progreso).
- **GoRouter**: StatefulShellRoute.indexedStack por rol (5 shells funcionales).

### ✅ Auth completo (F1 Fundación)
- Login + Registro (email/password, ADR-006).
- AuthNotifier como ChangeNotifier singleton (compatible con GoRouter refreshListenable).
- AuthUser como POCO + Equatable (ADR-037, sin Freezed por conflicto Dart 3.13+).
- Onboarding rol-primero (Opción B): pregunta "¿Dueño o Cliente?" ANTES del registro.
- Splash con `isInitializing` para esperar restauración de sesión.
- Formateo venezolano: teléfono (0412-1234567), cédula V/J/E (V-1.234.567), nombres capitalizados.

### ✅ Flujo KYC de dueños (ADR-036)
- Formulario completo → `gym_applications` (status pending).
- Pantalla de espera: "Tu solicitud está en revisión, te contactaremos en 24-48h".
- Funciones SQL `approve_gym()` / `reject_gym()` (SECURITY DEFINER, transaccionales).
- Al aprobar: crea gym + membership owner + subscription Pluma automáticamente.

### ✅ Flujo Gym Discovery de clientes (ADR-013)
- Búsqueda de gimnasios con debounce.
- Unirse → crea membership client → redirige al dashboard.
- MVP usa auto-aprobación (la aprobación por dueño es mejora futura).

### ✅ Panel del Superadmin completo
- Lista de solicitudes pendientes (tab "Gimnasios" del admin shell).
- Detalle con datos completos + botones Aprobar/Rechazar (con motivo).
- Dashboard con stats reales (gimnasios / pendientes / suscripciones).
- PrimaryCard con glow + CTA inteligente.

### ✅ Los 5 Dashboards funcionales (design-system.md §10)
| Rol | StatCards | PrimaryCard | Datos |
|---|---|---|---|
| Superadmin | Gimnasios / Pendientes / Suscripciones | "Solicitudes por revisar" | ✅ Reales |
| Cliente | kcal / racha / próximo entreno | "Entreno de hoy" | Placeholder (F2/F3) |
| Dueño | Clientes / Pagos / Ingresos | "Comprobantes por verificar" | Clientes reales, resto F4 |
| Entrenador | Clientes / Sesiones / Rutinas | "Sesiones de hoy" | Clientes reales, resto F2 |
| Nutricionista | Planes / Clientes / Consultas | "Planes por revisar" | Placeholder (F3) |

---

## 🔑 Decisiones técnicas clave (no obvias)

1. **AuthUser/Gym/Stats**: POCO + Equatable (ADR-037), sin Freezed.
2. **Onboarding**: pasa el rol al registro vía query param (`?role=owner|client`).
3. **Splash**: usa `isInitializing` para esperar restauración de sesión antes de redirigir.
4. **Superadmin**: `profiles.is_superadmin` + función `is_superadmin()` SECURITY DEFINER (ADR-039). NUNCA referenciar `auth.users` directo en RLS.
5. **Controllers keepAlive**: listener en `authProvider` + `Future.microtask(load)` para resolver race condition del token al iniciar.
6. **Email confirmation**: DESACTIVADO en Supabase dev (para pruebas con correos falsos).
7. **PesaoStatCard.value**: es `String`, no `int` (formatear con `.toString()`).
8. **SkeletonLoader**: no acepta `height` param → usar `_SkeletonBox` inline con Container.
9. **connectivityProvider**: puede devolver `AsyncValue<bool>`, resolver con `connectivity is bool ? connectivity : true`.
10. **Supabase queries**: `ilike`/`eq` (filtros) SIEMPRE antes de `order()` (transformación).

---

## 🧪 Usuarios y datos de prueba

| Email | Rol | Gym | Notas |
|---|---|---|---|
| leonelsira25@gmail.com | superadmin | — | `is_superadmin = true` |
| prueba@pesao.fit | client | Gym Pesao Prueba | Primera cuenta de prueba |
| cliente5@pesao.fit | client | Gym Fuerza Total | Creada en testing |
| (varios) | owner | Gym Colosus / Gym Del Barrio | Aprobados vía KYC |

**Gyms de prueba**: Gym Pesao Prueba, Gym Fuerza Total, Fitness Center Pro, Power House Gym, Gym Colosus, Gym Del Barrio.

---

## 🐛 Bugs resueltos (para no repetir)

| Bug | Causa | Solución |
|---|---|---|
| RLS `gym_applications` INSERT denied | Faltaban políticas | Crear políticas INSERT/SELECT |
| `permission denied for table users` | Referenciar `auth.users` en RLS | Usar `profiles.is_superadmin` + SECURITY DEFINER |
| Splash redirigía antes de restaurar sesión | `AuthNotifier._init()` es asíncrono | Agregar `isInitializing` flag |
| Lista de solicitudes vacía al entrar | Race condition: `build()` corre antes del token | Listener `authProvider` + `Future.microtask` |
| `ilike` undefined en PostgrestTransformBuilder | `order()` antes de `ilike()` | Filtros siempre antes de transformaciones |
| Freezed no compila | Conflicto freezed 4.x + Dart 3.13+ | POCO + Equatable para entidades simples |
| GoRouter rompe con parentNavigatorKey | GlobalKey dinámica dentro del builder | GlobalKey estables a nivel de archivo (ADR-034) |

---

## 📁 Estructura de archivos creada (resumen)

```
lib/
├── core/
│   ├── theme/ (app_colors, app_typography, app_dimens, app_icons, app_theme)
│   ├── l10n/ (app_es.arb + AppStrings)
│   ├── router/ (app_router, route_names, shells/ x5)
│   ├── providers/ (auth_provider, connectivity_provider, supabase_provider, database_provider)
│   ├── exceptions/ (app_exception.dart)
│   ├── utils/ (result.dart, input_formatters.dart)
│   └── database/ (app_database.dart + tables/ x15)
├── features/
│   ├── auth/ (domain, data, presentation: login, register)
│   ├── onboarding/ (domain, data, presentation: selección, KYC, gym discovery, pending)
│   ├── admin/ (domain, data, presentation: lista solicitudes, detalle, dashboard)
│   └── home/ (domain, data, presentation: dashboards x5 roles)
└── shared/
    └── widgets/ (kit Pesao* x26 componentes)
```

---

## 📄 Documentos maestros (v3, actualizados)

- **documento-maestro.md**: visión, roles, modelo negocio, fases, 20 tablas, flujos KYC/discovery/staff.
- **arquitectura.md**: Clean + Feature-First, estructura carpetas, navegación, offline-first, auth.
- **decisiones.md**: ADR-001 a ADR-039 (incluye Drift, GoRouter 18.x, POCO, superadmin SECURITY DEFINER).
- **convenciones.md**: idioma, nomenclatura, widgets, estado, API, git, performance, DoD.
- **design-system.md**: Dark Athletic Luxe completo (tokens, tipografía, componentes, templates, DoD 15 puntos).

---

## 🎯 Próximos bloques sugeridos (en orden de valor)

1. **Dashboard del Dueño + Gestión de Staff (ADR-035)**: crear entrenadores/nutricionistas desde el panel, respetando límite del plan.
2. **Módulo de Rutinas básico (F2)**: ejercicios, rutinas, asignación a clientes.
3. **Módulo de Pagos manual (F4)**: comprobantes, verificación por dueño, suscripciones.
4. **Perfil + edición de datos**: avatar (Cloudinary), nombre, cambio de password.
5. **Notificaciones (OneSignal)**: push + fallback email.

---

## ⚙️ Configuración del entorno

- **Flutter**: 3.47.2 stable
- **Dart**: 3.13.2
- **Supabase**: plan free, proyecto activo
- **Drift**: 15 tablas configuradas
- **Riverpod**: codegen con `@riverpod` / `@Riverpod(keepAlive: true)`
- **GoRouter**: 18.x con StatefulShellRoute.indexedStack
- **Freezed**: 4.0.1 (solo para modelos complejos; entidades simples usan POCO)
```

---
