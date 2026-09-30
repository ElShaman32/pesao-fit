# PESAO FIT - Convenciones de Código (v3)

1. Idioma
UI: español venezolano vía AppStrings (arb). Documentación: español.
Código (clases/variables/métodos/archivos): INGLES obligatorio. Comentarios: español.

2. Nomenclatura
Archivos snake_case | Clases PascalCase | Variables camelCase | const finales lowerCamelCase |
Todas las constantes lowerCamelCase (estándar oficial de Dart/Flutter).

3. Estructura y reglas de widgets
Pantallas en features/[feature]/presentation/screens/. Widget de UNA pantalla -> widgets/ de esa
feature; widget usado 2+ veces -> shared/widgets/. NUNCA Supabase/Cloudinary desde widgets: solo
datasources -> repositories -> providers. Usar componentes Pesao*; prohibido Material crudo para
botones/cards/inputs. Colores/tipografías SOLO tokens de core/theme. Textos SOLO AppStrings.

4. Plantilla obligatoria de pantalla
Toda pantalla implementa los 5 estados (loading skeleton / error / empty / success / offline)
derivados de Result<T> + connectivityProvider, con screen template de design-system.md §11.

5. Estado
Riverpod codegen (@riverpod). No setState para lógica de negocio. Provider por feature en
presentation/providers/. Providers globales en core/providers/.
AuthNotifier es ChangeNotifier singleton (compatibilidad con GoRouter refreshListenable).

6. API y datos
Supabase/Cloudinary solo en datasources. Repositories implementan interfaces de domain.
Result<T> siempre. Modelos Freezed + json_serializable para modelos complejos.
Entidades simples (<=6 campos) pueden ser POCO + Equatable (ADR-037).

7. Git
Ramas: main, develop, feature/nombre. Commits en español con scope: feat:, fix:, refactor:,
style:, docs: (ej: feat: agregar pantalla de login). dart format + línea 100 antes de commit.

8. Cloudinary (nombres de archivo)
{user_id}.jpg | {gym_id}.jpg | {exercise_id}.jpg | {fecha_yyyyMMdd}_{categoria}.jpg | {payment_id}.jpg

9. Microcopy y accesibilidad
Validaciones suaves venezolanas (design-system.md §12). WCAG AA, targets 48x48, VoiceOver/TalkBack
(semantics sin emoji), texto escalable 200%, patrón + color para daltonismo.

10. Performance
const siempre que sea posible | lazy loading + paginación | cache Drift (rutinas 7d, planes 3d) |
imágenes con transformaciones Cloudinary | sin BackdropFilter/shaders | gráficos <=100 puntos.

11. Base de datos local (Drift)
Drift cachea 15 de 20 tablas (ADR-038). Tablas en archivos separados en core/database/tables/.
AppDatabase en core/database/app_database.dart. Provider global en core/providers/database_provider.dart.

12. Definition of Done (código + UI)
Entrega = checklist de 15 puntos de design-system.md §14 marcado completo. Sin DoD no hay entrega.
