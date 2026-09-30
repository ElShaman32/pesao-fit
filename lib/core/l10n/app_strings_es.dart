// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_strings.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppStringsEs extends AppStrings {
  AppStringsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'PESAO FIT';

  @override
  String get tabHome => 'Inicio';

  @override
  String get tabRoutine => 'Rutina';

  @override
  String get tabNutrition => 'Nutrición';

  @override
  String get tabProfile => 'Perfil';

  @override
  String get tabClients => 'Clientes';

  @override
  String get tabPayments => 'Pagos';

  @override
  String get tabGyms => 'Gimnasios';

  @override
  String get tabPlans => 'Planes';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonConfirm => 'Confirmar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonBack => 'Atrás';

  @override
  String get commonNext => 'Siguiente';

  @override
  String get commonSkip => 'Saltar';

  @override
  String get commonSearch => 'Buscar';

  @override
  String get commonSeeAll => 'Ver todo';

  @override
  String get commonLoading => 'Cargando…';

  @override
  String get commonStart => 'Comenzar';

  @override
  String get fabRegisterExercise => 'Registrar ejercicio';

  @override
  String get fabNewRoutine => 'Nueva rutina';

  @override
  String get fabAddClient => 'Agregar cliente';

  @override
  String get fabNewPlan => 'Nuevo plan';

  @override
  String get fabAddGym => 'Agregar gimnasio';

  @override
  String get offlineBanner =>
      'Modo sin conexión — tus datos se sincronizan solos 📶';

  @override
  String get offlineBannerSemantics =>
      'Modo sin conexión. Tus datos se sincronizan solos.';

  @override
  String get emptyGenericTitle => 'Nada por aquí todavía';

  @override
  String get emptyGenericBody => 'Cuando tengas algo, aparece en este espacio.';

  @override
  String get errorGenericTitle => 'Algo no salió bien';

  @override
  String get errorGenericBody => 'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get errorGenericButton => 'Reintentar';

  @override
  String greetingMorning(String name) {
    return '¡Buenos días, $name! 👋';
  }

  @override
  String greetingMorningSemantics(String name) {
    return 'Buenos días, $name.';
  }

  @override
  String greetingAfternoon(String name) {
    return '¡Buenas tardes, $name! 👋';
  }

  @override
  String greetingAfternoonSemantics(String name) {
    return 'Buenas tardes, $name.';
  }

  @override
  String greetingNight(String name) {
    return '¡Buenos noches, $name! 👋';
  }

  @override
  String greetingNightSemantics(String name) {
    return 'Buenas noches, $name.';
  }

  @override
  String get authEmailInvalid => 'Hmm, ese correo no parece válido 🤔';

  @override
  String get loginTitle => 'Entrar a PESAO FIT';

  @override
  String get loginSubtitle => 'Mete tus datos pa\' empezar a darle 💪';

  @override
  String get loginEmailLabel => 'Correo electrónico';

  @override
  String get loginEmailHint => 'tu@correo.com';

  @override
  String get loginPasswordLabel => 'Contraseña';

  @override
  String get loginPasswordHint => 'Mínimo 6 caracteres';

  @override
  String get loginForgot => '¿Se te olvidó la contraseña?';

  @override
  String get loginSubmit => 'Entrar';

  @override
  String get loginNoAccount => '¿No tienes cuenta?';

  @override
  String get loginSignUp => 'Regístrate aquí';

  @override
  String get loginErrorInvalid => 'Hmm, ese correo o contraseña no cuadran 🤔';

  @override
  String get loginErrorEmailUnconfirmed =>
      'Revisa tu correo, te mandamos un link pa\' confirmar 📧';

  @override
  String get loginErrorGeneric => 'Algo no cuadró, intenta de nuevo ahorita';

  @override
  String get loginValidationEmail => 'Ese correo no parece válido';

  @override
  String get loginValidationPassword =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get registerTitle => 'Crear cuenta';

  @override
  String get registerSubtitle => 'Únete a PESAO FIT y empieza a entrenar 💪';

  @override
  String get registerFullNameLabel => 'Nombre completo';

  @override
  String get registerFullNameHint => 'Tu nombre real';

  @override
  String get registerPasswordLabel => 'Contraseña';

  @override
  String get registerPasswordHint => 'Mínimo 6 caracteres';

  @override
  String get registerConfirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get registerConfirmPasswordHint => 'Repite tu contraseña';

  @override
  String get registerSubmit => 'Crear cuenta';

  @override
  String get registerHasAccount => '¿Ya tienes cuenta?';

  @override
  String get registerSignIn => 'Entra aquí';

  @override
  String get registerErrorEmailExists =>
      'Ese correo ya está registrado. ¿Quieres entrar?';

  @override
  String get registerErrorWeakPassword =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get registerErrorGeneric => 'Algo no cuadró, intenta de nuevo';

  @override
  String get registerValidationName => 'El nombre no puede estar vacío';

  @override
  String get registerValidationPasswordMismatch =>
      'Las contraseñas no coinciden';

  @override
  String get onboardingTitle => '¿Cómo quieres usar PESAO FIT?';

  @override
  String get onboardingSubtitle => 'Elige la opción que mejor te describe 👇';

  @override
  String get onboardingOwnerTitle => 'Soy dueño de gimnasio';

  @override
  String get onboardingOwnerDescription =>
      'Tengo un gym y quiero gestionar clientes, staff y pagos desde la app';

  @override
  String get onboardingClientTitle => 'Soy cliente';

  @override
  String get onboardingClientDescription =>
      'Entreno en un gym y quiero seguir mi progreso y rutinas';

  @override
  String get onboardingSkip => 'Saltar por ahora';

  @override
  String get ownerAppTitle => 'Crear mi gimnasio';

  @override
  String get ownerAppSubtitle =>
      'Cuéntanos sobre ti y tu gym para verificar tu cuenta 🏋️';

  @override
  String get ownerAppPersonalSection => 'Tus datos';

  @override
  String get ownerAppPhoneLabel => 'Teléfono';

  @override
  String get ownerAppPhoneHint => '0412-1234567';

  @override
  String get ownerAppDocumentLabel => 'Cédula o RIF (opcional)';

  @override
  String get ownerAppDocumentHint => 'V-12345678 o J-12345678-9';

  @override
  String get ownerAppGymSection => 'Datos del gimnasio';

  @override
  String get ownerAppGymNameLabel => 'Nombre del gimnasio';

  @override
  String get ownerAppGymNameHint => 'Ej: Gym Pesao';

  @override
  String get ownerAppGymRifLabel => 'RIF del negocio (opcional)';

  @override
  String get ownerAppGymRifHint => 'J-12345678-9';

  @override
  String get ownerAppGymAddressLabel => 'Dirección completa';

  @override
  String get ownerAppGymAddressHint => 'Av. Lara, C.C. Cosmo, Local 12';

  @override
  String get ownerAppGymStateLabel => 'Estado';

  @override
  String get ownerAppGymCityLabel => 'Ciudad';

  @override
  String get ownerAppGymCityHint => 'Ej: Barquisimeto';

  @override
  String get ownerAppGymPhoneLabel => 'Teléfono del gimnasio';

  @override
  String get ownerAppGymPhoneHint => '0251-1234567';

  @override
  String get ownerAppGymInstagramLabel => 'Instagram (opcional)';

  @override
  String get ownerAppGymInstagramHint => '@gym_pesao';

  @override
  String get ownerAppGymDescriptionLabel => 'Descripción (opcional)';

  @override
  String get ownerAppGymDescriptionHint =>
      'Cuéntanos sobre tu gym en pocas líneas';

  @override
  String get ownerAppGymPhotoLabel => 'Foto del local (opcional)';

  @override
  String get ownerAppGymPhotoButton => 'Agregar foto';

  @override
  String get ownerAppGymLocationButton => 'Usar mi ubicación';

  @override
  String get ownerAppSubmit => 'Enviar solicitud';

  @override
  String get ownerAppValidationErrorPhone =>
      'El teléfono debe tener formato venezolano';

  @override
  String get ownerAppValidationErrorGymName =>
      'El nombre del gimnasio no puede estar vacío';

  @override
  String get ownerAppValidationErrorAddress =>
      'La dirección no puede estar vacía';

  @override
  String get ownerAppValidationErrorState => 'Debes seleccionar un estado';

  @override
  String get ownerAppValidationErrorCity => 'La ciudad no puede estar vacía';

  @override
  String get ownerAppSuccessTitle => '¡Solicitud enviada! 🎉';

  @override
  String get ownerAppSuccessMessage =>
      'Recibimos tu solicitud. Te contactaremos en 24-48h para verificar tu gym. 📞';

  @override
  String get ownerAppSuccessBack => 'Volver al inicio';

  @override
  String get gymDiscoveryTitle => 'Encuentra tu gimnasio';

  @override
  String get gymDiscoverySubtitle => 'Busca el gym donde entrenas y únete 💪';

  @override
  String get gymDiscoverySearchHint => 'Buscar por nombre...';

  @override
  String get gymDiscoveryEmpty =>
      'No encontramos gimnasios con ese nombre. Intenta con otro 🤔';

  @override
  String get gymDiscoveryJoin => 'Unirme';

  @override
  String gymDiscoveryJoinTitle(String name) {
    return '¿Unirte a $name?';
  }

  @override
  String get gymDiscoveryJoinMessage =>
      'Al unirte, tu gimnasio podrá ver tu progreso y asignarte rutinas.';

  @override
  String get gymDiscoveryJoinConfirm => 'Sí, unirme';

  @override
  String get gymDiscoveryJoinSuccess => '¡Ya eres parte del gym! Bienvenido 💪';

  @override
  String get adminAppsTitle => 'Solicitudes de gimnasios';

  @override
  String get adminAppsSubtitle => 'Revisa y aprueba los nuevos gimnasios 🏋️';

  @override
  String get adminAppsEmpty =>
      'No hay solicitudes pendientes. Cuando un dueño se registre, aparece aquí.';

  @override
  String get adminAppsSubmitted => 'Enviado';

  @override
  String get adminAppsOwnerSection => 'Datos del dueño';

  @override
  String get adminAppsGymSection => 'Datos del gimnasio';

  @override
  String get adminAppsApprove => 'Aprobar';

  @override
  String get adminAppsReject => 'Rechazar';

  @override
  String adminAppsApproveTitle(String name) {
    return '¿Aprobar $name?';
  }

  @override
  String get adminAppsApproveMessage =>
      'Se creará el gimnasio, la membresía del dueño y la suscripción Pluma por 1 año.';

  @override
  String get adminAppsRejectTitle => 'Rechazar solicitud';

  @override
  String get adminAppsRejectReasonLabel => 'Motivo del rechazo';

  @override
  String get adminAppsRejectReasonHint =>
      'Cuéntale al dueño por qué no fue aprobado...';

  @override
  String get adminAppsApproveSuccess =>
      '¡Gimnasio aprobado! El dueño ya puede entrar 🎉';

  @override
  String get adminAppsRejectSuccess =>
      'Solicitud rechazada. El dueño verá el motivo.';

  @override
  String get adminAppsError => 'No pudimos cargar las solicitudes';

  @override
  String get adminAppsFieldPhone => 'Teléfono';

  @override
  String get adminAppsFieldDocument => 'Documento';

  @override
  String get adminAppsFieldAddress => 'Dirección';

  @override
  String get adminAppsFieldCity => 'Ciudad';

  @override
  String get adminAppsFieldState => 'Estado';

  @override
  String get adminAppsFieldInstagram => 'Instagram';

  @override
  String get adminAppsFieldDescription => 'Descripción';

  @override
  String get adminAppsFieldRif => 'RIF';

  @override
  String get adminDashStatGyms => 'Gimnasios';

  @override
  String get adminDashStatGymsSub => 'Activos en la red';

  @override
  String get adminDashStatPending => 'Pendientes';

  @override
  String get adminDashStatPendingSub => 'Por revisar';

  @override
  String get adminDashStatSubs => 'Suscripciones';

  @override
  String get adminDashStatSubsSub => 'Planes activos';

  @override
  String get adminDashPrimaryTitle => 'Solicitudes por revisar';

  @override
  String adminDashPrimaryBody(int count) {
    return 'Tienes $count gimnasios esperando tu revisión. Llamar o visitar antes de aprobar.';
  }

  @override
  String get adminDashPrimaryCta => 'Ver solicitudes';

  @override
  String get adminDashPrimaryCtaNone => 'Todo al día';

  @override
  String get adminDashRecentSection => 'Últimos gimnasios aprobados';

  @override
  String get adminDashRecentEmpty => 'Aún no hay gimnasios aprobados';

  @override
  String get adminDashErrorTitle => 'No pudimos cargar tu panel';

  @override
  String get adminDashErrorBody =>
      'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get adminDashEmptyTitle => 'Todo tranquilo por aquí';

  @override
  String get adminDashEmptyBody =>
      'Cuando se registren gimnasios, los números aparecen aquí.';

  @override
  String get clientDashStatKcal => 'kcal hoy';

  @override
  String get clientDashStatKcalSub => 'Meta: 2.200';

  @override
  String get clientDashStatStreak => 'Racha';

  @override
  String get clientDashStatStreakSub => 'días seguidos';

  @override
  String get clientDashStatNext => 'Próximo';

  @override
  String get clientDashStatNextSub => 'entreno';

  @override
  String get clientDashPrimaryTitle => 'Entreno de hoy';

  @override
  String get clientDashPrimaryBody =>
      'Tu coach aún no te asigna una rutina. Cuando lo haga, aparece aquí para que empieces 💪';

  @override
  String get clientDashPrimaryCta => 'Comenzar';

  @override
  String get clientDashPrimaryCtaNone => 'Sin entreno hoy';

  @override
  String get clientDashTodaySection => 'Hoy';

  @override
  String get clientDashTodayEmpty =>
      'Nada programado para hoy. Aprovecha de descansar o hidrátate 💧';

  @override
  String get clientDashErrorTitle => 'No pudimos cargar tu inicio';

  @override
  String get clientDashErrorBody =>
      'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get ownerDashStatClients => 'Clientes';

  @override
  String get ownerDashStatClientsSub => 'Activos en tu gym';

  @override
  String get ownerDashStatPayments => 'Pagos';

  @override
  String get ownerDashStatPaymentsSub => 'Por verificar';

  @override
  String get ownerDashStatIncome => 'Ingresos';

  @override
  String get ownerDashStatIncomeSub => 'Este mes (Bs)';

  @override
  String get ownerDashPrimaryTitle => 'Comprobantes por verificar';

  @override
  String ownerDashPrimaryBody(int count) {
    return 'Tienes $count comprobantes de pago esperando tu revisión. Verifícalos pa\' mantener al día a tus clientes.';
  }

  @override
  String get ownerDashPrimaryCta => 'Ver comprobantes';

  @override
  String get ownerDashPrimaryCtaNone => 'Todo al día';

  @override
  String get ownerDashRecentSection => 'Últimos clientes';

  @override
  String get ownerDashRecentEmpty =>
      'Aún no tienes clientes registrados. Comparte el link de tu gym pa\' que se unan 💪';

  @override
  String get ownerDashErrorTitle => 'No pudimos cargar tu panel';

  @override
  String get ownerDashErrorBody =>
      'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get trainerDashStatClients => 'Clientes';

  @override
  String get trainerDashStatClientsSub => 'Asignados a ti';

  @override
  String get trainerDashStatSessions => 'Sesiones';

  @override
  String get trainerDashStatSessionsSub => 'Para hoy';

  @override
  String get trainerDashStatRoutines => 'Rutinas';

  @override
  String get trainerDashStatRoutinesSub => 'Activas';

  @override
  String get trainerDashPrimaryTitle => 'Sesiones de hoy';

  @override
  String trainerDashPrimaryBody(int count) {
    return 'Tienes $count sesiones programadas para hoy. ¡A darle con todo! 💪';
  }

  @override
  String get trainerDashPrimaryCta => 'Ver sesiones';

  @override
  String get trainerDashPrimaryCtaNone => 'Sin sesiones hoy';

  @override
  String get trainerDashNextSection => 'Próximas sesiones';

  @override
  String get trainerDashNextEmpty =>
      'Nada programado por ahora. Cuando tus clientes agenden, aparece aquí.';

  @override
  String get trainerDashErrorTitle => 'No pudimos cargar tu inicio';

  @override
  String get trainerDashErrorBody =>
      'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get nutriDashStatPlans => 'Planes';

  @override
  String get nutriDashStatPlansSub => 'Activos';

  @override
  String get nutriDashStatClients => 'Clientes';

  @override
  String get nutriDashStatClientsSub => 'Con plan asignado';

  @override
  String get nutriDashStatConsults => 'Consultas';

  @override
  String get nutriDashStatConsultsSub => 'Para hoy';

  @override
  String get nutriDashPrimaryTitle => 'Planes por revisar';

  @override
  String nutriDashPrimaryBody(int count) {
    return 'Tienes $count planes que necesitan tu atención. Revísalos cuando puedas 🥗';
  }

  @override
  String get nutriDashPrimaryCta => 'Ver planes';

  @override
  String get nutriDashPrimaryCtaNone => 'Todo al día';

  @override
  String get nutriDashRecentSection => 'Últimos planes';

  @override
  String get nutriDashRecentEmpty =>
      'Aún no has creado planes. Cuando lo hagas, aparecen aquí 🥗';

  @override
  String get nutriDashErrorTitle => 'No pudimos cargar tu inicio';

  @override
  String get nutriDashErrorBody =>
      'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get signalWeak =>
      'Parece que la señal está débil. Tus datos se guardan y se sincronizan solos 📶';

  @override
  String get noRoutinesYet =>
      'Aún no tienes rutinas asignadas. Cuando tu coach te arme una, aparece aquí 💪';

  @override
  String get paymentVerified =>
      '¡Pago verificado! Quedaste activo al instante ✅';

  @override
  String get paymentVerifiedSemantics =>
      'Pago verificado. Quedaste activo al instante.';

  @override
  String streakCelebrate(int days) {
    return '¡Burda! $days días seguidos 🔥';
  }

  @override
  String streakCelebrateSemantics(int days) {
    return '¡Burda! $days días seguidos.';
  }

  @override
  String get notificationsLabel => 'Notificaciones';

  @override
  String get statKcalTodayLabel => 'kcal hoy';

  @override
  String get statKcalTodaySub => 'De 2.200 kcal';

  @override
  String get statStreakLabel => 'Racha';

  @override
  String streakActive(int days) {
    return 'Vas por $days días';
  }

  @override
  String get streakIdle => 'Hoy puede ser el día 1';

  @override
  String get statNextWorkoutLabel => 'Próximo entreno';

  @override
  String get statProgressLabel => 'Progreso';

  @override
  String get statProgressValue => '68%';

  @override
  String get statProgressSub => 'Plan semanal';

  @override
  String get primaryCardTitle => 'Entreno de hoy';

  @override
  String get primaryCardAction => 'Comenzar';

  @override
  String get sectionToday => 'Hoy';

  @override
  String get hydrationTitle => 'Hidratación';

  @override
  String get hydrationSubtitle => 'Registra tu agua de hoy';

  @override
  String statKcalTodaySemantic(int value) {
    return 'Calorías de hoy: $value.';
  }

  @override
  String statStreakSemantic(int days) {
    return 'Racha de $days días.';
  }

  @override
  String statNextWorkoutSemantic(String title) {
    return 'Próximo entreno: $title.';
  }
}

