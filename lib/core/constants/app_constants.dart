/// Constantes globales de la aplicacion PESAO FIT.
class AppConstants {
  AppConstants._();

  // ============================================================
  // INFO DE LA APP
  // ============================================================
  static const String appName = 'PESAO FIT';
  static const String appTagline = 'Tu gym, tu ritmo, tu transformacion';

  // ============================================================
  // SUPABASE (Reemplazar con tus credenciales reales)
  // ============================================================
  static const String supabaseUrl = 'https://ksvohlooqutpohjsjqbf.supabase.co';
  static const String supabaseAnonKey =
      'sb_publishable_qreJsYKuIyJSMQ7N6sqoFw_NkbqJ1Z1';

  // ============================================================
  // CLOUDINARY (Reemplazar con tus credenciales reales)
  // ============================================================
  static const String cloudinaryProfilesCloudName = 'i99gpwfx';
  static const String cloudinaryProgressCloudName = 'ei6v4hsy';
  static const String cloudinaryUploadPreset = 'pesao_fit_preset';

  // ============================================================
  // CACHE (Isar)
  // ============================================================
  static const String isarDbName = 'pesao_fit_cache';
  static const Duration routinesCacheDuration = Duration(days: 7);
  static const Duration plansCacheDuration = Duration(days: 3);
  static const Duration exercisesCacheDuration = Duration(days: 14);

  // ============================================================
  // PAGINACION
  // ============================================================
  static const int defaultPageSize = 20;

  // ============================================================
  // LIMITES DE PLANES
  // ============================================================
  static const int plumaMaxClients = 5;
  static const int plumaMaxTrainers = 1;
  static const int hierroMaxClients = 50;
  static const int hierroMaxTrainers = 3;

  // ============================================================
  // SUSPENSION
  // ============================================================
  static const int suspensionDaysAfterExpiry = 7;

  // ============================================================
  // RUTAS (GoRouter)
  // ============================================================
  static const String routeSplash = '/';
  static const String routeOnboarding = '/onboarding';
  static const String routeTerms = '/terms';
  static const String routeLogin = '/login';
  static const String routeRegister = '/register';
  static const String routeForgotPassword = '/forgot-password';
  static const String routeGymDiscovery = '/gyms';
  static const String routeGymDetail = '/gyms/:id';

  // Rutas por rol
  static const String routeOwnerDashboard = '/owner';
  static const String routeTrainerDashboard = '/trainer';
  static const String routeNutritionistDashboard = '/nutritionist';
  static const String routeClientDashboard = '/client';
  static const String routeAdminDashboard = '/admin';
  static const String prefOnboardingSeen = 'onboarding_seen';
  static const String prefLastSync = 'last_sync';

  // ============================================================
  // VALIDACIONES
  // ============================================================
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 128;
  static const int maxNameLength = 100;
  static const int maxGymNameLength = 150;

  // ============================================================
  // MENSAJES UI (Espanol venezolano)
  // ============================================================
  static const String msgWelcome = 'Bienvenido a PESAO FIT';
  static const String msgLoginPrompt = 'Inicia sesion para seguir tu progreso';
  static const String msgRegisterPrompt = 'Crea tu cuenta y empieza a entrenar';
  static const String msgEmailInvalid = 'Hmm, ese correo no parece valido 🤔';
  static const String msgPasswordShort =
      'La clave debe tener al menos 6 caracteres';
  static const String msgFieldsRequired = 'Llena todos los campos, pana';
  static const String msgLoginError =
      'No pudimos iniciar sesion. Revisa tus datos.';
  static const String msgRegisterError = 'Hubo un problema creando tu cuenta.';
  static const String msgNoInternet =
      'Sin conexion. Algunas funciones estan limitadas.';
  static const String msgSyncPending =
      'Tus datos se sincronizaran cuando tengas internet.';
}
