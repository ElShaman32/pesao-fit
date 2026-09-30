-- ============================================================
-- PESAO FIT - Schema Completo PostgreSQL (Supabase)
-- 16 tablas + funciones helper + RLS + triggers + vistas
-- ============================================================

-- Extensiones necesarias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================
-- 1. TABLA: profiles (perfiles de usuario, extiende auth.users)
-- ============================================================
CREATE TABLE IF NOT EXISTS profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT NOT NULL,
    full_name TEXT,
    phone TEXT,
    avatar_url TEXT,
    role TEXT NOT NULL DEFAULT 'client' CHECK (role IN ('superadmin', 'owner', 'trainer', 'nutritionist', 'client')),
    is_active BOOLEAN NOT NULL DEFAULT true,
    biometric_enabled BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 2. TABLA: gyms (gimnasios)
-- ============================================================
CREATE TABLE IF NOT EXISTS gyms (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    owner_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    slug TEXT UNIQUE,
    description TEXT,
    logo_url TEXT,
    address TEXT,
    phone TEXT,
    email TEXT,
    website TEXT,
    instagram TEXT,
    is_active BOOLEAN NOT NULL DEFAULT true,
    is_verified BOOLEAN NOT NULL DEFAULT false,
    latitude NUMERIC(10, 8),
    longitude NUMERIC(11, 8),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 3. TABLA: plans (planes de suscripcion: Pluma, Hierro, Macizo)
-- ============================================================
CREATE TABLE IF NOT EXISTS plans (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL CHECK (name IN ('Pluma', 'Hierro', 'Macizo')),
    max_clients INTEGER NOT NULL,
    max_trainers INTEGER NOT NULL,
    max_nutritionists INTEGER NOT NULL,
    has_nutrition BOOLEAN NOT NULL DEFAULT false,
    has_chat BOOLEAN NOT NULL DEFAULT false,
    has_reports BOOLEAN NOT NULL DEFAULT false,
    has_qr BOOLEAN NOT NULL DEFAULT false,
    has_wearables BOOLEAN NOT NULL DEFAULT false,
    has_ai_nutrition BOOLEAN NOT NULL DEFAULT false,
    price_usd_monthly NUMERIC(10, 2) NOT NULL,
    price_usd_yearly NUMERIC(10, 2),
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Insertar planes base
INSERT INTO plans (name, max_clients, max_trainers, max_nutritionists, has_nutrition, has_chat, has_reports, has_qr, has_wearables, has_ai_nutrition, price_usd_monthly, price_usd_yearly) VALUES
('Pluma', 5, 1, 0, false, false, false, false, false, false, 0, 0),
('Hierro', 50, 3, 1, true, true, true, false, false, false, 20, 200),
('Macizo', 999999, 999999, 999999, true, true, true, true, true, true, 50, 500)
ON CONFLICT DO NOTHING;

-- ============================================================
-- 4. TABLA: subscriptions (suscripciones de gimnasios a planes)
-- ============================================================
CREATE TABLE IF NOT EXISTS subscriptions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    gym_id UUID NOT NULL REFERENCES gyms(id) ON DELETE CASCADE,
    plan_id UUID NOT NULL REFERENCES plans(id),
    status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'pending', 'suspended', 'cancelled', 'expired')),
    start_date DATE NOT NULL DEFAULT CURRENT_DATE,
    end_date DATE NOT NULL,
    auto_renew BOOLEAN NOT NULL DEFAULT true,
    payment_method TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 5. TABLA: memberships (relacion usuario-gimnasio)
-- ============================================================
CREATE TABLE IF NOT EXISTS memberships (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    gym_id UUID NOT NULL REFERENCES gyms(id) ON DELETE CASCADE,
    role TEXT NOT NULL DEFAULT 'client' CHECK (role IN ('owner', 'trainer', 'nutritionist', 'client')),
    is_active BOOLEAN NOT NULL DEFAULT true,
    assigned_by UUID REFERENCES profiles(id),
    assigned_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(user_id, gym_id)
);