/// The translations for Spanish Castilian, as used in Venezuela (`es_VE`).
class AppStringsEsVe extends AppStringsEs {
  AppStringsEsVe() : super('es_VE');

  @override
  String get appName => 'PESAO FIT';

  @override
  String get tabHome => 'Inicio';

  @override
  String get tabRoutine => 'Rutina';

  @override
  String get tabNutrition => 'Nutrición';

  @override
  String get tabProfile => 'Perfil';

  @override
  String get tabClients => 'Clientes';

  @override
  String get tabPayments => 'Pagos';

  @override
  String get tabGyms => 'Gimnasios';

  @override
  String get tabPlans => 'Planes';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonConfirm => 'Confirmar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonBack => 'Atrás';

  @override
  String get commonNext => 'Siguiente';

  @override
  String get commonSkip => 'Saltar';

  @override
  String get commonSearch => 'Buscar';

  @override
  String get commonSeeAll => 'Ver todo';

  @override
  String get commonLoading => 'Cargando…';

  @override
  String get commonStart => 'Comenzar';

  @override
  String get fabRegisterExercise => 'Registrar ejercicio';

  @override
  String get fabNewRoutine => 'Nueva rutina';

  @override
  String get fabAddClient => 'Agregar cliente';

  @override
  String get fabNewPlan => 'Nuevo plan';

