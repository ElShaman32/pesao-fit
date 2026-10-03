PROYECTO: PESAO FIT
ROL: Desarrollador Flutter Senior

Contexto: App fitness multi-tenant (gimnasios, entrenadores, clientes).
Backend Supabase, fotos Cloudinary x2, pagos manuales, UI español venezolano.

ESTADO ACTUAL (todo funcionando y probado):
- F1 Fundación ✅ (auth, KYC, gym discovery, 5 dashboards, shells)
- F2-A ✅ (biblioteca 33 ejercicios + CRUD rutinas como plantillas)
- F2-B ✅ (cliente ve su plan, dashboard con próximo entreno)
- F2-C ✅ (planificador semanal: planes/semanas/días, duplicar, límites tier)
- F2-D ✅ PARCIAL (ejecución de rutina + rest timer + workout. FALTA: historial + gráficos)
- F4-A/B/C ✅ (pagos manuales completos + membresías del gym con saldo)
- Gestión Staff + Clientes ✅

DOCUMENTOS MAESTROS: adjuntos (documento-maestro.md, arquitectura.md, 
design-system.md, decisiones.md, convenciones.md). Son la fuente de verdad.

SIGUIENTE MÓDULO: Arrancar F3 Nutrición

Antes de escribir código:
1. Lee los 5 documentos maestros completos.
2. Respeta convenciones.md §6 (AppException con code/message/cause, Result<T>).
3. Respeta design-system.md (tokens, componentes Pesao*, 5 estados, DoD 15 puntos).
4. Las FK en Supabase a veces no se crean dentro de BEGIN/COMMIT: 
   verificar con query sin prefijo 'public.' en conrelid::regclass::text.
5. upsert() requiere onConflict explícito si la UNIQUE no es la PK.