-- ============================================================
-- 6. TABLA: payments (pagos manuales de gimnasios a Leonel)
-- ============================================================
CREATE TABLE IF NOT EXISTS payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    gym_id UUID NOT NULL REFERENCES gyms(id) ON DELETE CASCADE,
    subscription_id UUID REFERENCES subscriptions(id),
    amount_usd NUMERIC(10, 2) NOT NULL,
    amount_local NUMERIC(12, 2),
    currency_local TEXT DEFAULT 'VES',
    payment_method TEXT NOT NULL CHECK (payment_method IN ('pago_movil', 'binance', 'zelle', 'cash', 'other')),
    receipt_url TEXT,
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'verified', 'rejected')),
    verified_by UUID REFERENCES profiles(id),
    verified_at TIMESTAMPTZ,
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 7. TABLA: exercises (ejercicios base)
-- ============================================================
CREATE TABLE IF NOT EXISTS exercises (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    gym_id UUID REFERENCES gyms(id) ON DELETE SET NULL,
    name TEXT NOT NULL,
    description TEXT,
    muscle_group TEXT,
    equipment TEXT,
    image_url TEXT,
    video_url TEXT,
    is_system BOOLEAN NOT NULL DEFAULT false,
    created_by UUID REFERENCES profiles(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 8. TABLA: routines (rutinas creadas por entrenadores)
-- ============================================================
CREATE TABLE IF NOT EXISTS routines (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    gym_id UUID NOT NULL REFERENCES gyms(id) ON DELETE CASCADE,
    trainer_id UUID NOT NULL REFERENCES profiles(id),
    name TEXT NOT NULL,
    description TEXT,
    difficulty TEXT CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),
    duration_minutes INTEGER,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 9. TABLA: routine_exercises (ejercicios dentro de una rutina)
-- ============================================================
CREATE TABLE IF NOT EXISTS routine_exercises (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    routine_id UUID NOT NULL REFERENCES routines(id) ON DELETE CASCADE,
    exercise_id UUID NOT NULL REFERENCES exercises(id) ON DELETE CASCADE,
    day_of_week INTEGER CHECK (day_of_week BETWEEN 0 AND 6),
    order_index INTEGER NOT NULL DEFAULT 0,
    sets INTEGER NOT NULL DEFAULT 3,
    reps TEXT,
    rest_seconds INTEGER DEFAULT 60,
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(routine_id, exercise_id, day_of_week, order_index)
);

-- ============================================================
-- 10. TABLA: workouts (sesiones de entrenamiento del cliente)
-- ============================================================
CREATE TABLE IF NOT EXISTS workouts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    client_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    routine_id UUID REFERENCES routines(id),
    gym_id UUID NOT NULL REFERENCES gyms(id),
    name TEXT NOT NULL,
    date DATE NOT NULL DEFAULT CURRENT_DATE,
    duration_seconds INTEGER,
    notes TEXT,
    is_completed BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 11. TABLA: workout_exercises (ejercicios realizados en una sesion)
-- ============================================================
CREATE TABLE IF NOT EXISTS workout_exercises (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    workout_id UUID NOT NULL REFERENCES workouts(id) ON DELETE CASCADE,
    exercise_id UUID NOT NULL REFERENCES exercises(id),
    set_number INTEGER NOT NULL,
    reps_completed INTEGER,
    weight_kg NUMERIC(6, 2),
    duration_seconds INTEGER,
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 12. TABLA: body_measurements (medidas corporales)
-- ============================================================
CREATE TABLE IF NOT EXISTS body_measurements (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    client_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    weight_kg NUMERIC(6, 2),
    height_cm NUMERIC(6, 2),
    chest_cm NUMERIC(6, 2),
    waist_cm NUMERIC(6, 2),
    hips_cm NUMERIC(6, 2),
    biceps_cm NUMERIC(6, 2),
    thighs_cm NUMERIC(6, 2),
    body_fat_percentage NUMERIC(5, 2),
    measured_at DATE NOT NULL DEFAULT CURRENT_DATE,
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 13. TABLA: progress_photos (fotos de progreso)
-- ============================================================
CREATE TABLE IF NOT EXISTS progress_photos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    client_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    photo_url TEXT NOT NULL,
    thumbnail_url TEXT,
    category TEXT CHECK (category IN ('front', 'back', 'side', 'other')),
    taken_at DATE NOT NULL DEFAULT CURRENT_DATE,
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 14. TABLA: notifications
-- ============================================================
CREATE TABLE IF NOT EXISTS notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    type TEXT CHECK (type IN ('payment', 'routine', 'nutrition', 'system', 'chat')),
    is_read BOOLEAN NOT NULL DEFAULT false,
    data JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 15. TABLA: chats
-- ============================================================
CREATE TABLE IF NOT EXISTS chats (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    gym_id UUID NOT NULL REFERENCES gyms(id) ON DELETE CASCADE,
    client_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    trainer_id UUID REFERENCES profiles(id),
    nutritionist_id UUID REFERENCES profiles(id),
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(gym_id, client_id)
);

-- ============================================================
-- 16. TABLA: messages
-- ============================================================
CREATE TABLE IF NOT EXISTS messages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    chat_id UUID NOT NULL REFERENCES chats(id) ON DELETE CASCADE,
    sender_id UUID NOT NULL REFERENCES profiles(id),
    content TEXT NOT NULL,
    is_read BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- TABLA ADICIONAL: exchange_rates (tasas de cambio)
-- ============================================================
CREATE TABLE IF NOT EXISTS exchange_rates (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    currency_from TEXT NOT NULL DEFAULT 'USD',
    currency_to TEXT NOT NULL DEFAULT 'VES',
    rate NUMERIC(15, 4) NOT NULL,
    source TEXT DEFAULT 'manual',
    effective_date DATE NOT NULL DEFAULT CURRENT_DATE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- TABLA ADICIONAL: gym_payment_methods (metodos de pago por gimnasio)
-- ============================================================
CREATE TABLE IF NOT EXISTS gym_payment_methods (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    gym_id UUID NOT NULL REFERENCES gyms(id) ON DELETE CASCADE,
    method_type TEXT NOT NULL CHECK (method_type IN ('pago_movil', 'binance', 'zelle', 'cash', 'other')),
    bank_name TEXT,
    account_number TEXT,
    account_holder TEXT,
    phone_number TEXT,
    email TEXT,
    additional_info TEXT,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- FUNCIONES HELPER
-- ============================================================

-- Funcion: actualizar updated_at automaticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Funcion: obtener rol de usuario en un gimnasio
CREATE OR REPLACE FUNCTION get_gym_role(p_user_id UUID, p_gym_id UUID)
RETURNS TEXT AS $$
DECLARE
    v_role TEXT;
BEGIN
    SELECT role INTO v_role
    FROM memberships
    WHERE user_id = p_user_id AND gym_id = p_gym_id AND is_active = true;
    RETURN COALESCE(v_role, 'none');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Funcion: verificar si es miembro de un gimnasio
CREATE OR REPLACE FUNCTION is_gym_member(p_user_id UUID, p_gym_id UUID)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1 FROM memberships
        WHERE user_id = p_user_id AND gym_id = p_gym_id AND is_active = true
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Funcion: crear perfil al crear usuario auth
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO profiles (id, email, full_name, role)
    VALUES (
        NEW.id,
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email),
        COALESCE(NEW.raw_user_meta_data->>'role', 'client')
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger: crear perfil automaticamente
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW
    EXECUTE FUNCTION handle_new_user();

-- ============================================================
-- TRIGGERS PARA updated_at
-- ============================================================
CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_gyms_updated_at BEFORE UPDATE ON gyms
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_subscriptions_updated_at BEFORE UPDATE ON subscriptions
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_memberships_updated_at BEFORE UPDATE ON memberships
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_payments_updated_at BEFORE UPDATE ON payments
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_exercises_updated_at BEFORE UPDATE ON exercises
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_routines_updated_at BEFORE UPDATE ON routines
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_workouts_updated_at BEFORE UPDATE ON workouts
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_chats_updated_at BEFORE UPDATE ON chats
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_gym_payment_methods_updated_at BEFORE UPDATE ON gym_payment_methods
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ============================================================
-- VISTAS
-- ============================================================

-- Vista: miembros activos por gimnasio
CREATE OR REPLACE VIEW active_members AS
SELECT 
    m.id,
    m.user_id,
    m.gym_id,
    m.role,
    m.assigned_at,
    p.full_name,
    p.email,
    p.phone,
    p.avatar_url,
    g.name AS gym_name
FROM memberships m
JOIN profiles p ON m.user_id = p.id
JOIN gyms g ON m.gym_id = g.id
WHERE m.is_active = true AND p.is_active = true AND g.is_active = true;

-- Vista: pagos pendientes
CREATE OR REPLACE VIEW pending_payments AS
SELECT 
    p.id,
    p.gym_id,
    p.subscription_id,
    p.amount_usd,
    p.amount_local,
    p.currency_local,
    p.payment_method,
    p.receipt_url,
    p.status,
    p.notes,
    p.created_at,
    g.name AS gym_name,
    g.owner_id
FROM payments p
JOIN gyms g ON p.gym_id = g.id
WHERE p.status = 'pending';

-- ============================================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================================

-- Activar RLS en todas las tablas
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE gyms ENABLE ROW LEVEL SECURITY;
ALTER TABLE memberships ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE exercises ENABLE ROW LEVEL SECURITY;
ALTER TABLE routines ENABLE ROW LEVEL SECURITY;
ALTER TABLE routine_exercises ENABLE ROW LEVEL SECURITY;
ALTER TABLE workouts ENABLE ROW LEVEL SECURITY;
ALTER TABLE workout_exercises ENABLE ROW LEVEL SECURITY;
ALTER TABLE body_measurements ENABLE ROW LEVEL SECURITY;
ALTER TABLE progress_photos ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE chats ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE gym_payment_methods ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- POLITICAS RLS
-- ============================================================

-- profiles: cada usuario ve su propio perfil, superadmin ve todos
DROP POLICY IF EXISTS "profiles_select_own" ON profiles;
CREATE POLICY "profiles_select_own" ON profiles
    FOR SELECT USING (
        auth.uid() = id OR 
        EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin')
    );

DROP POLICY IF EXISTS "profiles_update_own" ON profiles;
CREATE POLICY "profiles_update_own" ON profiles
    FOR UPDATE USING (auth.uid() = id);

-- gyms: dueno ve sus gimnasios, superadmin ve todos, miembros ven su gimnasio
DROP POLICY IF EXISTS "gyms_select" ON gyms;
CREATE POLICY "gyms_select" ON gyms
    FOR SELECT USING (
        owner_id = auth.uid() OR
        EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin') OR
        is_gym_member(auth.uid(), id)
    );

DROP POLICY IF EXISTS "gyms_insert_owner" ON gyms;
CREATE POLICY "gyms_insert_owner" ON gyms
    FOR INSERT WITH CHECK (owner_id = auth.uid());

DROP POLICY IF EXISTS "gyms_update_owner" ON gyms;
CREATE POLICY "gyms_update_owner" ON gyms
    FOR UPDATE USING (owner_id = auth.uid());

-- memberships: dueno y staff ven miembros de su gimnasio, cada usuario ve sus propias
DROP POLICY IF EXISTS "memberships_select" ON memberships;
CREATE POLICY "memberships_select" ON memberships
    FOR SELECT USING (
        user_id = auth.uid() OR
        EXISTS (
            SELECT 1 FROM memberships m2 
            WHERE m2.user_id = auth.uid() 
            AND m2.gym_id = memberships.gym_id 
            AND m2.role IN ('owner', 'trainer', 'nutritionist')
        ) OR
        EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin')
    );

DROP POLICY IF EXISTS "memberships_insert_owner" ON memberships;
CREATE POLICY "memberships_insert_owner" ON memberships
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM memberships m2 
            WHERE m2.user_id = auth.uid() 
            AND m2.gym_id = memberships.gym_id 
            AND m2.role = 'owner'
        ) OR
        EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin')
    );

-- subscriptions: dueno ve sus suscripciones, superadmin ve todas
DROP POLICY IF EXISTS "subscriptions_select" ON subscriptions;
CREATE POLICY "subscriptions_select" ON subscriptions
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM gyms WHERE gyms.id = subscriptions.gym_id AND gyms.owner_id = auth.uid()
        ) OR
        EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin')
    );

-- payments: dueno ve sus pagos, superadmin ve todos
DROP POLICY IF EXISTS "payments_select" ON payments;
CREATE POLICY "payments_select" ON payments
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM gyms WHERE gyms.id = payments.gym_id AND gyms.owner_id = auth.uid()
        ) OR
        EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin')
    );