  @override
  String get fabAddGym => 'Agregar gimnasio';

  @override
  String get offlineBanner =>
      'Modo sin conexión — tus datos se sincronizan solos 📶';

  @override
  String get offlineBannerSemantics =>
      'Modo sin conexión. Tus datos se sincronizan solos.';

  @override
  String get emptyGenericTitle => 'Nada por aquí todavía';

  @override
  String get emptyGenericBody => 'Cuando tengas algo, aparece en este espacio.';

  @override
  String get errorGenericTitle => 'Algo no salió bien';

  @override
  String get errorGenericBody => 'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get errorGenericButton => 'Reintentar';

  @override
  String greetingMorning(String name) {
    return '¡Buenos días, $name! 👋';
  }

  @override
  String greetingMorningSemantics(String name) {
    return 'Buenos días, $name.';
  }

  @override
  String greetingAfternoon(String name) {
    return '¡Buenas tardes, $name! 👋';
  }

  @override
  String greetingAfternoonSemantics(String name) {
    return 'Buenas tardes, $name.';
  }

  @override
  String greetingNight(String name) {
    return '¡Buenos noches, $name! 👋';
  }

  @override
  String greetingNightSemantics(String name) {
    return 'Buenas noches, $name.';
  }

  @override
  String get authEmailInvalid => 'Hmm, ese correo no parece válido 🤔';

