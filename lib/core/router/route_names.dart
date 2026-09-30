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

  // --- Cliente --------------------------------------------------------------

  static const String clientHome = '/client/home';
  static const String clientRoutine = '/client/routine';
  static const String clientNutrition = '/client/nutrition';
  static const String clientProfile = '/client/profile';

  // --- Entrenador -----------------------------------------------------------

  static const String trainerHome = '/trainer/home';
  static const String trainerClients = '/trainer/clients';
  static const String trainerRoutines = '/trainer/routines';
  static const String trainerProfile = '/trainer/profile';

  // --- Dueño ----------------------------------------------------------------

  static const String ownerHome = '/owner/home';
  static const String ownerClients = '/owner/clients';
  static const String ownerPayments = '/owner/payments';
  static const String ownerProfile = '/owner/profile';

  // --- Nutricionista --------------------------------------------------------

  static const String nutritionistHome = '/nutritionist/home';
  static const String nutritionistClients = '/nutritionist/clients';
  static const String nutritionistPlans = '/nutritionist/plans';
  static const String nutritionistProfile = '/nutritionist/profile';

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
