### **Fase 2: Data layer** (datasources + repos impl)

Usando las funciones RPC que ya tenemos en Supabase:
- `add_food_to_log()`
- `get_or_create_food_log()`
- `get_daily_food_log()` (nueva)
- `recalc_food_log_totals()`
- `recalc_meal_template_totals()`
- `recalc_nutrition_plan_totals()` (nueva)

---

### **Fase 3: Pantallas del nutricionista** (7 pantallas)

| # | Pantalla | Ruta | Prioridad |
|---|----------|------|-----------|
| 1 | Dashboard (mejorar actual con datos reales) | `/nutritionist/home` | P0 |
| 2 | Lista de clientes asignados | `/nutritionist/clients` | P0 |
| 3 | Detalle cliente (perfil + metas + historial) | `/nutritionist/clients/:clientId` | P0 |
| 4 | Catálogo de alimentos | `/nutritionist/plans/foods` | P1 |
| 5 | Crear/editar alimento | `/nutritionist/plans/foods/create` | P1 |
| 6 | Plantillas de comida | `/nutritionist/plans/templates` | P1 |
| 7 | Crear/editar plan nutricional | `/nutritionist/plans/create` | P0 |

---

### **Fase 4: Pantallas del cliente** (3 pantallas)

| # | Pantalla | Ruta | Prioridad |
|---|----------|------|-----------|
| 1 | Mi plan nutricional (tab Nutrición) | `/client/nutrition` | P0 |
| 2 | Food log diario | `/client/nutrition/log` | P0 |
| 3 | Buscar alimento (sheet) | modal | P1 |

---

### **Fase 5: Integración**

- Conectar dashboard con datos reales de `nutrition_plans`
- FAB contextual correcto por ruta
- Navegación completa entre pantallas
- DoD de 15 puntos por pantalla

---

## 🤔 Mi pregunta antes de arrancar

**¿Arrancamos con la Fase 0 (ordenar el shell) primero?**

Esto toma ~30 minutos y nos deja con:
- ✅ Shell del nutricionista con 4 tabs correctos
- ✅ Rutas limpias y organizadas
- ✅ Dashboard conectado

Una vez que confirmes, te paso el código exacto para la Fase 0 y luego arrancamos con el domain layer de F3.

**¿Te parece este plan o quieres ajustar algo?** 🎯