  @override
  String get loginTitle => 'Entrar a PESAO FIT';

  @override
  String get loginSubtitle => 'Mete tus datos pa\' empezar a darle 💪';

  @override
  String get loginEmailLabel => 'Correo electrónico';

  @override
  String get loginEmailHint => 'tu@correo.com';

  @override
  String get loginPasswordLabel => 'Contraseña';

  @override
  String get loginPasswordHint => 'Mínimo 6 caracteres';

  @override
  String get loginForgot => '¿Se te olvidó la contraseña?';

  @override
  String get loginSubmit => 'Entrar';

  @override
  String get loginNoAccount => '¿No tienes cuenta?';

  @override
  String get loginSignUp => 'Regístrate aquí';

  @override
  String get loginErrorInvalid => 'Hmm, ese correo o contraseña no cuadran 🤔';

  @override
  String get loginErrorEmailUnconfirmed =>
      'Revisa tu correo, te mandamos un link pa\' confirmar 📧';

  @override
  String get loginErrorGeneric => 'Algo no cuadró, intenta de nuevo ahorita';

  @override
  String get loginValidationEmail => 'Ese correo no parece válido';

  @override
  String get loginValidationPassword =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get registerTitle => 'Crear cuenta';

  @override
  String get registerSubtitle => 'Únete a PESAO FIT y empieza a entrenar 💪';

