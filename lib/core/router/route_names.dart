/// Constantes de rutas centralizadas (evita typos y permite refactor seguro).
/// Uso: GoRouter.of(context).push(RouteNames.clientProfile);
abstract final class RouteNames {
  // --- Públicas (sin auth) --------------------------------------------------

  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String ownerApplication = '/owner-application';
  static const String applicationPending = '/application-pending';
  static const String terms = '/terms';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String gymDiscovery = '/gym-discovery';
  static const String gymDetail = '/gym-detail/:gymId';

  // --- Onboarding y Role Selector (FASE A) ---
  static const String roleSelector = '/role-selector';
  static const String qrScanner = '/qr-scanner';

  // --- Cliente --------------------------------------------------------------

  static const String clientHome = '/client/home';
  static const String clientRoutine = '/client/routine';
  static const String clientProfile = '/client/profile';
  static const String clientWorkout = '/client/routine/workout/:workoutId';
  static const String clientWorkoutHistory = '/client/routine/history';

  // ==========================================================================
  // RUTAS CLIENTE (NUTRICIÓN)
  // ==========================================================================

  static const String clientNutrition = '/client/nutrition';
  static const String clientNutritionLog = '/client/nutrition/log';
  static const String clientNutritionPlan = '/client/nutrition/plan';

  // --- Entrenador -----------------------------------------------------------

  static const String trainerHome = '/trainer/home';
  static const String trainerClients = '/trainer/clients';
  static const String trainerRoutines = '/trainer/routines';
  static const String trainerProfile = '/trainer/profile';
  static const String trainerPlanForm = '/trainer/routines/plan-create';
  static const String trainerPlanEdit = '/trainer/routines/plan/:planId';
  static const String trainerRoutineTemplates = '/trainer/routines/templates';
  static const String trainerRoutineCreate =
      '/trainer/routines/templates/create';
  static const String trainerRoutineEdit =
      '/trainer/routines/templates/:routineId';
  static const String trainerExercises = '/trainer/exercises';
  static const String trainerExerciseCreate = '/trainer/exercises/create';

  // --- Dueño ----------------------------------------------------------------

  static const String ownerHome = '/owner/home';
  static const String ownerClients = '/owner/clients';
  static const String ownerPayments = '/owner/payments';
  static const String ownerProfile = '/owner/profile';
  static const String ownerStaff = '/owner/staff';
  static const String ownerStaffAdd = '/owner/staff/add';
  static const String ownerClientAdd = '/owner/clients/add';
  static const String ownerClientDetail = '/owner/clients/:membershipId';
  static const String ownerPaymentDetail = '/owner/payments/:paymentId';
  static const String ownerPlans = '/owner/plans';
  static const String ownerPlanForm = '/owner/plans/:planId';
  static const String ownerPlanCreate = '/owner/plans/create';

  // ════════════════════════════════════════════════════════════════════════
  // RUTAS NUTRICIONISTA
  // ════════════════════════════════════════════════════════════════════════

  static const String nutritionistHome = '/nutritionist/home';
  static const String nutritionistClients = '/nutritionist/clients';
  static const String nutritionistClientDetail =
      '/nutritionist/clients/:clientId';
  static const String nutritionistPlans = '/nutritionist/plans';
  static const String nutritionistPlanCreate = '/nutritionist/plans/create';
  static const String nutritionistPlanEdit = '/nutritionist/plans/:planId';
  static const String nutritionistPlanDays = '/nutritionist/plans/:planId/days';
  static const String nutritionistProfile = '/nutritionist/profile';

  // Alimentos → sub-rutas de plans (herramientas del planificador)
  static const String nutritionistFoods = '/nutritionist/plans/foods';
  static const String nutritionistFoodCreate =
      '/nutritionist/plans/foods/create';
  static const String nutritionistFoodEdit =
      '/nutritionist/plans/foods/:foodId';

  // Plantillas de comida → sub-rutas de plans
  static const String nutritionistTemplates = '/nutritionist/plans/templates';
  static const String nutritionistTemplateCreate =
      '/nutritionist/plans/templates/create';
  static const String nutritionistTemplateEdit =
      '/nutritionist/plans/templates/:templateId';

  // --- Superadmin -----------------------------------------------------------

  static const String adminHome = '/admin/home';
  static const String adminGyms = '/admin/gyms';
  static const String adminPayments = '/admin/payments';
  static const String adminProfile = '/admin/profile';

  // --- Modales (sheets/dialogs) ---------------------------------------------

  static const String biometric = '/modal/biometric';
  static const String confirmDialog = '/modal/confirm';
  static const String imageViewer = '/modal/image-viewer';
  static const String paymentUpload = '/modal/payment-upload';
  static const String restTimer = '/modal/rest-timer';
}
