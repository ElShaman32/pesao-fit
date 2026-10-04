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
  String get staffScreenTitle => 'Mi equipo';

  @override
  String get staffRoleTrainer => 'Entrenador';

  @override
  String get staffRoleNutritionist => 'Nutricionista';

  @override
  String get staffStatusActive => 'Activo';

  @override
  String get staffStatusInactive => 'Inactivo';

  @override
  String get staffActionActivate => 'Activar';

  @override
  String get staffActionDeactivate => 'Desactivar';

  @override
  String get staffLimitTitle => 'Cupos del equipo';

  @override
  String get staffLimitUnlimited => 'Cupos ilimitados';

  @override
  String get staffLimitNearLimit => '¡Casi al límite!';

  @override
  String get staffEmptyTitle => 'Aún no tienes equipo';

  @override
  String get staffEmptyBody =>
      'Invita a tu primer entrenador o nutricionista y empieza a mover tu gimnasio 💪';

  @override
  String get staffErrorTitle => 'No se pudo cargar el equipo';

  @override
  String get staffErrorBody => 'Revisa tu conexión e intenta de nuevo';

  @override
  String get staffDeactivateConfirmTitle => '¿Desactivar a esta persona?';

  @override
  String get staffDeactivateConfirmBody =>
      'Dejará de aparecer como parte activa del equipo.';

  @override
  String get staffActivateConfirmTitle => '¿Activar a esta persona?';

  @override
  String get staffActivateConfirmBody =>
      'Volverá a aparecer como parte activa del equipo.';

  @override
  String get staffDeactivatedSuccess => 'Miembro desactivado';

  @override
  String get staffActivatedSuccess => 'Miembro activado';

  @override
  String get staffActionError => 'No se pudo completar la acción';

  @override
  String get fabAddStaff => 'Agregar miembro del equipo';

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

  @override
  String get staffAddTitle => 'Agregar miembro';

  @override
  String get staffAddNameLabel => 'Nombre completo';

  @override
  String get staffAddNameHint => 'Ej: María Pérez';

  @override
  String get staffAddNameError => 'El nombre es obligatorio';

  @override
  String get staffAddEmailLabel => 'Correo electrónico';

  @override
  String get staffAddEmailHint => 'correo@ejemplo.com';

  @override
  String get staffAddEmailErrorEmpty => 'El correo es obligatorio';

  @override
  String get staffAddEmailErrorInvalid => 'Ese correo no parece válido';

  @override
  String get staffAddRoleLabel => 'Rol';

  @override
  String get staffAddPasswordLabel => 'Contraseña temporal';

  @override
  String get staffAddPasswordHint => 'Se genera automáticamente';

  @override
  String get staffAddPasswordError => 'Mínimo 6 caracteres';

  @override
  String get staffAddPasswordRegenerate => 'Generar otra contraseña';

  @override
  String get staffAddSubmit => 'Invitar al equipo';

  @override
  String get staffAddSubmitting => 'Invitando...';

  @override
  String get staffAddSuccessTitle => '¡Miembro invitado!';

  @override
  String get staffAddSuccessBody =>
      'Comparte estos datos con tu nuevo miembro del equipo. La contraseña solo se muestra una vez.';

  @override
  String get staffAddCredentialEmail => 'Correo';

  @override
  String get staffAddCredentialPassword => 'Contraseña temporal';

  @override
  String get staffAddCopyTooltip => 'Copiar contraseña';

  @override
  String get staffAddCopied => 'Contraseña copiada ✅';

  @override
  String get staffAddCopiedSemantics => 'Contraseña copiada';

  @override
  String get staffAddDone => 'Listo, volver al equipo';

  @override
  String get staffAddNoGym => 'No tienes un gimnasio asignado.';

  @override
  String get staffAddNoGymSemantics => 'Error de gimnasio asignado';

  @override
  String get clientsScreenTitle => 'Clientes';

  @override
  String get clientsStatActive => 'Activos';

  @override
  String get clientsStatActiveSub => 'En tu gimnasio';

  @override
  String get clientsLimitTitle => 'Cupos de clientes';

  @override
  String get clientsLimitUnlimited => 'Clientes ilimitados';

  @override
  String get clientsLimitNearLimit => '¡Casi al límite!';

  @override
  String get clientsEmptyTitle => 'Aún no tienes clientes';

  @override
  String get clientsEmptyBody =>
      'Cuando alguien se una a tu gimnasio, aparece aquí 💪';

  @override
  String get clientsErrorTitle => 'No se pudo cargar los clientes';

  @override
  String get clientsErrorBody => 'Revisa tu conexión e intenta de nuevo';

  @override
  String get clientsSearchHint => 'Buscar por nombre...';

  @override
  String get clientDetailTitle => 'Detalle del cliente';

  @override
  String get clientDetailJoined => 'Miembro desde';

  @override
  String get clientDetailStatusActive => 'Activo';

  @override
  String get clientDetailStatusInactive => 'Inactivo';

  @override
  String get clientDetailDeactivate => 'Desactivar membresía';

  @override
  String get clientDetailActivate => 'Activar membresía';

  @override
  String get clientDetailDeactivateConfirmTitle => '¿Desactivar este cliente?';

  @override
  String get clientDetailDeactivateConfirmBody =>
      'El cliente perderá acceso a la app hasta que lo actives de nuevo.';

  @override
  String get clientDetailActivateConfirmTitle => '¿Activar este cliente?';

  @override
  String get clientDetailActivateConfirmBody =>
      'El cliente recuperará el acceso a la app.';

  @override
  String get clientDeactivatedSuccess => 'Cliente desactivado';

  @override
  String get clientActivatedSuccess => 'Cliente activado';

  @override
  String get clientAddTitle => 'Agregar cliente';

  @override
  String get clientAddNameLabel => 'Nombre completo';

  @override
  String get clientAddNameHint => 'Ej: Carlos Rodríguez';

  @override
  String get clientAddNameError => 'El nombre es obligatorio';

  @override
  String get clientAddEmailLabel => 'Correo electrónico';

  @override
  String get clientAddEmailHint => 'correo@ejemplo.com';

  @override
  String get clientAddEmailErrorEmpty => 'El correo es obligatorio';

  @override
  String get clientAddEmailErrorInvalid => 'Ese correo no parece válido';

  @override
  String get clientAddPasswordLabel => 'Contraseña temporal';

  @override
  String get clientAddPasswordHint => 'Se genera automáticamente';

  @override
  String get clientAddPasswordError => 'Mínimo 6 caracteres';

  @override
  String get clientAddPasswordRegenerate => 'Generar otra contraseña';

  @override
  String get clientAddSubmit => 'Agregar cliente';

  @override
  String get clientAddSubmitting => 'Agregando...';

  @override
  String get clientAddSuccessTitle => '¡Cliente agregado!';

  @override
  String get clientAddSuccessBody =>
      'Comparte estos datos con tu cliente. La contraseña solo se muestra una vez.';

  @override
  String get clientAddCredentialEmail => 'Correo';

  @override
  String get clientAddCredentialPassword => 'Contraseña temporal';

  @override
  String get clientAddCopyTooltip => 'Copiar contraseña';

  @override
  String get clientAddCopied => 'Contraseña copiada ✅';

  @override
  String get clientAddCopiedSemantics => 'Contraseña copiada';

  @override
  String get clientAddDone => 'Listo, volver a clientes';

  @override
  String get clientAddNoGym => 'No tienes un gimnasio asignado.';

  @override
  String get clientAddNoGymSemantics => 'Error de gimnasio asignado';

  @override
  String get clientAddLimitReached =>
      'Ya llegaste al límite de clientes de tu plan. Actualiza a Hierro para agregar más.';

  @override
  String get paymentsScreenTitle => 'Pagos';

  @override
  String get paymentsFilterPending => 'Pendientes';

  @override
  String get paymentsFilterVerified => 'Verificados';

  @override
  String get paymentsFilterRejected => 'Rechazados';

  @override
  String get paymentsEmptyPendingTitle => 'Sin comprobantes pendientes';

  @override
  String get paymentsEmptyPendingBody =>
      'Cuando un cliente suba un pago, aparece aquí.';

  @override
  String get paymentsEmptyVerifiedTitle => 'Nada verificado todavía';

  @override
  String get paymentsEmptyVerifiedBody => 'Los pagos aprobados aparecen aquí.';

  @override
  String get paymentsEmptyRejectedTitle => 'Nada rechazado';

  @override
  String get paymentsEmptyRejectedBody => 'Los pagos rechazados aparecen aquí.';

  @override
  String get paymentsErrorTitle => 'No pudimos cargar los pagos';

  @override
  String get paymentsErrorBody => 'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get paymentsOfflineEmpty =>
      'Sin conexión. Los pagos se revisan cuando vuelva la señal.';

  @override
  String get paymentDetailTitle => 'Detalle del pago';

  @override
  String get paymentDetailClient => 'Cliente';

  @override
  String get paymentDetailAmountUsd => 'Monto USD';

  @override
  String get paymentDetailAmountBs => 'Monto Bs';

  @override
  String get paymentDetailRate => 'Tasa usada';

  @override
  String get paymentDetailDate => 'Fecha';

  @override
  String get paymentDetailReceipt => 'Comprobante';

  @override
  String get paymentDetailApprove => 'Aprobar';

  @override
  String get paymentDetailReject => 'Rechazar';

  @override
  String get paymentApproveConfirmTitle => '¿Aprobar este pago?';

  @override
  String get paymentApproveConfirmBody =>
      'El cliente quedará activo y el pago marcado como verificado.';

  @override
  String get paymentRejectDialogTitle => 'Rechazar pago';

  @override
  String get paymentRejectDialogBody =>
      'Cuéntale al cliente por qué no pudiste aprobarlo.';

  @override
  String get paymentRejectReasonLabel => 'Motivo del rechazo';

  @override
  String get paymentRejectReasonHint => 'Ej: la imagen está borrosa';

  @override
  String get paymentRejectReasonError => 'Escribe un motivo';

  @override
  String get paymentApprovedSuccess => 'Pago aprobado ✅';

  @override
  String get paymentApprovedSemantics => 'Pago aprobado';

  @override
  String get paymentRejectedSuccess => 'Pago rechazado';

  @override
  String get paymentRejectedSemantics => 'Pago rechazado';

  @override
  String get paymentActionError => 'No pudimos completar la acción';

  @override
  String get paymentStatusPending => 'Pendiente';

  @override
  String get paymentStatusVerified => 'Verificado';

  @override
  String get paymentStatusRejected => 'Rechazado';

  @override
  String get paymentsFabRegister => 'Registrar pago';

  @override
  String get uploadPaymentTitle => 'Subir pago';

  @override
  String get uploadPaymentSubtitle =>
      'Registra tu pago manual (Pago Móvil o transferencia). Lo verificamos en menos de 24h.';

  @override
  String get uploadPaymentAmountBsLabel => 'Monto en Bs';

  @override
  String get uploadPaymentAmountBsHint => 'Ej: 15000';

  @override
  String get uploadPaymentAmountBsError => 'El monto debe ser mayor a cero';

  @override
  String get uploadPaymentAmountUsdLabel => 'Monto en USD';

  @override
  String get uploadPaymentAmountUsdHint =>
      'Se calcula con la tasa del gimnasio';

  @override
  String get uploadPaymentRateLabel => 'Tasa usada';

  @override
  String get uploadPaymentRateError => 'No hay tasa configurada en tu gimnasio';

  @override
  String get uploadPaymentPickImage => 'Tomar o elegir foto del comprobante';

  @override
  String get uploadPaymentPickImageError =>
      'Necesitamos una foto del comprobante';

  @override
  String get uploadPaymentReplaceImage => 'Cambiar foto';

  @override
  String get uploadPaymentSubmit => 'Enviar comprobante';

  @override
  String get uploadPaymentSubmitting => 'Subiendo...';

  @override
  String get uploadPaymentSuccessTitle => '¡Pago enviado! 📩';

  @override
  String get uploadPaymentSuccessBody =>
      'Tu comprobante está en revisión. Te avisamos cuando lo aprobemos.';

  @override
  String get uploadPaymentSuccessSemantics => 'Pago enviado, en revisión';

  @override
  String get uploadPaymentErrorTitle => 'No pudimos subir tu pago';

  @override
  String get uploadPaymentErrorSemantics => 'Error al subir el pago';

  @override
  String get uploadPaymentNoRateTitle =>
      'Tu gimnasio no tiene tasa configurada';

  @override
  String get uploadPaymentNoRateBody =>
      'Pídele al dueño que configure la tasa del día para poder subir pagos.';

  @override
  String get clientDashPrimaryCtaUpload => 'Subir pago';

  @override
  String get clientDashPrimaryUploadTitle => 'Tu mensualidad';

  @override
  String get clientDashPrimaryUploadBody =>
      'Sube el comprobante de tu pago para seguir activo en el gimnasio.';

  @override
  String get clientDashUploadFab => 'Subir pago';

  @override
  String get plansScreenTitle => 'Planes del gimnasio';

  @override
  String get plansEmptyTitle => 'Aún no tienes planes';

  @override
  String get plansEmptyBody =>
      'Crea tu primer plan para que tus clientes elijan cuánto pagar 💪';

  @override
  String get plansCreateFab => 'Crear plan';

  @override
  String get plansErrorTitle => 'No pudimos cargar los planes';

  @override
  String get plansErrorBody => 'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get planFormCreateTitle => 'Crear plan';

  @override
  String get planFormEditTitle => 'Editar plan';

  @override
  String get planFormNameLabel => 'Nombre del plan';

  @override
  String get planFormNameHint => 'Ej: Con Coach';

  @override
  String get planFormNameError => 'El nombre es obligatorio';

  @override
  String get planFormDescriptionLabel => 'Descripción (opcional)';

  @override
  String get planFormDescriptionHint => 'Qué incluye este plan';

  @override
  String get planFormPriceLabel => 'Precio en USD';

  @override
  String get planFormPriceHint => 'Ej: 30';

  @override
  String get planFormPriceError => 'El precio debe ser mayor a cero';

  @override
  String get planFormDurationLabel => 'Duración (días)';

  @override
  String get planFormDurationHint => 'Ej: 30';

  @override
  String get planFormDurationError => 'La duración debe ser al menos 1 día';

  @override
  String get planFormIncludesTrainer => 'Incluye entrenador personal';

  @override
  String get planFormIncludesNutritionist => 'Incluye nutricionista';

  @override
  String get planFormSubmit => 'Guardar plan';

  @override
  String get planFormSubmitting => 'Guardando...';

  @override
  String get planCreatedSuccess => 'Plan creado ✅';

  @override
  String get planCreatedSemantics => 'Plan creado';

  @override
  String get planUpdatedSuccess => 'Plan actualizado ✅';

  @override
  String get planUpdatedSemantics => 'Plan actualizado';

  @override
  String get planLimitReachedTitle => 'Límite de planes alcanzado';

  @override
  String get planLimitReachedBody =>
      'Tu plan actual no permite más planes. Actualiza a Hierro para crear más.';

  @override
  String get planDeactivateConfirmTitle => '¿Desactivar este plan?';

  @override
  String get planDeactivateConfirmBody =>
      'Los clientes actuales lo mantienen, pero no se podrá asignar a nuevos clientes.';

  @override
  String get planDeactivatedSuccess => 'Plan desactivado';

  @override
  String get planDeactivatedSemantics => 'Plan desactivado';

  @override
  String get planActiveBadge => 'Activo';

  @override
  String get planInactiveBadge => 'Inactivo';

  @override
  String get planPerMonth => '/mes';

  @override
  String planDurationDays(Object days) {
    return '$days días';
  }

  @override
  String get subscriptionCardTitle => 'Tu plan';

  @override
  String get subscriptionCardNoPlanTitle => 'Sin plan asignado';

  @override
  String get subscriptionCardNoPlanBody =>
      'Tu gimnasio aún no te asigna un plan. Pregúntale al dueño 💪';

  @override
  String get subscriptionBalanceOwed => 'Debes';

  @override
  String get subscriptionBalancePaid => 'Estás al día';

  @override
  String get subscriptionBalanceCredit => 'Tienes a favor';

  @override
  String get subscriptionExpiresLabel => 'Vence';

  @override
  String get subscriptionPayCta => 'Pagar';

  @override
  String get subscriptionStatusActive => 'Activo';

  @override
  String get subscriptionStatusExpired => 'Vencido';

  @override
  String get subscriptionStatusSuspended => 'Suspendido';

  @override
  String get assignPlanTitle => 'Asignar plan';

  @override
  String get assignPlanSubtitle => 'Elige el plan para este cliente';

  @override
  String get assignPlanNoPlansTitle => 'No tienes planes creados';

  @override
  String get assignPlanNoPlansBody =>
      'Primero crea un plan en la sección de planes.';

  @override
  String get assignPlanConfirm => 'Asignar';

  @override
  String get assignPlanSuccess => 'Plan asignado ✅';

  @override
  String get assignPlanSemantics => 'Plan asignado';

  @override
  String get assignPlanCurrentLabel => 'Plan actual';

  @override
  String get assignPlanChangeCta => 'Cambiar plan';

  @override
  String get assignPlanAssignCta => 'Asignar plan';

  @override
  String get uploadPaymentPlanLabel => 'Plan';

  @override
  String get uploadPaymentBalanceLabel => 'Saldo pendiente';

  @override
  String get uploadPaymentCreditLabel => 'Saldo a favor';

  @override
  String get ownerClientPlanSection => 'Plan del cliente';

  @override
  String get ownerClientNoPlan => 'Sin plan asignado';

  @override
  String get exercisesScreenTitle => 'Ejercicios';

  @override
  String get exercisesSearchHint => 'Buscar ejercicio...';

  @override
  String get exercisesEmptyTitle => 'Aún no hay ejercicios';

  @override
  String get exercisesEmptyBody =>
      'Crea tu primer ejercicio personalizado o usa la biblioteca base 💪';

  @override
  String get exercisesErrorTitle => 'No pudimos cargar los ejercicios';

  @override
  String get exercisesErrorBody =>
      'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get exercisesGlobalBadge => 'Biblioteca';

  @override
  String get exercisesCustomBadge => 'Del gym';

  @override
  String get exerciseFormCreateTitle => 'Crear ejercicio';

  @override
  String get exerciseFormEditTitle => 'Editar ejercicio';

  @override
  String get exerciseFormNameLabel => 'Nombre del ejercicio';

  @override
  String get exerciseFormNameHint => 'Ej: Sentadilla búlgara';

  @override
  String get exerciseFormNameError => 'El nombre es obligatorio';

  @override
  String get exerciseFormDescriptionLabel => 'Descripción (opcional)';

  @override
  String get exerciseFormDescriptionHint => 'Cómo se hace, qué trabaja';

  @override
  String get exerciseFormMuscleGroupLabel => 'Grupo muscular';

  @override
  String get exerciseFormSubmit => 'Guardar ejercicio';

  @override
  String get exerciseFormSubmitting => 'Guardando...';

  @override
  String get exerciseCreatedSuccess => 'Ejercicio creado ✅';

  @override
  String get exerciseCreatedSemantics => 'Ejercicio creado';

  @override
  String get exerciseUpdatedSuccess => 'Ejercicio actualizado ✅';

  @override
  String get exerciseUpdatedSemantics => 'Ejercicio actualizado';

  @override
  String get routinesScreenTitle => 'Rutinas';

  @override
  String get routinesEmptyTitle => 'Aún no tienes rutinas';

  @override
  String get routinesEmptyBody => 'Crea la primera rutina para tus clientes 💪';

  @override
  String get routinesErrorTitle => 'No pudimos cargar las rutinas';

  @override
  String get routinesErrorBody => 'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get routineFormCreateTitle => 'Nueva rutina';

  @override
  String get routineFormEditTitle => 'Editar rutina';

  @override
  String get routineFormNameLabel => 'Nombre de la rutina';

  @override
  String get routineFormNameHint => 'Ej: Tren superior - Día 1';

  @override
  String get routineFormNameError => 'El nombre es obligatorio';

  @override
  String get routineFormDescriptionLabel => 'Descripción (opcional)';

  @override
  String get routineFormDescriptionHint => 'Objetivo de la rutina';

  @override
  String get routineFormClientLabel => 'Cliente';

  @override
  String get routineFormClientError => 'Selecciona un cliente';

  @override
  String get routineFormExercisesLabel => 'Ejercicios';

  @override
  String get routineFormAddExercise => 'Agregar ejercicio';

  @override
  String get routineFormNoExercises => 'Agrega al menos un ejercicio';

  @override
  String get routineFormSubmit => 'Guardar rutina';

  @override
  String get routineFormSubmitting => 'Guardando...';

  @override
  String get routineCreatedSuccess => 'Rutina creada ✅';

  @override
  String get routineCreatedSemantics => 'Rutina creada';

  @override
  String get routineUpdatedSuccess => 'Rutina actualizada ✅';

  @override
  String get routineUpdatedSemantics => 'Rutina actualizada';

  @override
  String get routineExerciseSets => 'Series';

  @override
  String get routineExerciseReps => 'Reps';

  @override
  String get routineExerciseWeight => 'Peso (kg)';

  @override
  String get routineExerciseRest => 'Descanso (seg)';

  @override
  String get routineExerciseNotes => 'Notas';

  @override
  String get muscleGroupChest => 'Pecho';

  @override
  String get muscleGroupBack => 'Espalda';

  @override
  String get muscleGroupShoulders => 'Hombros';

  @override
  String get muscleGroupBiceps => 'Bíceps';

  @override
  String get muscleGroupTriceps => 'Tríceps';

  @override
  String get muscleGroupLegs => 'Piernas';

  @override
  String get muscleGroupGlutes => 'Glúteos';

  @override
  String get muscleGroupCore => 'Core';

  @override
  String get muscleGroupCardio => 'Cardio';

  @override
  String get muscleGroupFullBody => 'Full body';

  @override
  String get muscleGroupAll => 'Todos';

  @override
  String get fabCreateExercise => 'Crear ejercicio';

  @override
  String get fabCreateRoutine => 'Nueva rutina';

  @override
  String get clientRoutineScreenTitle => 'Mi rutina';

  @override
  String get clientRoutineEmptyTitle => 'Sin rutina asignada';

  @override
  String get clientRoutineEmptyBody =>
      'Tu entrenador aún no te asigna una rutina. Cuando lo haga, aparece aquí 💪';

  @override
  String get clientRoutineErrorTitle => 'No pudimos cargar tu rutina';

  @override
  String get clientRoutineErrorBody =>
      'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String clientRoutineExerciseCount(Object count) {
    return '$count ejercicios';
  }

  @override
  String clientRoutineExerciseSets(Object sets) {
    return '$sets series';
  }

  @override
  String clientRoutineExerciseReps(Object reps) {
    return '$reps reps';
  }

  @override
  String clientRoutineExerciseWeight(Object weight) {
    return '$weight kg';
  }

  @override
  String clientRoutineExerciseRest(Object rest) {
    return '${rest}s descanso';
  }

  @override
  String get clientRoutineExerciseNotes => 'Notas';

  @override
  String get clientDashPrimaryRoutineTitle => 'Tu rutina';

  @override
  String clientDashPrimaryRoutineBody(Object count) {
    return 'Tienes $count ejercicios por hacer hoy';
  }

  @override
  String get clientDashPrimaryRoutineCta => 'Ver rutina';

  @override
  String get clientDashPrimaryRoutineCtaNone => 'Sin rutina';

  @override
  String get plansTabTitle => 'Planes';

  @override
  String get routinesTabTitle => 'Rutinas';

  @override
  String get trainingPlansScreenTitle => 'Planes de entrenamiento';

  @override
  String get trainingPlansEmptyTitle => 'Aún no tienes planes';

  @override
  String get trainingPlansEmptyBody =>
      'Crea un plan semanal para tus clientes y olvídate de asignar rutinas a diario 💪';

  @override
  String get trainingPlansErrorTitle => 'No pudimos cargar los planes';

  @override
  String get trainingPlansErrorBody =>
      'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get trainingPlanFormCreateTitle => 'Nuevo plan';

  @override
  String get trainingPlanFormEditTitle => 'Editar plan';

  @override
  String get trainingPlanFormNameLabel => 'Nombre del plan';

  @override
  String get trainingPlanFormNameHint => 'Ej: Plan de Juan - Mes 1';

  @override
  String get trainingPlanFormNameError => 'El nombre es obligatorio';

  @override
  String get trainingPlanFormDescriptionLabel => 'Descripción (opcional)';

  @override
  String get trainingPlanFormDescriptionHint => 'Objetivo del plan';

  @override
  String get trainingPlanFormClientLabel => 'Cliente';

  @override
  String get trainingPlanFormClientError => 'Selecciona un cliente';

  @override
  String get trainingPlanFormSubmit => 'Guardar plan';

  @override
  String get trainingPlanFormSubmitting => 'Guardando...';

  @override
  String get trainingPlanCreatedSuccess => 'Plan creado ✅';

  @override
  String get trainingPlanCreatedSemantics => 'Plan creado';

  @override
  String get trainingPlanUpdatedSuccess => 'Plan actualizado ✅';

  @override
  String get trainingPlanUpdatedSemantics => 'Plan actualizado';

  @override
  String trainingPlanWeekLabel(Object number) {
    return 'Semana $number';
  }

  @override
  String get trainingPlanWeekNameHint => 'Ej: Fuerza, Volumen, Descarga';

  @override
  String get trainingPlanAddWeek => 'Agregar semana';

  @override
  String get trainingPlanDuplicateWeek => 'Duplicar';

  @override
  String get trainingPlanDeleteWeek => 'Eliminar';

  @override
  String get trainingPlanWeekLimitTitle => 'Límite de semanas';

  @override
  String trainingPlanWeekLimitBody(Object limit) {
    return 'Tu plan actual permite hasta $limit semanas por plan. Actualiza a Hierro para más 💪';
  }

  @override
  String get trainingPlanDuplicateLockedTitle => 'Duplicar semanas';

  @override
  String get trainingPlanDuplicateLockedBody =>
      'La duplicación de semanas está disponible desde el plan Hierro 💪';

  @override
  String get trainingPlanDayRest => 'Descanso';

  @override
  String get trainingPlanDayEmpty => 'Sin rutina';

  @override
  String get trainingPlanDayAssign => 'Asignar rutina';

  @override
  String get trainingPlanDayNotes => 'Notas del día';

  @override
  String get trainingPlanDayNotesHint => 'Ej: Subir peso en sentadilla';

  @override
  String get trainingPlanSelectRoutine => 'Elegir rutina';

  @override
  String trainingPlanCurrentWeek(Object current, Object total) {
    return 'Semana $current de $total';
  }

  @override
  String get trainingPlanAdvanceWeek => 'Avanzar semana';

  @override
  String get trainingPlanClientViewTitle => 'Mi plan';

  @override
  String get trainingPlanClientEmptyTitle => 'Sin plan de entrenamiento';

  @override
  String get trainingPlanClientEmptyBody =>
      'Tu entrenador aún no te arma un plan. Cuando lo haga, aparece aquí 💪';

  @override
  String get trainingPlanClientToday => 'Hoy';

  @override
  String get trainingPlanActiveBadge => 'Activo';

  @override
  String get trainingPlanInactiveBadge => 'Inactivo';

  @override
  String get dayMonday => 'Lunes';

  @override
  String get dayTuesday => 'Martes';

  @override
  String get dayWednesday => 'Miércoles';

  @override
  String get dayThursday => 'Jueves';

  @override
  String get dayFriday => 'Viernes';

  @override
  String get daySaturday => 'Sábado';

  @override
  String get daySunday => 'Domingo';

  @override
  String get fabCreatePlan => 'Nuevo plan';

  @override
  String get workoutScreenTitle => 'Entreno en curso';

  @override
  String get workoutStartCta => 'Comenzar';

  @override
  String get workoutStartSemantics => 'Comenzar entrenamiento';

  @override
  String get workoutFinishCta => 'Terminar entreno';

  @override
  String get workoutFinishConfirmTitle => '¿Terminar entreno?';

  @override
  String get workoutFinishConfirmBody =>
      'Vas a guardar tu progreso. Podrás verlo en tu historial 💪';

  @override
  String get workoutStartedSuccess => '¡A darle! Entreno iniciado 🔥';

  @override
  String get workoutStartedSemantics => 'Entreno iniciado';

  @override
  String get workoutFinishedSuccess => '¡Entreno completado! Buen trabajo ✅';

  @override
  String get workoutFinishedSemantics => 'Entreno completado';

  @override
  String workoutSetsProgress(int done, int total) {
    return '$done de $total series';
  }

  @override
  String get workoutRestTitle => 'Descanso';

  @override
  String get workoutRestSubtitle =>
      'Recupera el aliento, que viene la próxima 💪';

  @override
  String get workoutRestSkip => 'Saltar';

  @override
  String get workoutRestAddMinute => '+1 min';

  @override
  String get workoutRestDone => '¡A darle!';

  @override
  String get workoutAlreadyActiveTitle => 'Ya tienes un entreno en curso';

  @override
  String get workoutAlreadyActiveBody => 'Te llevamos a donde lo dejaste 💪';

  @override
  String get workoutErrorTitle => 'No pudimos cargar tu entreno';

  @override
  String get workoutEmptyTitle => 'Este entreno no tiene series';

  @override
  String get workoutEmptyBody =>
      'Pídele a tu coach que le agregue ejercicios 💪';

  @override
  String get workoutErrorBody => 'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String workoutSetWeight(String kg) {
    return '$kg kg';
  }

  @override
  String workoutSetReps(int reps) {
    return '$reps reps';
  }

  @override
  String workoutDurationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get workoutHistoryScreenTitle => 'Historial';

  @override
  String get workoutHistoryEmptyTitle => 'Aún no tienes entrenos';

  @override
  String get workoutHistoryEmptyBody =>
      'Cuando completes tu primer entreno, aparece aquí 💪';

  @override
  String get workoutHistoryErrorTitle => 'No pudimos cargar tu historial';

  @override
  String get workoutHistoryErrorBody =>
      'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get workoutHistoryVolumeChart => 'Volumen semanal';

  @override
  String get workoutHistoryVolumeSub => 'Total de series completadas';

  @override
  String workoutHistoryDate(int day, int month, int year) {
    return '$day/$month/$year';
  }

  @override
  String workoutHistoryDuration(int minutes) {
    return '$minutes min';
  }

  @override
  String workoutHistoryExercises(int count) {
    return '$count ejercicios';
  }

  @override
  String get workoutHistorySeeAll => 'Ver historial';

  @override
  String get nutritionTabTitle => 'Nutrición';

  @override
  String get nutritionPlansTitle => 'Planes nutricionales';

  @override
  String get nutritionPlansEmptyTitle => 'Sin planes todavía';

  @override
  String get nutritionPlansEmptyBody =>
      'Cuando tu nutricionista te arme un plan, aparece aquí 🥗';

  @override
  String get nutritionPlanCreate => 'Nuevo plan nutricional';

  @override
  String get nutritionPlanName => 'Nombre del plan';

  @override
  String get nutritionPlanNameHint => 'Ej: Plan volumen — Semana 1';

  @override
  String get foodSearchHint => 'Buscar alimento...';

  @override
  String get foodSearchEmptyTitle => 'No conseguimos ese alimento';

  @override
  String get foodSearchEmptyBody =>
      'Prueba con otro nombre o pídele a tu nutricionista que lo agregue 🔍';

  @override
  String get foodAddSuccess => '¡Listo! Comida registrada ✅';

  @override
  String get foodLogBreakfast => 'Desayuno';

  @override
  String get foodLogLunch => 'Almuerzo';

  @override
  String get foodLogDinner => 'Cena';

  @override
  String get foodLogSnack => 'Merienda';

  @override
  String get macroCalories => 'Calorías';

  @override
  String get macroProtein => 'Proteínas';

  @override
  String get macroCarbs => 'Carbos';

  @override
  String get macroFats => 'Grasas';

  @override
  String macroGoalExceeded(String macro) {
    return 'Te pasaste un poquito de $macro. Tranquilo, mañana se compensa 💪';
  }

  @override
  String get nutritionGoalSet => 'Objetivos guardados ✅';

  @override
  String get nutritionTierLocked =>
      'Tu gimnasio necesita el plan Hierro o Macizo para usar nutrición 🔒';

  @override
  String get nutritionistClientsTitle => 'Mis clientes';

  @override
  String get nutritionistClientsEmptyTitle => 'Sin clientes asignados';

  @override
  String get nutritionistClientsEmptyBody =>
      'Cuando el dueño del gym te asigne clientes, aparecen aquí';

  @override
  String nutritionistPlansCount(int count) {
    return '$count planes activos';
  }

  @override
  String get foodQuantityLabel => 'Cantidad (g)';

  @override
  String get foodServingDefault => '100g';

  @override
  String get foodFavoritesTitle => 'Favoritos';

  @override
  String get foodAddFavorite => 'Guardar en favoritos';

  @override
  String get foodRemoveFavorite => 'Quitar de favoritos';

  @override
  String get goalTypeLose => 'Perder grasa';

  @override
  String get goalTypeMaintain => 'Mantener';

  @override
  String get goalTypeGain => 'Aumentar masa';

  @override
  String nutritionClientSince(String date) {
    return 'Cliente desde $date';
  }

  @override
  String get nutritionViewPlan => 'Ver plan';

  @override
  String get nutritionSetGoals => 'Fijar objetivos';

  @override
  String get nutritionNoPlanYet => 'Sin plan asignado';

  @override
  String nutritionLastLog(String date) {
    return 'Último registro: $date';
  }

  @override
  String get foodFormTitle => 'Nuevo alimento';

  @override
  String get foodFormEditTitle => 'Editar alimento';

  @override
  String get foodFormNameLabel => 'Nombre del alimento';

  @override
  String get foodFormNameHint => 'Ej: Arepa de maíz';

  @override
  String get foodFormBrandLabel => 'Marca (opcional)';

  @override
  String get foodFormBrandHint => 'Ej: Harina PAN';

  @override
  String get foodFormServingLabel => 'Porción de referencia';

  @override
  String get foodFormCaloriesLabel => 'Calorías (kcal)';

  @override
  String get foodFormProteinLabel => 'Proteínas (g)';

  @override
  String get foodFormCarbsLabel => 'Carbohidratos (g)';

  @override
  String get foodFormFatsLabel => 'Grasas (g)';

  @override
  String get foodFormFiberLabel => 'Fibra (g, opcional)';

  @override
  String get foodFormSugarLabel => 'Azúcar (g, opcional)';

  @override
  String get foodFormSodiumLabel => 'Sodio (mg, opcional)';

  @override
  String get foodFormSaveSuccess => 'Alimento guardado ✅';

  @override
  String get foodFormSaveError =>
      'No pudimos guardar el alimento. Intenta de nuevo';

  @override
  String get foodFormValidationError => 'Revisa los campos marcados en rojo';

  @override
  String get foodDeleteConfirmTitle => '¿Eliminar este alimento?';

  @override
  String get foodDeleteConfirmBody =>
      'El alimento se desactiva pero se mantiene en los registros existentes.';

  @override
  String get foodDeleteSuccess => 'Alimento eliminado ✅';

  @override
  String get nutritionPlanEdit => 'Editar plan';

  @override
  String get nutritionPlanDays => 'Duración (días)';

  @override
  String get nutritionPlanNotes => 'Notas (opcional)';

  @override
  String nutritionistClientsCount(int count) {
    return '$count clientes sin plan nutricional';
  }

  @override
  String get nutritionistDashboardTitle => 'Inicio';

  @override
  String get nutritionistStatsClients => 'Clientes';

  @override
  String get nutritionistStatsPlans => 'Planes';

  @override
  String get nutritionistStatsFoods => 'Alimentos';

  @override
  String get nutriFabNewPlan => 'Nuevo plan';

  @override
  String get tabPlans => 'Planes';

  @override
  String get nutritionistPlansTitle => 'Planes nutricionales';

  @override
  String get nutritionistPlansEmpty =>
      'Aún no has creado ningún plan nutricional.';

  @override
  String get nutritionistTemplatesTitle => 'Plantillas de comida';

  @override
  String get foodCatalogTitle => 'Catálogo de alimentos';

  @override
  String get foodCatalogEmpty =>
      'No hay alimentos registrados. Crea el primero.';

  @override
  String get foodFormOptionalSection => 'Tal Vez';

  @override
  String get foodSearchPlaceholder => 'Buscar alimento...';

  @override
  String get mealTemplateFormTitle => 'Plantilla de comida';

  @override
  String get nutritionPlanFormTitle => 'Plan nutricional';

  @override
  String get selectClient => 'Seleccionar cliente';

  @override
  String get planDuration => 'Duración (días)';

  @override
  String get targetCalories => 'Calorías objetivo';

  @override
  String get targetProtein => 'Proteína (g)';

  @override
  String get targetCarbs => 'Carbohidratos (g)';

  @override
  String get targetFats => 'Grasas (g)';

  @override
  String get addMealTemplate => 'Agregar comida';

  @override
  String dayNumber(int number) {
    return 'Día $number';
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
  String get staffScreenTitle => 'Mi equipo';

  @override
  String get staffRoleTrainer => 'Entrenador';

  @override
  String get staffRoleNutritionist => 'Nutricionista';

  @override
  String get staffStatusActive => 'Activo';

  @override
  String get staffStatusInactive => 'Inactivo';

  @override
  String get staffActionActivate => 'Activar';

  @override
  String get staffActionDeactivate => 'Desactivar';

  @override
  String get staffLimitTitle => 'Cupos del equipo';

  @override
  String get staffLimitUnlimited => 'Cupos ilimitados';

  @override
  String get staffLimitNearLimit => '¡Casi al límite!';

  @override
  String get staffEmptyTitle => 'Aún no tienes equipo';

  @override
  String get staffEmptyBody =>
      'Invita a tu primer entrenador o nutricionista y empieza a mover tu gimnasio 💪';

  @override
  String get staffErrorTitle => 'No se pudo cargar el equipo';

  @override
  String get staffErrorBody => 'Revisa tu conexión e intenta de nuevo';

  @override
  String get staffDeactivateConfirmTitle => '¿Desactivar a esta persona?';

  @override
  String get staffDeactivateConfirmBody =>
      'Dejará de aparecer como parte activa del equipo.';

  @override
  String get staffActivateConfirmTitle => '¿Activar a esta persona?';

  @override
  String get staffActivateConfirmBody =>
      'Volverá a aparecer como parte activa del equipo.';

  @override
  String get staffDeactivatedSuccess => 'Miembro desactivado';

  @override
  String get staffActivatedSuccess => 'Miembro activado';

  @override
  String get staffActionError => 'No se pudo completar la acción';

  @override
  String get fabAddStaff => 'Agregar miembro del equipo';

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

  @override
  String get staffAddTitle => 'Agregar miembro';

  @override
  String get staffAddNameLabel => 'Nombre completo';

  @override
  String get staffAddNameHint => 'Ej: María Pérez';

  @override
  String get staffAddNameError => 'El nombre es obligatorio';

  @override
  String get staffAddEmailLabel => 'Correo electrónico';

  @override
  String get staffAddEmailHint => 'correo@ejemplo.com';

  @override
  String get staffAddEmailErrorEmpty => 'El correo es obligatorio';

  @override
  String get staffAddEmailErrorInvalid => 'Ese correo no parece válido';

  @override
  String get staffAddRoleLabel => 'Rol';

  @override
  String get staffAddPasswordLabel => 'Contraseña temporal';

  @override
  String get staffAddPasswordHint => 'Se genera automáticamente';

  @override
  String get staffAddPasswordError => 'Mínimo 6 caracteres';

  @override
  String get staffAddPasswordRegenerate => 'Generar otra contraseña';

  @override
  String get staffAddSubmit => 'Invitar al equipo';

  @override
  String get staffAddSubmitting => 'Invitando...';

  @override
  String get staffAddSuccessTitle => '¡Miembro invitado!';

  @override
  String get staffAddSuccessBody =>
      'Comparte estos datos con tu nuevo miembro del equipo. La contraseña solo se muestra una vez.';

  @override
  String get staffAddCredentialEmail => 'Correo';

  @override
  String get staffAddCredentialPassword => 'Contraseña temporal';

  @override
  String get staffAddCopyTooltip => 'Copiar contraseña';

  @override
  String get staffAddCopied => 'Contraseña copiada ✅';

  @override
  String get staffAddCopiedSemantics => 'Contraseña copiada';

  @override
  String get staffAddDone => 'Listo, volver al equipo';

  @override
  String get staffAddNoGym => 'No tienes un gimnasio asignado.';

  @override
  String get staffAddNoGymSemantics => 'Error de gimnasio asignado';

  @override
  String get clientsScreenTitle => 'Clientes';

  @override
  String get clientsStatActive => 'Activos';

  @override
  String get clientsStatActiveSub => 'En tu gimnasio';

  @override
  String get clientsLimitTitle => 'Cupos de clientes';

  @override
  String get clientsLimitUnlimited => 'Clientes ilimitados';

  @override
  String get clientsLimitNearLimit => '¡Casi al límite!';

  @override
  String get clientsEmptyTitle => 'Aún no tienes clientes';

  @override
  String get clientsEmptyBody =>
      'Cuando alguien se una a tu gimnasio, aparece aquí 💪';

  @override
  String get clientsErrorTitle => 'No se pudo cargar los clientes';

  @override
  String get clientsErrorBody => 'Revisa tu conexión e intenta de nuevo';

  @override
  String get clientsSearchHint => 'Buscar por nombre...';

  @override
  String get clientDetailTitle => 'Detalle del cliente';

  @override
  String get clientDetailJoined => 'Miembro desde';

  @override
  String get clientDetailStatusActive => 'Activo';

  @override
  String get clientDetailStatusInactive => 'Inactivo';

  @override
  String get clientDetailDeactivate => 'Desactivar membresía';

  @override
  String get clientDetailActivate => 'Activar membresía';

  @override
  String get clientDetailDeactivateConfirmTitle => '¿Desactivar este cliente?';

  @override
  String get clientDetailDeactivateConfirmBody =>
      'El cliente perderá acceso a la app hasta que lo actives de nuevo.';

  @override
  String get clientDetailActivateConfirmTitle => '¿Activar este cliente?';

  @override
  String get clientDetailActivateConfirmBody =>
      'El cliente recuperará el acceso a la app.';

  @override
  String get clientDeactivatedSuccess => 'Cliente desactivado';

  @override
  String get clientActivatedSuccess => 'Cliente activado';

  @override
  String get clientAddTitle => 'Agregar cliente';

  @override
  String get clientAddNameLabel => 'Nombre completo';

  @override
  String get clientAddNameHint => 'Ej: Carlos Rodríguez';

  @override
  String get clientAddNameError => 'El nombre es obligatorio';

  @override
  String get clientAddEmailLabel => 'Correo electrónico';

  @override
  String get clientAddEmailHint => 'correo@ejemplo.com';

  @override
  String get clientAddEmailErrorEmpty => 'El correo es obligatorio';

  @override
  String get clientAddEmailErrorInvalid => 'Ese correo no parece válido';

  @override
  String get clientAddPasswordLabel => 'Contraseña temporal';

  @override
  String get clientAddPasswordHint => 'Se genera automáticamente';

  @override
  String get clientAddPasswordError => 'Mínimo 6 caracteres';

  @override
  String get clientAddPasswordRegenerate => 'Generar otra contraseña';

  @override
  String get clientAddSubmit => 'Agregar cliente';

  @override
  String get clientAddSubmitting => 'Agregando...';

  @override
  String get clientAddSuccessTitle => '¡Cliente agregado!';

  @override
  String get clientAddSuccessBody =>
      'Comparte estos datos con tu cliente. La contraseña solo se muestra una vez.';

  @override
  String get clientAddCredentialEmail => 'Correo';

  @override
  String get clientAddCredentialPassword => 'Contraseña temporal';

  @override
  String get clientAddCopyTooltip => 'Copiar contraseña';

  @override
  String get clientAddCopied => 'Contraseña copiada ✅';

  @override
  String get clientAddCopiedSemantics => 'Contraseña copiada';

  @override
  String get clientAddDone => 'Listo, volver a clientes';

  @override
  String get clientAddNoGym => 'No tienes un gimnasio asignado.';

  @override
  String get clientAddNoGymSemantics => 'Error de gimnasio asignado';

  @override
  String get clientAddLimitReached =>
      'Ya llegaste al límite de clientes de tu plan. Actualiza a Hierro para agregar más.';

  @override
  String get paymentsScreenTitle => 'Pagos';

  @override
  String get paymentsFilterPending => 'Pendientes';

  @override
  String get paymentsFilterVerified => 'Verificados';

  @override
  String get paymentsFilterRejected => 'Rechazados';

  @override
  String get paymentsEmptyPendingTitle => 'Sin comprobantes pendientes';

  @override
  String get paymentsEmptyPendingBody =>
      'Cuando un cliente suba un pago, aparece aquí.';

  @override
  String get paymentsEmptyVerifiedTitle => 'Nada verificado todavía';

  @override
  String get paymentsEmptyVerifiedBody => 'Los pagos aprobados aparecen aquí.';

  @override
  String get paymentsEmptyRejectedTitle => 'Nada rechazado';

  @override
  String get paymentsEmptyRejectedBody => 'Los pagos rechazados aparecen aquí.';

  @override
  String get paymentsErrorTitle => 'No pudimos cargar los pagos';

  @override
  String get paymentsErrorBody => 'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get paymentsOfflineEmpty =>
      'Sin conexión. Los pagos se revisan cuando vuelva la señal.';

  @override
  String get paymentDetailTitle => 'Detalle del pago';

  @override
  String get paymentDetailClient => 'Cliente';

  @override
  String get paymentDetailAmountUsd => 'Monto USD';

  @override
  String get paymentDetailAmountBs => 'Monto Bs';

  @override
  String get paymentDetailRate => 'Tasa usada';

  @override
  String get paymentDetailDate => 'Fecha';

  @override
  String get paymentDetailReceipt => 'Comprobante';

  @override
  String get paymentDetailApprove => 'Aprobar';

  @override
  String get paymentDetailReject => 'Rechazar';

  @override
  String get paymentApproveConfirmTitle => '¿Aprobar este pago?';

  @override
  String get paymentApproveConfirmBody =>
      'El cliente quedará activo y el pago marcado como verificado.';

  @override
  String get paymentRejectDialogTitle => 'Rechazar pago';

  @override
  String get paymentRejectDialogBody =>
      'Cuéntale al cliente por qué no pudiste aprobarlo.';

  @override
  String get paymentRejectReasonLabel => 'Motivo del rechazo';

  @override
  String get paymentRejectReasonHint => 'Ej: la imagen está borrosa';

  @override
  String get paymentRejectReasonError => 'Escribe un motivo';

  @override
  String get paymentApprovedSuccess => 'Pago aprobado ✅';

  @override
  String get paymentApprovedSemantics => 'Pago aprobado';

  @override
  String get paymentRejectedSuccess => 'Pago rechazado';

  @override
  String get paymentRejectedSemantics => 'Pago rechazado';

  @override
  String get paymentActionError => 'No pudimos completar la acción';

  @override
  String get paymentStatusPending => 'Pendiente';

  @override
  String get paymentStatusVerified => 'Verificado';

  @override
  String get paymentStatusRejected => 'Rechazado';

  @override
  String get paymentsFabRegister => 'Registrar pago';

  @override
  String get uploadPaymentTitle => 'Subir pago';

  @override
  String get uploadPaymentSubtitle =>
      'Registra tu pago manual (Pago Móvil o transferencia). Lo verificamos en menos de 24h.';

  @override
  String get uploadPaymentAmountBsLabel => 'Monto en Bs';

  @override
  String get uploadPaymentAmountBsHint => 'Ej: 15000';

  @override
  String get uploadPaymentAmountBsError => 'El monto debe ser mayor a cero';

  @override
  String get uploadPaymentAmountUsdLabel => 'Monto en USD';

  @override
  String get uploadPaymentAmountUsdHint =>
      'Se calcula con la tasa del gimnasio';

  @override
  String get uploadPaymentRateLabel => 'Tasa usada';

  @override
  String get uploadPaymentRateError => 'No hay tasa configurada en tu gimnasio';

  @override
  String get uploadPaymentPickImage => 'Tomar o elegir foto del comprobante';

  @override
  String get uploadPaymentPickImageError =>
      'Necesitamos una foto del comprobante';

  @override
  String get uploadPaymentReplaceImage => 'Cambiar foto';

  @override
  String get uploadPaymentSubmit => 'Enviar comprobante';

  @override
  String get uploadPaymentSubmitting => 'Subiendo...';

  @override
  String get uploadPaymentSuccessTitle => '¡Pago enviado! 📩';

  @override
  String get uploadPaymentSuccessBody =>
      'Tu comprobante está en revisión. Te avisamos cuando lo aprobemos.';

  @override
  String get uploadPaymentSuccessSemantics => 'Pago enviado, en revisión';

  @override
  String get uploadPaymentErrorTitle => 'No pudimos subir tu pago';

  @override
  String get uploadPaymentErrorSemantics => 'Error al subir el pago';

  @override
  String get uploadPaymentNoRateTitle =>
      'Tu gimnasio no tiene tasa configurada';

  @override
  String get uploadPaymentNoRateBody =>
      'Pídele al dueño que configure la tasa del día para poder subir pagos.';

  @override
  String get clientDashPrimaryCtaUpload => 'Subir pago';

  @override
  String get clientDashPrimaryUploadTitle => 'Tu mensualidad';

  @override
  String get clientDashPrimaryUploadBody =>
      'Sube el comprobante de tu pago para seguir activo en el gimnasio.';

  @override
  String get clientDashUploadFab => 'Subir pago';

  @override
  String get plansScreenTitle => 'Planes del gimnasio';

  @override
  String get plansEmptyTitle => 'Aún no tienes planes';

  @override
  String get plansEmptyBody =>
      'Crea tu primer plan para que tus clientes elijan cuánto pagar 💪';

  @override
  String get plansCreateFab => 'Crear plan';

  @override
  String get plansErrorTitle => 'No pudimos cargar los planes';

  @override
  String get plansErrorBody => 'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get planFormCreateTitle => 'Crear plan';

  @override
  String get planFormEditTitle => 'Editar plan';

  @override
  String get planFormNameLabel => 'Nombre del plan';

  @override
  String get planFormNameHint => 'Ej: Con Coach';

  @override
  String get planFormNameError => 'El nombre es obligatorio';

  @override
  String get planFormDescriptionLabel => 'Descripción (opcional)';

  @override
  String get planFormDescriptionHint => 'Qué incluye este plan';

  @override
  String get planFormPriceLabel => 'Precio en USD';

  @override
  String get planFormPriceHint => 'Ej: 30';

  @override
  String get planFormPriceError => 'El precio debe ser mayor a cero';

  @override
  String get planFormDurationLabel => 'Duración (días)';

  @override
  String get planFormDurationHint => 'Ej: 30';

  @override
  String get planFormDurationError => 'La duración debe ser al menos 1 día';

  @override
  String get planFormIncludesTrainer => 'Incluye entrenador personal';

  @override
  String get planFormIncludesNutritionist => 'Incluye nutricionista';

  @override
  String get planFormSubmit => 'Guardar plan';

  @override
  String get planFormSubmitting => 'Guardando...';

  @override
  String get planCreatedSuccess => 'Plan creado ✅';

  @override
  String get planCreatedSemantics => 'Plan creado';

  @override
  String get planUpdatedSuccess => 'Plan actualizado ✅';

  @override
  String get planUpdatedSemantics => 'Plan actualizado';

  @override
  String get planLimitReachedTitle => 'Límite de planes alcanzado';

  @override
  String get planLimitReachedBody =>
      'Tu plan actual no permite más planes. Actualiza a Hierro para crear más.';

  @override
  String get planDeactivateConfirmTitle => '¿Desactivar este plan?';

  @override
  String get planDeactivateConfirmBody =>
      'Los clientes actuales lo mantienen, pero no se podrá asignar a nuevos clientes.';

  @override
  String get planDeactivatedSuccess => 'Plan desactivado';

  @override
  String get planDeactivatedSemantics => 'Plan desactivado';

  @override
  String get planActiveBadge => 'Activo';

  @override
  String get planInactiveBadge => 'Inactivo';

  @override
  String get planPerMonth => '/mes';

  @override
  String planDurationDays(Object days) {
    return '$days días';
  }

  @override
  String get subscriptionCardTitle => 'Tu plan';

  @override
  String get subscriptionCardNoPlanTitle => 'Sin plan asignado';

  @override
  String get subscriptionCardNoPlanBody =>
      'Tu gimnasio aún no te asigna un plan. Pregúntale al dueño 💪';

  @override
  String get subscriptionBalanceOwed => 'Debes';

  @override
  String get subscriptionBalancePaid => 'Estás al día';

  @override
  String get subscriptionBalanceCredit => 'Tienes a favor';

  @override
  String get subscriptionExpiresLabel => 'Vence';

  @override
  String get subscriptionPayCta => 'Pagar';

  @override
  String get subscriptionStatusActive => 'Activo';

  @override
  String get subscriptionStatusExpired => 'Vencido';

  @override
  String get subscriptionStatusSuspended => 'Suspendido';

  @override
  String get assignPlanTitle => 'Asignar plan';

  @override
  String get assignPlanSubtitle => 'Elige el plan para este cliente';

  @override
  String get assignPlanNoPlansTitle => 'No tienes planes creados';

  @override
  String get assignPlanNoPlansBody =>
      'Primero crea un plan en la sección de planes.';

  @override
  String get assignPlanConfirm => 'Asignar';

  @override
  String get assignPlanSuccess => 'Plan asignado ✅';

  @override
  String get assignPlanSemantics => 'Plan asignado';

  @override
  String get assignPlanCurrentLabel => 'Plan actual';

  @override
  String get assignPlanChangeCta => 'Cambiar plan';

  @override
  String get assignPlanAssignCta => 'Asignar plan';

  @override
  String get uploadPaymentPlanLabel => 'Plan';

  @override
  String get uploadPaymentBalanceLabel => 'Saldo pendiente';

  @override
  String get uploadPaymentCreditLabel => 'Saldo a favor';

  @override
  String get ownerClientPlanSection => 'Plan del cliente';

  @override
  String get ownerClientNoPlan => 'Sin plan asignado';

  @override
  String get exercisesScreenTitle => 'Ejercicios';

  @override
  String get exercisesSearchHint => 'Buscar ejercicio...';

  @override
  String get exercisesEmptyTitle => 'Aún no hay ejercicios';

  @override
  String get exercisesEmptyBody =>
      'Crea tu primer ejercicio personalizado o usa la biblioteca base 💪';

  @override
  String get exercisesErrorTitle => 'No pudimos cargar los ejercicios';

  @override
  String get exercisesErrorBody =>
      'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get exercisesGlobalBadge => 'Biblioteca';

  @override
  String get exercisesCustomBadge => 'Del gym';

  @override
  String get exerciseFormCreateTitle => 'Crear ejercicio';

  @override
  String get exerciseFormEditTitle => 'Editar ejercicio';

  @override
  String get exerciseFormNameLabel => 'Nombre del ejercicio';

  @override
  String get exerciseFormNameHint => 'Ej: Sentadilla búlgara';

  @override
  String get exerciseFormNameError => 'El nombre es obligatorio';

  @override
  String get exerciseFormDescriptionLabel => 'Descripción (opcional)';

  @override
  String get exerciseFormDescriptionHint => 'Cómo se hace, qué trabaja';

  @override
  String get exerciseFormMuscleGroupLabel => 'Grupo muscular';

  @override
  String get exerciseFormSubmit => 'Guardar ejercicio';

  @override
  String get exerciseFormSubmitting => 'Guardando...';

  @override
  String get exerciseCreatedSuccess => 'Ejercicio creado ✅';

  @override
  String get exerciseCreatedSemantics => 'Ejercicio creado';

  @override
  String get exerciseUpdatedSuccess => 'Ejercicio actualizado ✅';

  @override
  String get exerciseUpdatedSemantics => 'Ejercicio actualizado';

  @override
  String get routinesScreenTitle => 'Rutinas';

  @override
  String get routinesEmptyTitle => 'Aún no tienes rutinas';

  @override
  String get routinesEmptyBody => 'Crea la primera rutina para tus clientes 💪';

  @override
  String get routinesErrorTitle => 'No pudimos cargar las rutinas';

  @override
  String get routinesErrorBody => 'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get routineFormCreateTitle => 'Nueva rutina';

  @override
  String get routineFormEditTitle => 'Editar rutina';

  @override
  String get routineFormNameLabel => 'Nombre de la rutina';

  @override
  String get routineFormNameHint => 'Ej: Tren superior - Día 1';

  @override
  String get routineFormNameError => 'El nombre es obligatorio';

  @override
  String get routineFormDescriptionLabel => 'Descripción (opcional)';

  @override
  String get routineFormDescriptionHint => 'Objetivo de la rutina';

  @override
  String get routineFormClientLabel => 'Cliente';

  @override
  String get routineFormClientError => 'Selecciona un cliente';

  @override
  String get routineFormExercisesLabel => 'Ejercicios';

  @override
  String get routineFormAddExercise => 'Agregar ejercicio';

  @override
  String get routineFormNoExercises => 'Agrega al menos un ejercicio';

  @override
  String get routineFormSubmit => 'Guardar rutina';

  @override
  String get routineFormSubmitting => 'Guardando...';

  @override
  String get routineCreatedSuccess => 'Rutina creada ✅';

  @override
  String get routineCreatedSemantics => 'Rutina creada';

  @override
  String get routineUpdatedSuccess => 'Rutina actualizada ✅';

  @override
  String get routineUpdatedSemantics => 'Rutina actualizada';

  @override
  String get routineExerciseSets => 'Series';

  @override
  String get routineExerciseReps => 'Reps';

  @override
  String get routineExerciseWeight => 'Peso (kg)';

  @override
  String get routineExerciseRest => 'Descanso (seg)';

  @override
  String get routineExerciseNotes => 'Notas';

  @override
  String get muscleGroupChest => 'Pecho';

  @override
  String get muscleGroupBack => 'Espalda';

  @override
  String get muscleGroupShoulders => 'Hombros';

  @override
  String get muscleGroupBiceps => 'Bíceps';

  @override
  String get muscleGroupTriceps => 'Tríceps';

  @override
  String get muscleGroupLegs => 'Piernas';

  @override
  String get muscleGroupGlutes => 'Glúteos';

  @override
  String get muscleGroupCore => 'Core';

  @override
  String get muscleGroupCardio => 'Cardio';

  @override
  String get muscleGroupFullBody => 'Full body';

  @override
  String get muscleGroupAll => 'Todos';

  @override
  String get fabCreateExercise => 'Crear ejercicio';

  @override
  String get fabCreateRoutine => 'Nueva rutina';

  @override
  String get clientRoutineScreenTitle => 'Mi rutina';

  @override
  String get clientRoutineEmptyTitle => 'Sin rutina asignada';

  @override
  String get clientRoutineEmptyBody =>
      'Tu entrenador aún no te asigna una rutina. Cuando lo haga, aparece aquí 💪';

  @override
  String get clientRoutineErrorTitle => 'No pudimos cargar tu rutina';

  @override
  String get clientRoutineErrorBody =>
      'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String clientRoutineExerciseCount(Object count) {
    return '$count ejercicios';
  }

  @override
  String clientRoutineExerciseSets(Object sets) {
    return '$sets series';
  }

  @override
  String clientRoutineExerciseReps(Object reps) {
    return '$reps reps';
  }

  @override
  String clientRoutineExerciseWeight(Object weight) {
    return '$weight kg';
  }

  @override
  String clientRoutineExerciseRest(Object rest) {
    return '${rest}s descanso';
  }

  @override
  String get clientRoutineExerciseNotes => 'Notas';

  @override
  String get clientDashPrimaryRoutineTitle => 'Tu rutina';

  @override
  String clientDashPrimaryRoutineBody(Object count) {
    return 'Tienes $count ejercicios por hacer hoy';
  }

  @override
  String get clientDashPrimaryRoutineCta => 'Ver rutina';

  @override
  String get clientDashPrimaryRoutineCtaNone => 'Sin rutina';

  @override
  String get plansTabTitle => 'Planes';

  @override
  String get routinesTabTitle => 'Rutinas';

  @override
  String get trainingPlansScreenTitle => 'Planes de entrenamiento';

  @override
  String get trainingPlansEmptyTitle => 'Aún no tienes planes';

  @override
  String get trainingPlansEmptyBody =>
      'Crea un plan semanal para tus clientes y olvídate de asignar rutinas a diario 💪';

  @override
  String get trainingPlansErrorTitle => 'No pudimos cargar los planes';

  @override
  String get trainingPlansErrorBody =>
      'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get trainingPlanFormCreateTitle => 'Nuevo plan';

  @override
  String get trainingPlanFormEditTitle => 'Editar plan';

  @override
  String get trainingPlanFormNameLabel => 'Nombre del plan';

  @override
  String get trainingPlanFormNameHint => 'Ej: Plan de Juan - Mes 1';

  @override
  String get trainingPlanFormNameError => 'El nombre es obligatorio';

  @override
  String get trainingPlanFormDescriptionLabel => 'Descripción (opcional)';

  @override
  String get trainingPlanFormDescriptionHint => 'Objetivo del plan';

  @override
  String get trainingPlanFormClientLabel => 'Cliente';

  @override
  String get trainingPlanFormClientError => 'Selecciona un cliente';

  @override
  String get trainingPlanFormSubmit => 'Guardar plan';

  @override
  String get trainingPlanFormSubmitting => 'Guardando...';

  @override
  String get trainingPlanCreatedSuccess => 'Plan creado ✅';

  @override
  String get trainingPlanCreatedSemantics => 'Plan creado';

  @override
  String get trainingPlanUpdatedSuccess => 'Plan actualizado ✅';

  @override
  String get trainingPlanUpdatedSemantics => 'Plan actualizado';

  @override
  String trainingPlanWeekLabel(Object number) {
    return 'Semana $number';
  }

  @override
  String get trainingPlanWeekNameHint => 'Ej: Fuerza, Volumen, Descarga';

  @override
  String get trainingPlanAddWeek => 'Agregar semana';

  @override
  String get trainingPlanDuplicateWeek => 'Duplicar';

  @override
  String get trainingPlanDeleteWeek => 'Eliminar';

  @override
  String get trainingPlanWeekLimitTitle => 'Límite de semanas';

  @override
  String trainingPlanWeekLimitBody(Object limit) {
    return 'Tu plan actual permite hasta $limit semanas por plan. Actualiza a Hierro para más 💪';
  }

  @override
  String get trainingPlanDuplicateLockedTitle => 'Duplicar semanas';

  @override
  String get trainingPlanDuplicateLockedBody =>
      'La duplicación de semanas está disponible desde el plan Hierro 💪';

  @override
  String get trainingPlanDayRest => 'Descanso';

  @override
  String get trainingPlanDayEmpty => 'Sin rutina';

  @override
  String get trainingPlanDayAssign => 'Asignar rutina';

  @override
  String get trainingPlanDayNotes => 'Notas del día';

  @override
  String get trainingPlanDayNotesHint => 'Ej: Subir peso en sentadilla';

  @override
  String get trainingPlanSelectRoutine => 'Elegir rutina';

  @override
  String trainingPlanCurrentWeek(Object current, Object total) {
    return 'Semana $current de $total';
  }

  @override
  String get trainingPlanAdvanceWeek => 'Avanzar semana';

  @override
  String get trainingPlanClientViewTitle => 'Mi plan';

  @override
  String get trainingPlanClientEmptyTitle => 'Sin plan de entrenamiento';

  @override
  String get trainingPlanClientEmptyBody =>
      'Tu entrenador aún no te arma un plan. Cuando lo haga, aparece aquí 💪';

  @override
  String get trainingPlanClientToday => 'Hoy';

  @override
  String get trainingPlanActiveBadge => 'Activo';

  @override
  String get trainingPlanInactiveBadge => 'Inactivo';

  @override
  String get dayMonday => 'Lunes';

  @override
  String get dayTuesday => 'Martes';

  @override
  String get dayWednesday => 'Miércoles';

  @override
  String get dayThursday => 'Jueves';

  @override
  String get dayFriday => 'Viernes';

  @override
  String get daySaturday => 'Sábado';

  @override
  String get daySunday => 'Domingo';

  @override
  String get fabCreatePlan => 'Nuevo plan';

  @override
  String get workoutScreenTitle => 'Entreno en curso';

  @override
  String get workoutStartCta => 'Comenzar';

  @override
  String get workoutStartSemantics => 'Comenzar entrenamiento';

  @override
  String get workoutFinishCta => 'Terminar entreno';

  @override
  String get workoutFinishConfirmTitle => '¿Terminar entreno?';

  @override
  String get workoutFinishConfirmBody =>
      'Vas a guardar tu progreso. Podrás verlo en tu historial 💪';

  @override
  String get workoutStartedSuccess => '¡A darle! Entreno iniciado 🔥';

  @override
  String get workoutStartedSemantics => 'Entreno iniciado';

  @override
  String get workoutFinishedSuccess => '¡Entreno completado! Buen trabajo ✅';

  @override
  String get workoutFinishedSemantics => 'Entreno completado';

  @override
  String workoutSetsProgress(int done, int total) {
    return '$done de $total series';
  }

  @override
  String get workoutRestTitle => 'Descanso';

  @override
  String get workoutRestSubtitle =>
      'Recupera el aliento, que viene la próxima 💪';

  @override
  String get workoutRestSkip => 'Saltar';

  @override
  String get workoutRestAddMinute => '+1 min';

  @override
  String get workoutRestDone => '¡A darle!';

  @override
  String get workoutAlreadyActiveTitle => 'Ya tienes un entreno en curso';

  @override
  String get workoutAlreadyActiveBody => 'Te llevamos a donde lo dejaste 💪';

  @override
  String get workoutErrorTitle => 'No pudimos cargar tu entreno';

  @override
  String get workoutEmptyTitle => 'Este entreno no tiene series';

  @override
  String get workoutEmptyBody =>
      'Pídele a tu coach que le agregue ejercicios 💪';

  @override
  String get workoutErrorBody => 'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String workoutSetWeight(String kg) {
    return '$kg kg';
  }

  @override
  String workoutSetReps(int reps) {
    return '$reps reps';
  }

  @override
  String workoutDurationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get workoutHistoryScreenTitle => 'Historial';

  @override
  String get workoutHistoryEmptyTitle => 'Aún no tienes entrenos';

  @override
  String get workoutHistoryEmptyBody =>
      'Cuando completes tu primer entreno, aparece aquí 💪';

  @override
  String get workoutHistoryErrorTitle => 'No pudimos cargar tu historial';

  @override
  String get workoutHistoryErrorBody =>
      'Tranquilo, suele pasar. Inténtalo de nuevo.';

  @override
  String get workoutHistoryVolumeChart => 'Volumen semanal';

  @override
  String get workoutHistoryVolumeSub => 'Total de series completadas';

  @override
  String workoutHistoryDate(int day, int month, int year) {
    return '$day/$month/$year';
  }

  @override
  String workoutHistoryDuration(int minutes) {
    return '$minutes min';
  }

  @override
  String workoutHistoryExercises(int count) {
    return '$count ejercicios';
  }

  @override
  String get workoutHistorySeeAll => 'Ver historial';

  @override
  String get nutritionTabTitle => 'Nutrición';

  @override
  String get nutritionPlansTitle => 'Planes nutricionales';

  @override
  String get nutritionPlansEmptyTitle => 'Sin planes todavía';

  @override
  String get nutritionPlansEmptyBody =>
      'Cuando tu nutricionista te arme un plan, aparece aquí 🥗';

  @override
  String get nutritionPlanCreate => 'Nuevo plan nutricional';

  @override
  String get nutritionPlanName => 'Nombre del plan';

  @override
  String get nutritionPlanNameHint => 'Ej: Plan volumen — Semana 1';

  @override
  String get foodSearchHint => 'Buscar alimento...';

  @override
  String get foodSearchEmptyTitle => 'No conseguimos ese alimento';

  @override
  String get foodSearchEmptyBody =>
      'Prueba con otro nombre o pídele a tu nutricionista que lo agregue 🔍';

  @override
  String get foodAddSuccess => '¡Listo! Comida registrada ✅';

  @override
  String get foodLogBreakfast => 'Desayuno';

  @override
  String get foodLogLunch => 'Almuerzo';

  @override
  String get foodLogDinner => 'Cena';

  @override
  String get foodLogSnack => 'Merienda';

  @override
  String get macroCalories => 'Calorías';

  @override
  String get macroProtein => 'Proteínas';

  @override
  String get macroCarbs => 'Carbos';

  @override
  String get macroFats => 'Grasas';

  @override
  String macroGoalExceeded(String macro) {
    return 'Te pasaste un poquito de $macro. Tranquilo, mañana se compensa 💪';
  }

  @override
  String get nutritionGoalSet => 'Objetivos guardados ✅';

  @override
  String get nutritionTierLocked =>
      'Tu gimnasio necesita el plan Hierro o Macizo para usar nutrición 🔒';

  @override
  String get nutritionistClientsTitle => 'Mis clientes';

  @override
  String get nutritionistClientsEmptyTitle => 'Sin clientes asignados';

  @override
  String get nutritionistClientsEmptyBody =>
      'Cuando el dueño del gym te asigne clientes, aparecen aquí';

  @override
  String nutritionistPlansCount(int count) {
    return '$count planes activos';
  }

  @override
  String get foodQuantityLabel => 'Cantidad (g)';

  @override
  String get foodServingDefault => '100g';

  @override
  String get foodFavoritesTitle => 'Favoritos';

  @override
  String get foodAddFavorite => 'Guardar en favoritos';

  @override
  String get foodRemoveFavorite => 'Quitar de favoritos';

  @override
  String get goalTypeLose => 'Perder grasa';

  @override
  String get goalTypeMaintain => 'Mantener';

  @override
  String get goalTypeGain => 'Aumentar masa';

  @override
  String nutritionClientSince(String date) {
    return 'Cliente desde $date';
  }

  @override
  String get nutritionViewPlan => 'Ver plan';

  @override
  String get nutritionSetGoals => 'Fijar objetivos';

  @override
  String get nutritionNoPlanYet => 'Sin plan asignado';

  @override
  String nutritionLastLog(String date) {
    return 'Último registro: $date';
  }

  @override
  String get foodFormTitle => 'Nuevo alimento';

  @override
  String get foodFormEditTitle => 'Editar alimento';

  @override
  String get foodFormNameLabel => 'Nombre del alimento';

  @override
  String get foodFormNameHint => 'Ej: Arepa de maíz';

  @override
  String get foodFormBrandLabel => 'Marca (opcional)';

  @override
  String get foodFormBrandHint => 'Ej: Harina PAN';

  @override
  String get foodFormServingLabel => 'Porción de referencia';

  @override
  String get foodFormCaloriesLabel => 'Calorías (kcal)';

  @override
  String get foodFormProteinLabel => 'Proteínas (g)';

  @override
  String get foodFormCarbsLabel => 'Carbohidratos (g)';

  @override
  String get foodFormFatsLabel => 'Grasas (g)';

  @override
  String get foodFormFiberLabel => 'Fibra (g, opcional)';

  @override
  String get foodFormSugarLabel => 'Azúcar (g, opcional)';

  @override
  String get foodFormSodiumLabel => 'Sodio (mg, opcional)';

  @override
  String get foodFormSaveSuccess => 'Alimento guardado ✅';

  @override
  String get foodFormSaveError =>
      'No pudimos guardar el alimento. Intenta de nuevo';

  @override
  String get foodFormValidationError => 'Revisa los campos marcados en rojo';

  @override
  String get foodDeleteConfirmTitle => '¿Eliminar este alimento?';

  @override
  String get foodDeleteConfirmBody =>
      'El alimento se desactiva pero se mantiene en los registros existentes.';

  @override
  String get foodDeleteSuccess => 'Alimento eliminado ✅';

  @override
  String get nutritionPlanEdit => 'Editar plan';

  @override
  String get nutritionPlanDays => 'Duración (días)';

  @override
  String get nutritionPlanNotes => 'Notas (opcional)';

  @override
  String nutritionistClientsCount(int count) {
    return '$count clientes sin plan nutricional';
  }

  @override
  String get nutritionistDashboardTitle => 'Inicio';

  @override
  String get nutritionistStatsClients => 'Clientes';

  @override
  String get nutritionistStatsPlans => 'Planes';

  @override
  String get nutritionistStatsFoods => 'Alimentos';

  @override
  String get nutriFabNewPlan => 'Nuevo plan';

  @override
  String get tabPlans => 'Planes';

  @override
  String get nutritionistPlansTitle => 'Planes nutricionales';

  @override
  String get nutritionistPlansEmpty =>
      'Aún no has creado ningún plan nutricional.';

  @override
  String get nutritionistTemplatesTitle => 'Plantillas de comida';

  @override
  String get foodCatalogTitle => 'Catálogo de alimentos';

  @override
  String get foodCatalogEmpty =>
      'No hay alimentos registrados. Crea el primero.';

  @override
  String get foodFormOptionalSection => 'Tal Vez';

  @override
  String get foodSearchPlaceholder => 'Buscar alimento...';

  @override
  String get mealTemplateFormTitle => 'Plantilla de comida';

  @override
  String get nutritionPlanFormTitle => 'Plan nutricional';

  @override
  String get selectClient => 'Seleccionar cliente';

  @override
  String get planDuration => 'Duración (días)';

  @override
  String get targetCalories => 'Calorías objetivo';

  @override
  String get targetProtein => 'Proteína (g)';

  @override
  String get targetCarbs => 'Carbohidratos (g)';

  @override
  String get targetFats => 'Grasas (g)';

  @override
  String get addMealTemplate => 'Agregar comida';

  @override
  String dayNumber(int number) {
    return 'Día $number';
  }
}