  @override
  String get registerFullNameLabel => 'Nombre completo';

  @override
  String get registerFullNameHint => 'Tu nombre real';

  @override
  String get registerPasswordLabel => 'Contraseña';

  @override
  String get registerPasswordHint => 'Mínimo 6 caracteres';

  @override
  String get registerConfirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get registerConfirmPasswordHint => 'Repite tu contraseña';

  @override
  String get registerSubmit => 'Crear cuenta';

  @override
  String get registerHasAccount => '¿Ya tienes cuenta?';

  @override
  String get registerSignIn => 'Entra aquí';

  @override
  String get registerErrorEmailExists =>
      'Ese correo ya está registrado. ¿Quieres entrar?';

  @override
  String get registerErrorWeakPassword =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get registerErrorGeneric => 'Algo no cuadró, intenta de nuevo';

  @override
  String get registerValidationName => 'El nombre no puede estar vacío';

  @override
  String get registerValidationPasswordMismatch =>
      'Las contraseñas no coinciden';

  @override
  String get onboardingTitle => '¿Cómo quieres usar PESAO FIT?';

  @override
  String get onboardingSubtitle => 'Elige la opción que mejor te describe 👇';

  @override
  String get onboardingOwnerTitle => 'Soy dueño de gimnasio';

  @override
  String get onboardingOwnerDescription =>
      'Tengo un gym y quiero gestionar clientes, staff y pagos desde la app';