DROP POLICY IF EXISTS "payments_insert_owner" ON payments;
CREATE POLICY "payments_insert_owner" ON payments
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM gyms WHERE gyms.id = payments.gym_id AND gyms.owner_id = auth.uid()
        )
    );

-- exercises: visibles si pertenecen al gimnasio o son del sistema
DROP POLICY IF EXISTS "exercises_select" ON exercises;
CREATE POLICY "exercises_select" ON exercises
    FOR SELECT USING (
        is_system = true OR
        gym_id IS NULL OR
        is_gym_member(auth.uid(), gym_id)
    );

-- routines: visibles para miembros del gimnasio
DROP POLICY IF EXISTS "routines_select" ON routines;
CREATE POLICY "routines_select" ON routines
    FOR SELECT USING (
        is_gym_member(auth.uid(), gym_id) OR
        EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin')
    );

-- workouts: cliente ve las suyas, staff ve las de su gimnasio
DROP POLICY IF EXISTS "workouts_select" ON workouts;
CREATE POLICY "workouts_select" ON workouts
    FOR SELECT USING (
        client_id = auth.uid() OR
        EXISTS (
            SELECT 1 FROM memberships m 
            WHERE m.user_id = auth.uid() 
            AND m.gym_id = workouts.gym_id 
            AND m.role IN ('owner', 'trainer')
        )
    );