  @override
  String get onboardingClientTitle => 'Soy cliente';

  @override
  String get onboardingClientDescription =>
      'Entreno en un gym y quiero seguir mi progreso y rutinas';

  @override
  String get onboardingSkip => 'Saltar por ahora';

  @override
  String get ownerAppTitle => 'Crear mi gimnasio';

  @override
  String get ownerAppSubtitle =>
      'Cuéntanos sobre ti y tu gym para verificar tu cuenta 🏋️';

  @override
  String get ownerAppPersonalSection => 'Tus datos';

  @override
  String get ownerAppPhoneLabel => 'Teléfono';

  @override
  String get ownerAppPhoneHint => '0412-1234567';

  @override
  String get ownerAppDocumentLabel => 'Cédula o RIF (opcional)';

  @override
  String get ownerAppDocumentHint => 'V-12345678 o J-12345678-9';

  @override
  String get ownerAppGymSection => 'Datos del gimnasio';

  @override
  String get ownerAppGymNameLabel => 'Nombre del gimnasio';

  @override
  String get ownerAppGymNameHint => 'Ej: Gym Pesao';

  @override
  String get ownerAppGymRifLabel => 'RIF del negocio (opcional)';

  @override
  String get ownerAppGymRifHint => 'J-12345678-9';

  @override
  String get ownerAppGymAddressLabel => 'Dirección completa';

  @override
  String get ownerAppGymAddressHint => 'Av. Lara, C.C. Cosmo, Local 12';

  @override
  String get ownerAppGymStateLabel => 'Estado';

  @override
  String get ownerAppGymCityLabel => 'Ciudad';

  @override
  String get ownerAppGymCityHint => 'Ej: Barquisimeto';

  @override
  String get ownerAppGymPhoneLabel => 'Teléfono del gimnasio';

  @override
  String get ownerAppGymPhoneHint => '0251-1234567';

  @override
  String get ownerAppGymInstagramLabel => 'Instagram (opcional)';

  @override
  String get ownerAppGymInstagramHint => '@gym_pesao';

  @override
  String get ownerAppGymDescriptionLabel => 'Descripción (opcional)';

  @override
  String get ownerAppGymDescriptionHint =>
      'Cuéntanos sobre tu gym en pocas líneas';

  @override
  String get ownerAppGymPhotoLabel => 'Foto del local (opcional)';

  @override
  String get ownerAppGymPhotoButton => 'Agregar foto';

  @override
  String get ownerAppGymLocationButton => 'Usar mi ubicación';

  @override
  String get ownerAppSubmit => 'Enviar solicitud';

  @override
  String get ownerAppValidationErrorPhone =>
      'El teléfono debe tener formato venezolano';

  @override
  String get ownerAppValidationErrorGymName =>
      'El nombre del gimnasio no puede estar vacío';

  @override
  String get ownerAppValidationErrorAddress =>
      'La dirección no puede estar vacía';

  @override
  String get ownerAppValidationErrorState => 'Debes seleccionar un estado';

  @override
  String get ownerAppValidationErrorCity => 'La ciudad no puede estar vacía';

  @override
  String get ownerAppSuccessTitle => '¡Solicitud enviada! 🎉';

  @override
  String get ownerAppSuccessMessage =>
      'Recibimos tu solicitud. Te contactaremos en 24-48h para verificar tu gym. 📞';

  @override
  String get ownerAppSuccessBack => 'Volver al inicio';

  @override
  String get gymDiscoveryTitle => 'Encuentra tu gimnasio';

  @override
  String get gymDiscoverySubtitle => 'Busca el gym donde entrenas y únete 💪';

  @override
  String get gymDiscoverySearchHint => 'Buscar por nombre...';

  @override
  String get gymDiscoveryEmpty =>
      'No encontramos gimnasios con ese nombre. Intenta con otro 🤔';

  @override
  String get gymDiscoveryJoin => 'Unirme';

  @override
  String gymDiscoveryJoinTitle(String name) {
    return '¿Unirte a $name?';
  }

  @override
  String get gymDiscoveryJoinMessage =>
      'Al unirte, tu gimnasio podrá ver tu progreso y asignarte rutinas.';

  @override
  String get gymDiscoveryJoinConfirm => 'Sí, unirme';

  @override
  String get gymDiscoveryJoinSuccess => '¡Ya eres parte del gym! Bienvenido 💪';

  @override
  String get adminAppsTitle => 'Solicitudes de gimnasios';

  @override
  String get adminAppsSubtitle => 'Revisa y aprueba los nuevos gimnasios 🏋️';

  @override
  String get adminAppsEmpty =>
      'No hay solicitudes pendientes. Cuando un dueño se registre, aparece aquí.';

  @override
  String get adminAppsSubmitted => 'Enviado';

  @override
  String get adminAppsOwnerSection => 'Datos del dueño';

  @override
  String get adminAppsGymSection => 'Datos del gimnasio';

  @override
  String get adminAppsApprove => 'Aprobar';

  @override
  String get adminAppsReject => 'Rechazar';

  @override
  String adminAppsApproveTitle(String name) {
    return '¿Aprobar $name?';
  }

  @override
  String get adminAppsApproveMessage =>
      'Se creará el gimnasio, la membresía del dueño y la suscripción Pluma por 1 año.';

  @override
  String get adminAppsRejectTitle => 'Rechazar solicitud';

  @override
  String get adminAppsRejectReasonLabel => 'Motivo del rechazo';

  @override
  String get adminAppsRejectReasonHint =>
      'Cuéntale al dueño por qué no fue aprobado...';

  @override
  String get adminAppsApproveSuccess =>
      '¡Gimnasio aprobado! El dueño ya puede entrar 🎉';

  @override
  String get adminAppsRejectSuccess =>
      'Solicitud rechazada. El dueño verá el motivo.';

  @override
  String get adminAppsError => 'No pudimos cargar las solicitudes';

  @override
  String get adminAppsFieldPhone => 'Teléfono';

  @override
  String get adminAppsFieldDocument => 'Documento';

  @override
  String get adminAppsFieldAddress => 'Dirección';

  @override
  String get adminAppsFieldCity => 'Ciudad';

  @override
  String get adminAppsFieldState => 'Estado';

  @override
  String get adminAppsFieldInstagram => 'Instagram';

  @override
  String get adminAppsFieldDescription => 'Descripción';

  @override
  String get adminAppsFieldRif => 'RIF';

  @override
  String get adminDashStatGyms => 'Gimnasios';

  @override
  String get adminDashStatGymsSub => 'Activos en la red';

  @override
  String get adminDashStatPending => 'Pendientes';

  @override
  String get adminDashStatPendingSub => 'Por revisar';

  @override
  String get adminDashStatSubs => 'Suscripciones';

  @override
  String get adminDashStatSubsSub => 'Planes activos';

  @override
  String get adminDashPrimaryTitle => 'Solicitudes por revisar';

  @override
  String adminDashPrimaryBody(int count) {
    return 'Tienes $count gimnasios esperando tu revisión. Llamar o visitar antes de aprobar.';
  }

  @override
  String get adminDashPrimaryCta => 'Ver solicitudes';

  @override
  String get adminDashPrimaryCtaNone => 'Todo al día';

  @override
  String get adminDashRecentSection => 'Últimos gimnasios aprobados';

  @override
  String get adminDashRecentEmpty => 'Aún no hay gimnasios aprobados';

  @override
  String get adminDashErrorTitle => 'No pudimos cargar tu panel';

  @override
  String get adminDashErrorBody =>
      'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get adminDashEmptyTitle => 'Todo tranquilo por aquí';

  @override
  String get adminDashEmptyBody =>
      'Cuando se registren gimnasios, los números aparecen aquí.';

  @override
  String get clientDashStatKcal => 'kcal hoy';

  @override
  String get clientDashStatKcalSub => 'Meta: 2.200';

  @override
  String get clientDashStatStreak => 'Racha';

  @override
  String get clientDashStatStreakSub => 'días seguidos';

  @override
  String get clientDashStatNext => 'Próximo';

  @override
  String get clientDashStatNextSub => 'entreno';

  @override
  String get clientDashPrimaryTitle => 'Entreno de hoy';

  @override
  String get clientDashPrimaryBody =>
      'Tu coach aún no te asigna una rutina. Cuando lo haga, aparece aquí para que empieces 💪';

  @override
  String get clientDashPrimaryCta => 'Comenzar';

  @override
  String get clientDashPrimaryCtaNone => 'Sin entreno hoy';

  @override
  String get clientDashTodaySection => 'Hoy';

  @override
  String get clientDashTodayEmpty =>
      'Nada programado para hoy. Aprovecha de descansar o hidrátate 💧';

  @override
  String get clientDashErrorTitle => 'No pudimos cargar tu inicio';

  @override
  String get clientDashErrorBody =>
      'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get ownerDashStatClients => 'Clientes';

  @override
  String get ownerDashStatClientsSub => 'Activos en tu gym';

  @override
  String get ownerDashStatPayments => 'Pagos';

  @override
  String get ownerDashStatPaymentsSub => 'Por verificar';

  @override
  String get ownerDashStatIncome => 'Ingresos';

  @override
  String get ownerDashStatIncomeSub => 'Este mes (Bs)';

  @override
  String get ownerDashPrimaryTitle => 'Comprobantes por verificar';