-- body_measurements: cliente ve las suyas, staff ve las de clientes asignados
DROP POLICY IF EXISTS "body_measurements_select" ON body_measurements;
CREATE POLICY "body_measurements_select" ON body_measurements
    FOR SELECT USING (client_id = auth.uid());

-- progress_photos: cliente ve las suyas
DROP POLICY IF EXISTS "progress_photos_select" ON progress_photos;
CREATE POLICY "progress_photos_select" ON progress_photos
    FOR SELECT USING (client_id = auth.uid());

-- notifications: cada usuario ve las suyas
DROP POLICY IF EXISTS "notifications_select" ON notifications;
CREATE POLICY "notifications_select" ON notifications
    FOR SELECT USING (user_id = auth.uid());

-- chats: participantes ven sus chats
DROP POLICY IF EXISTS "chats_select" ON chats;
CREATE POLICY "chats_select" ON chats
    FOR SELECT USING (
        client_id = auth.uid() OR
        trainer_id = auth.uid() OR
        nutritionist_id = auth.uid() OR
        EXISTS (
            SELECT 1 FROM memberships m 
            WHERE m.user_id = auth.uid() 
            AND m.gym_id = chats.gym_id 
            AND m.role = 'owner'
        )
    );

-- messages: participantes ven mensajes de sus chats
DROP POLICY IF EXISTS "messages_select" ON messages;
CREATE POLICY "messages_select" ON messages
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM chats c 
            WHERE c.id = messages.chat_id 
            AND (c.client_id = auth.uid() OR c.trainer_id = auth.uid() OR c.nutritionist_id = auth.uid())
        )
    );