  @override
  String ownerDashPrimaryBody(int count) {
    return 'Tienes $count comprobantes de pago esperando tu revisión. Verifícalos pa\' mantener al día a tus clientes.';
  }

  @override
  String get ownerDashPrimaryCta => 'Ver comprobantes';

  @override
  String get ownerDashPrimaryCtaNone => 'Todo al día';

  @override
  String get ownerDashRecentSection => 'Últimos clientes';

  @override
  String get ownerDashRecentEmpty =>
      'Aún no tienes clientes registrados. Comparte el link de tu gym pa\' que se unan 💪';

  @override
  String get ownerDashErrorTitle => 'No pudimos cargar tu panel';

  @override
  String get ownerDashErrorBody =>
      'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get trainerDashStatClients => 'Clientes';

  @override
  String get trainerDashStatClientsSub => 'Asignados a ti';

  @override
  String get trainerDashStatSessions => 'Sesiones';

  @override
  String get trainerDashStatSessionsSub => 'Para hoy';

  @override
  String get trainerDashStatRoutines => 'Rutinas';

  @override
  String get trainerDashStatRoutinesSub => 'Activas';

  @override
  String get trainerDashPrimaryTitle => 'Sesiones de hoy';

  @override
  String trainerDashPrimaryBody(int count) {
    return 'Tienes $count sesiones programadas para hoy. ¡A darle con todo! 💪';
  }

  @override
  String get trainerDashPrimaryCta => 'Ver sesiones';

  @override
  String get trainerDashPrimaryCtaNone => 'Sin sesiones hoy';

  @override
  String get trainerDashNextSection => 'Próximas sesiones';

  @override
  String get trainerDashNextEmpty =>
      'Nada programado por ahora. Cuando tus clientes agenden, aparece aquí.';

  @override
  String get trainerDashErrorTitle => 'No pudimos cargar tu inicio';

  @override
  String get trainerDashErrorBody =>
      'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get nutriDashStatPlans => 'Planes';

  @override
  String get nutriDashStatPlansSub => 'Activos';

  @override
  String get nutriDashStatClients => 'Clientes';

  @override
  String get nutriDashStatClientsSub => 'Con plan asignado';

  @override
  String get nutriDashStatConsults => 'Consultas';

  @override
  String get nutriDashStatConsultsSub => 'Para hoy';

  @override
  String get nutriDashPrimaryTitle => 'Planes por revisar';

  @override
  String nutriDashPrimaryBody(int count) {
    return 'Tienes $count planes que necesitan tu atención. Revísalos cuando puedas 🥗';
  }

  @override
  String get nutriDashPrimaryCta => 'Ver planes';

  @override
  String get nutriDashPrimaryCtaNone => 'Todo al día';

  @override
  String get nutriDashRecentSection => 'Últimos planes';

  @override
  String get nutriDashRecentEmpty =>
      'Aún no has creado planes. Cuando lo hagas, aparecen aquí 🥗';

  @override
  String get nutriDashErrorTitle => 'No pudimos cargar tu inicio';

  @override
  String get nutriDashErrorBody =>
      'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get signalWeak =>
      'Parece que la señal está débil. Tus datos se guardan y se sincronizan solos 📶';

  @override
  String get noRoutinesYet =>
      'Aún no tienes rutinas asignadas. Cuando tu coach te arme una, aparece aquí 💪';

  @override
  String get paymentVerified =>
      '¡Pago verificado! Quedaste activo al instante ✅';

  @override
  String get paymentVerifiedSemantics =>
      'Pago verificado. Quedaste activo al instante.';

  @override
  String streakCelebrate(int days) {
    return '¡Burda! $days días seguidos 🔥';
  }

  @override
  String streakCelebrateSemantics(int days) {
    return '¡Burda! $days días seguidos.';
  }

  @override
  String get notificationsLabel => 'Notificaciones';

  @override
  String get statKcalTodayLabel => 'kcal hoy';

  @override
  String get statKcalTodaySub => 'De 2.200 kcal';

  @override
  String get statStreakLabel => 'Racha';

  @override
  String streakActive(int days) {
    return 'Vas por $days días';
  }

  @override
  String get streakIdle => 'Hoy puede ser el día 1';

  @override
  String get statNextWorkoutLabel => 'Próximo entreno';

  @override
  String get statProgressLabel => 'Progreso';

  @override
  String get statProgressValue => '68%';

  @override
  String get statProgressSub => 'Plan semanal';

  @override
  String get primaryCardTitle => 'Entreno de hoy';

  @override
  String get primaryCardAction => 'Comenzar';

  @override
  String get sectionToday => 'Hoy';

  @override
  String get hydrationTitle => 'Hidratación';

  @override
  String get hydrationSubtitle => 'Registra tu agua de hoy';

  @override
  String statKcalTodaySemantic(int value) {
    return 'Calorías de hoy: $value.';
  }

  @override
  String statStreakSemantic(int days) {
    return 'Racha de $days días.';
  }

  @override
  String statNextWorkoutSemantic(String title) {
    return 'Próximo entreno: $title.';
  }
}