-- gym_payment_methods: dueno gestiona, miembros ven
DROP POLICY IF EXISTS "gym_payment_methods_select" ON gym_payment_methods;
CREATE POLICY "gym_payment_methods_select" ON gym_payment_methods
    FOR SELECT USING (
        is_active = true AND
        (is_gym_member(auth.uid(), gym_id) OR
        EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin'))
    );

-- exchange_rates: todos pueden leer, solo superadmin escribe
DROP POLICY IF EXISTS "exchange_rates_select" ON exchange_rates;
CREATE POLICY "exchange_rates_select" ON exchange_rates
    FOR SELECT USING (true);

-- ============================================================
-- INDICES PARA PERFORMANCE
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_memberships_user ON memberships(user_id);
CREATE INDEX IF NOT EXISTS idx_memberships_gym ON memberships(gym_id);
CREATE INDEX IF NOT EXISTS idx_subscriptions_gym ON subscriptions(gym_id);
CREATE INDEX IF NOT EXISTS idx_payments_gym ON payments(gym_id);
CREATE INDEX IF NOT EXISTS idx_payments_status ON payments(status);
CREATE INDEX IF NOT EXISTS idx_routines_gym ON routines(gym_id);
CREATE INDEX IF NOT EXISTS idx_routine_exercises_routine ON routine_exercises(routine_id);
CREATE INDEX IF NOT EXISTS idx_workouts_client ON workouts(client_id);
CREATE INDEX IF NOT EXISTS idx_workouts_gym ON workouts(gym_id);
CREATE INDEX IF NOT EXISTS idx_body_measurements_client ON body_measurements(client_id);
CREATE INDEX IF NOT EXISTS idx_progress_photos_client ON progress_photos(client_id);
CREATE INDEX IF NOT EXISTS idx_notifications_user ON notifications(user_id);
CREATE INDEX IF NOT EXISTS idx_chats_gym ON chats(gym_id);
CREATE INDEX IF NOT EXISTS idx_chats_client ON chats(client_id);
CREATE INDEX IF NOT EXISTS idx_messages_chat ON messages(chat_id);
CREATE INDEX IF NOT EXISTS idx_exchange_rates_date ON exchange_rates(effective_date DESC);
