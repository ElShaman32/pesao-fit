import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_strings_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppStrings
/// returned by `AppStrings.of(context)`.
///
/// Applications need to include `AppStrings.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_strings.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppStrings.localizationsDelegates,
///   supportedLocales: AppStrings.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppStrings.supportedLocales
/// property.
abstract class AppStrings {
  AppStrings(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppStrings of(BuildContext context) {
    return Localizations.of<AppStrings>(context, AppStrings)!;
  }

  static const LocalizationsDelegate<AppStrings> delegate =
      _AppStringsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('es'),
    Locale('es', 'VE'),
  ];

  /// Nombre de la aplicación.
  ///
  /// In es_VE, this message translates to:
  /// **'PESAO FIT'**
  String get appName;

  /// Tab 1 de todos los shells.
  ///
  /// In es_VE, this message translates to:
  /// **'Inicio'**
  String get tabHome;

  /// Tab de rutina (cliente).
  ///
  /// In es_VE, this message translates to:
  /// **'Rutina'**
  String get tabRoutine;

  /// Tab de nutrición (cliente).
  ///
  /// In es_VE, this message translates to:
  /// **'Nutrición'**
  String get tabNutrition;

  /// Tab de perfil (todos los roles).
  ///
  /// In es_VE, this message translates to:
  /// **'Perfil'**
  String get tabProfile;

  /// Tab de clientes (dueño/entrenador/nutricionista).
  ///
  /// In es_VE, this message translates to:
  /// **'Clientes'**
  String get tabClients;

  /// Tab de pagos (dueño/superadmin).
  ///
  /// In es_VE, this message translates to:
  /// **'Pagos'**
  String get tabPayments;

  /// Tab de gimnasios (superadmin).
  ///
  /// In es_VE, this message translates to:
  /// **'Gimnasios'**
  String get tabGyms;

  /// Tab de planes (nutricionista).
  ///
  /// In es_VE, this message translates to:
  /// **'Planes'**
  String get tabPlans;

  /// Botón para volver a intentar.
  ///
  /// In es_VE, this message translates to:
  /// **'Reintentar'**
  String get commonRetry;

  /// Botón cancelar.
  ///
  /// In es_VE, this message translates to:
  /// **'Cancelar'**
  String get commonCancel;

  /// Botón confirmar.
  ///
  /// In es_VE, this message translates to:
  /// **'Confirmar'**
  String get commonConfirm;

  /// Botón guardar.
  ///
  /// In es_VE, this message translates to:
  /// **'Guardar'**
  String get commonSave;

  /// Botón cerrar.
  ///
  /// In es_VE, this message translates to:
  /// **'Cerrar'**
  String get commonClose;

  /// Botón o semantics de retroceso.
  ///
  /// In es_VE, this message translates to:
  /// **'Atrás'**
  String get commonBack;

  /// Botón siguiente.
  ///
  /// In es_VE, this message translates to:
  /// **'Siguiente'**
  String get commonNext;

  /// Botón saltar paso.
  ///
  /// In es_VE, this message translates to:
  /// **'Saltar'**
  String get commonSkip;

  /// Placeholder de búsqueda.
  ///
  /// In es_VE, this message translates to:
  /// **'Buscar'**
  String get commonSearch;

  /// Enlace de SectionHeader.
  ///
  /// In es_VE, this message translates to:
  /// **'Ver todo'**
  String get commonSeeAll;

  /// Semantics para skeletons.
  ///
  /// In es_VE, this message translates to:
  /// **'Cargando…'**
  String get commonLoading;

  /// CTA de la acción de hoy.
  ///
  /// In es_VE, this message translates to:
  /// **'Comenzar'**
  String get commonStart;

  /// FAB contextual del rol cliente.
  ///
  /// In es_VE, this message translates to:
  /// **'Registrar ejercicio'**
  String get fabRegisterExercise;

  /// FAB contextual del rol entrenador.
  ///
  /// In es_VE, this message translates to:
  /// **'Nueva rutina'**
  String get fabNewRoutine;

  /// FAB contextual del rol dueño.
  ///
  /// In es_VE, this message translates to:
  /// **'Agregar cliente'**
  String get fabAddClient;

  /// FAB contextual del rol nutricionista.
  ///
  /// In es_VE, this message translates to:
  /// **'Nuevo plan'**
  String get fabNewPlan;

  /// FAB contextual del rol superadmin.
  ///
  /// In es_VE, this message translates to:
  /// **'Agregar gimnasio'**
  String get fabAddGym;

  /// Texto visible del OfflineBanner. Puede llevar emoji.
  ///
  /// In es_VE, this message translates to:
  /// **'Modo sin conexión — tus datos se sincronizan solos 📶'**
  String get offlineBanner;

  /// Semantics sin emoji para OfflineBanner.
  ///
  /// In es_VE, this message translates to:
  /// **'Modo sin conexión. Tus datos se sincronizan solos.'**
  String get offlineBannerSemantics;

  /// Título genérico de EmptyState.
  ///
  /// In es_VE, this message translates to:
  /// **'Nada por aquí todavía'**
  String get emptyGenericTitle;

  /// Cuerpo genérico de EmptyState.
  ///
  /// In es_VE, this message translates to:
  /// **'Cuando tengas algo, aparece en este espacio.'**
  String get emptyGenericBody;

  /// Título genérico de ErrorState.
  ///
  /// In es_VE, this message translates to:
  /// **'Algo no salió bien'**
  String get errorGenericTitle;

  /// Cuerpo genérico de ErrorState.
  ///
  /// In es_VE, this message translates to:
  /// **'Tranquilo, suele pasar. Inténtalo de nuevo.'**
  String get errorGenericBody;

  /// Botón de ErrorState.
  ///
  /// In es_VE, this message translates to:
  /// **'Reintentar'**
  String get errorGenericButton;

  /// Saludo visible de mañana.
  ///
  /// In es_VE, this message translates to:
  /// **'¡Buenos días, {name}! 👋'**
  String greetingMorning(String name);

  /// Semantics sin emoji para saludo de mañana.
  ///
  /// In es_VE, this message translates to:
  /// **'Buenos días, {name}.'**
  String greetingMorningSemantics(String name);

  /// Saludo visible de tarde.
  ///
  /// In es_VE, this message translates to:
  /// **'¡Buenas tardes, {name}! 👋'**
  String greetingAfternoon(String name);

  /// Semantics sin emoji para saludo de tarde.
  ///
  /// In es_VE, this message translates to:
  /// **'Buenas tardes, {name}.'**
  String greetingAfternoonSemantics(String name);

  /// Saludo visible de noche.
  ///
  /// In es_VE, this message translates to:
  /// **'¡Buenos noches, {name}! 👋'**
  String greetingNight(String name);

  /// Semantics sin emoji para saludo de noche.
  ///
  /// In es_VE, this message translates to:
  /// **'Buenas noches, {name}.'**
  String greetingNightSemantics(String name);

  /// Validación suave de correo.
  ///
  /// In es_VE, this message translates to:
  /// **'Hmm, ese correo no parece válido 🤔'**
  String get authEmailInvalid;

  /// Título de la pantalla de login.
  ///
  /// In es_VE, this message translates to:
  /// **'Entrar a PESAO FIT'**
  String get loginTitle;

  /// Subtítulo de la pantalla de login.
  ///
  /// In es_VE, this message translates to:
  /// **'Mete tus datos pa\' empezar a darle 💪'**
  String get loginSubtitle;

  /// Label del campo email.
  ///
  /// In es_VE, this message translates to:
  /// **'Correo electrónico'**
  String get loginEmailLabel;

  /// Hint del campo email.
  ///
  /// In es_VE, this message translates to:
  /// **'tu@correo.com'**
  String get loginEmailHint;

  /// Label del campo password.
  ///
  /// In es_VE, this message translates to:
  /// **'Contraseña'**
  String get loginPasswordLabel;

  /// Hint del campo password.
  ///
  /// In es_VE, this message translates to:
  /// **'Mínimo 6 caracteres'**
  String get loginPasswordHint;

  /// Link a recuperar contraseña.
  ///
  /// In es_VE, this message translates to:
  /// **'¿Se te olvidó la contraseña?'**
  String get loginForgot;

  /// Botón principal de login.
  ///
  /// In es_VE, this message translates to:
  /// **'Entrar'**
  String get loginSubmit;

  /// Prefijo del link a registro.
  ///
  /// In es_VE, this message translates to:
  /// **'¿No tienes cuenta?'**
  String get loginNoAccount;

  /// Link a registro.
  ///
  /// In es_VE, this message translates to:
  /// **'Regístrate aquí'**
  String get loginSignUp;

  /// Microcopy para auth/credenciales-invalidas.
  ///
  /// In es_VE, this message translates to:
  /// **'Hmm, ese correo o contraseña no cuadran 🤔'**
  String get loginErrorInvalid;

  /// Microcopy para auth/email-sin-confirmar.
  ///
  /// In es_VE, this message translates to:
  /// **'Revisa tu correo, te mandamos un link pa\' confirmar 📧'**
  String get loginErrorEmailUnconfirmed;

  /// Microcopy genérico de error de login.
  ///
  /// In es_VE, this message translates to:
  /// **'Algo no cuadró, intenta de nuevo ahorita'**
  String get loginErrorGeneric;

  /// Validación de email inválido en login.
  ///
  /// In es_VE, this message translates to:
  /// **'Ese correo no parece válido'**
  String get loginValidationEmail;

  /// Validación de password corto en login.
  ///
  /// In es_VE, this message translates to:
  /// **'La contraseña debe tener al menos 6 caracteres'**
  String get loginValidationPassword;

  /// Título de la pantalla de registro
  ///
  /// In es_VE, this message translates to:
  /// **'Crear cuenta'**
  String get registerTitle;

  /// Subtítulo de la pantalla de registro
  ///
  /// In es_VE, this message translates to:
  /// **'Únete a PESAO FIT y empieza a entrenar 💪'**
  String get registerSubtitle;

  /// Label del campo nombre
  ///
  /// In es_VE, this message translates to:
  /// **'Nombre completo'**
  String get registerFullNameLabel;

  /// Hint del campo nombre
  ///
  /// In es_VE, this message translates to:
  /// **'Tu nombre real'**
  String get registerFullNameHint;

  /// Label del campo password en registro
  ///
  /// In es_VE, this message translates to:
  /// **'Contraseña'**
  String get registerPasswordLabel;

  /// Hint del campo password en registro
  ///
  /// In es_VE, this message translates to:
  /// **'Mínimo 6 caracteres'**
  String get registerPasswordHint;

  /// Label del campo confirmar password
  ///
  /// In es_VE, this message translates to:
  /// **'Confirmar contraseña'**
  String get registerConfirmPasswordLabel;

  /// Hint del campo confirmar password
  ///
  /// In es_VE, this message translates to:
  /// **'Repite tu contraseña'**
  String get registerConfirmPasswordHint;

  /// Botón principal de registro
  ///
  /// In es_VE, this message translates to:
  /// **'Crear cuenta'**
  String get registerSubmit;

  /// Prefijo del link a login
  ///
  /// In es_VE, this message translates to:
  /// **'¿Ya tienes cuenta?'**
  String get registerHasAccount;

  /// Link a login
  ///
  /// In es_VE, this message translates to:
  /// **'Entra aquí'**
  String get registerSignIn;

  /// Microcopy para auth/email-ya-registrado
  ///
  /// In es_VE, this message translates to:
  /// **'Ese correo ya está registrado. ¿Quieres entrar?'**
  String get registerErrorEmailExists;

  /// Microcopy para auth/password-debil
  ///
  /// In es_VE, this message translates to:
  /// **'La contraseña debe tener al menos 6 caracteres'**
  String get registerErrorWeakPassword;

  /// Microcopy genérico de error de registro
  ///
  /// In es_VE, this message translates to:
  /// **'Algo no cuadró, intenta de nuevo'**
  String get registerErrorGeneric;

  /// Validación de nombre vacío
  ///
  /// In es_VE, this message translates to:
  /// **'El nombre no puede estar vacío'**
  String get registerValidationName;

  /// Validación de passwords distintos
  ///
  /// In es_VE, this message translates to:
  /// **'Las contraseñas no coinciden'**
  String get registerValidationPasswordMismatch;

  /// Título de la pantalla de selección de rol
  ///
  /// In es_VE, this message translates to:
  /// **'¿Cómo quieres usar PESAO FIT?'**
  String get onboardingTitle;

  /// Subtítulo de la pantalla de onboarding
  ///
  /// In es_VE, this message translates to:
  /// **'Elige la opción que mejor te describe 👇'**
  String get onboardingSubtitle;

  /// Título de la card del dueño
  ///
  /// In es_VE, this message translates to:
  /// **'Soy dueño de gimnasio'**
  String get onboardingOwnerTitle;

  /// Descripción de la card del dueño
  ///
  /// In es_VE, this message translates to:
  /// **'Tengo un gym y quiero gestionar clientes, staff y pagos desde la app'**
  String get onboardingOwnerDescription;

  /// Título de la card del cliente
  ///
  /// In es_VE, this message translates to:
  /// **'Soy cliente'**
  String get onboardingClientTitle;

  /// Descripción de la card del cliente
  ///
  /// In es_VE, this message translates to:
  /// **'Entreno en un gym y quiero seguir mi progreso y rutinas'**
  String get onboardingClientDescription;

  /// Botón de saltar (solo para tests, se quita en producción)
  ///
  /// In es_VE, this message translates to:
  /// **'Saltar por ahora'**
  String get onboardingSkip;

  /// Título de la pantalla de solicitud KYC
  ///
  /// In es_VE, this message translates to:
  /// **'Crear mi gimnasio'**
  String get ownerAppTitle;

  /// Subtítulo de la pantalla de solicitud
  ///
  /// In es_VE, this message translates to:
  /// **'Cuéntanos sobre ti y tu gym para verificar tu cuenta 🏋️'**
  String get ownerAppSubtitle;

  /// Título de sección de datos personales
  ///
  /// In es_VE, this message translates to:
  /// **'Tus datos'**
  String get ownerAppPersonalSection;

  /// Label del campo teléfono del dueño
  ///
  /// In es_VE, this message translates to:
  /// **'Teléfono'**
  String get ownerAppPhoneLabel;

  /// Hint del campo teléfono
  ///
  /// In es_VE, this message translates to:
  /// **'0412-1234567'**
  String get ownerAppPhoneHint;

  /// Label del campo documento
  ///
  /// In es_VE, this message translates to:
  /// **'Cédula o RIF (opcional)'**
  String get ownerAppDocumentLabel;

  /// Hint del campo documento
  ///
  /// In es_VE, this message translates to:
  /// **'V-12345678 o J-12345678-9'**
  String get ownerAppDocumentHint;

  /// Título de sección de datos del gimnasio
  ///
  /// In es_VE, this message translates to:
  /// **'Datos del gimnasio'**
  String get ownerAppGymSection;

  /// Label del campo nombre del gym
  ///
  /// In es_VE, this message translates to:
  /// **'Nombre del gimnasio'**
  String get ownerAppGymNameLabel;

  /// Hint del campo nombre del gym
  ///
  /// In es_VE, this message translates to:
  /// **'Ej: Gym Pesao'**
  String get ownerAppGymNameHint;

  /// Label del campo RIF del gym
  ///
  /// In es_VE, this message translates to:
  /// **'RIF del negocio (opcional)'**
  String get ownerAppGymRifLabel;

  /// Hint del campo RIF del gym
  ///
  /// In es_VE, this message translates to:
  /// **'J-12345678-9'**
  String get ownerAppGymRifHint;

  /// Label del campo dirección
  ///
  /// In es_VE, this message translates to:
  /// **'Dirección completa'**
  String get ownerAppGymAddressLabel;

  /// Hint del campo dirección
  ///
  /// In es_VE, this message translates to:
  /// **'Av. Lara, C.C. Cosmo, Local 12'**
  String get ownerAppGymAddressHint;

  /// Label del campo estado
  ///
  /// In es_VE, this message translates to:
  /// **'Estado'**
  String get ownerAppGymStateLabel;

  /// Label del campo ciudad
  ///
  /// In es_VE, this message translates to:
  /// **'Ciudad'**
  String get ownerAppGymCityLabel;

  /// Hint del campo ciudad
  ///
  /// In es_VE, this message translates to:
  /// **'Ej: Barquisimeto'**
  String get ownerAppGymCityHint;

  /// Label del campo teléfono del gym
  ///
  /// In es_VE, this message translates to:
  /// **'Teléfono del gimnasio'**
  String get ownerAppGymPhoneLabel;

  /// Hint del campo teléfono del gym
  ///
  /// In es_VE, this message translates to:
  /// **'0251-1234567'**
  String get ownerAppGymPhoneHint;

  /// Label del campo Instagram
  ///
  /// In es_VE, this message translates to:
  /// **'Instagram (opcional)'**
  String get ownerAppGymInstagramLabel;

  /// Hint del campo Instagram
  ///
  /// In es_VE, this message translates to:
  /// **'@gym_pesao'**
  String get ownerAppGymInstagramHint;

  /// Label del campo descripción
  ///
  /// In es_VE, this message translates to:
  /// **'Descripción (opcional)'**
  String get ownerAppGymDescriptionLabel;

  /// Hint del campo descripción
  ///
  /// In es_VE, this message translates to:
  /// **'Cuéntanos sobre tu gym en pocas líneas'**
  String get ownerAppGymDescriptionHint;

  /// Label del campo foto
  ///
  /// In es_VE, this message translates to:
  /// **'Foto del local (opcional)'**
  String get ownerAppGymPhotoLabel;

  /// Texto del botón para agregar foto
  ///
  /// In es_VE, this message translates to:
  /// **'Agregar foto'**
  String get ownerAppGymPhotoButton;

  /// Texto del botón para obtener GPS
  ///
  /// In es_VE, this message translates to:
  /// **'Usar mi ubicación'**
  String get ownerAppGymLocationButton;

  /// Botón principal de envío
  ///
  /// In es_VE, this message translates to:
  /// **'Enviar solicitud'**
  String get ownerAppSubmit;

  /// Validación de teléfono inválido
  ///
  /// In es_VE, this message translates to:
  /// **'El teléfono debe tener formato venezolano'**
  String get ownerAppValidationErrorPhone;

  /// Validación de nombre de gym vacío
  ///
  /// In es_VE, this message translates to:
  /// **'El nombre del gimnasio no puede estar vacío'**
  String get ownerAppValidationErrorGymName;

  /// Validación de dirección vacía
  ///
  /// In es_VE, this message translates to:
  /// **'La dirección no puede estar vacía'**
  String get ownerAppValidationErrorAddress;

  /// Validación de estado no seleccionado
  ///
  /// In es_VE, this message translates to:
  /// **'Debes seleccionar un estado'**
  String get ownerAppValidationErrorState;

  /// Validación de ciudad vacía
  ///
  /// In es_VE, this message translates to:
  /// **'La ciudad no puede estar vacía'**
  String get ownerAppValidationErrorCity;

  /// Título de la pantalla de éxito
  ///
  /// In es_VE, this message translates to:
  /// **'¡Solicitud enviada! 🎉'**
  String get ownerAppSuccessTitle;

  /// Mensaje de éxito tras enviar solicitud
  ///
  /// In es_VE, this message translates to:
  /// **'Recibimos tu solicitud. Te contactaremos en 24-48h para verificar tu gym. 📞'**
  String get ownerAppSuccessMessage;

  /// Botón para volver al inicio
  ///
  /// In es_VE, this message translates to:
  /// **'Volver al inicio'**
  String get ownerAppSuccessBack;

  /// Título de gym discovery
  ///
  /// In es_VE, this message translates to:
  /// **'Encuentra tu gimnasio'**
  String get gymDiscoveryTitle;

  /// Subtítulo de gym discovery
  ///
  /// In es_VE, this message translates to:
  /// **'Busca el gym donde entrenas y únete 💪'**
  String get gymDiscoverySubtitle;

  /// Hint del buscador
  ///
  /// In es_VE, this message translates to:
  /// **'Buscar por nombre...'**
  String get gymDiscoverySearchHint;

  /// Estado vacío de búsqueda
  ///
  /// In es_VE, this message translates to:
  /// **'No encontramos gimnasios con ese nombre. Intenta con otro 🤔'**
  String get gymDiscoveryEmpty;

  /// Botón para unirse a un gym
  ///
  /// In es_VE, this message translates to:
  /// **'Unirme'**
  String get gymDiscoveryJoin;

  /// Título del diálogo de confirmación
  ///
  /// In es_VE, this message translates to:
  /// **'¿Unirte a {name}?'**
  String gymDiscoveryJoinTitle(String name);

  /// Mensaje del diálogo de confirmación
  ///
  /// In es_VE, this message translates to:
  /// **'Al unirte, tu gimnasio podrá ver tu progreso y asignarte rutinas.'**
  String get gymDiscoveryJoinMessage;

  /// Botón confirmar del diálogo
  ///
  /// In es_VE, this message translates to:
  /// **'Sí, unirme'**
  String get gymDiscoveryJoinConfirm;

  /// Mensaje de éxito al unirse
  ///
  /// In es_VE, this message translates to:
  /// **'¡Ya eres parte del gym! Bienvenido 💪'**
  String get gymDiscoveryJoinSuccess;

  /// Título de la lista de solicitudes
  ///
  /// In es_VE, this message translates to:
  /// **'Solicitudes de gimnasios'**
  String get adminAppsTitle;

  /// Subtítulo de la lista
  ///
  /// In es_VE, this message translates to:
  /// **'Revisa y aprueba los nuevos gimnasios 🏋️'**
  String get adminAppsSubtitle;

  /// Estado vacío de solicitudes
  ///
  /// In es_VE, this message translates to:
  /// **'No hay solicitudes pendientes. Cuando un dueño se registre, aparece aquí.'**
  String get adminAppsEmpty;

  /// Label de fecha de envío
  ///
  /// In es_VE, this message translates to:
  /// **'Enviado'**
  String get adminAppsSubmitted;

  /// Sección datos del dueño en detalle
  ///
  /// In es_VE, this message translates to:
  /// **'Datos del dueño'**
  String get adminAppsOwnerSection;

  /// Sección datos del gym en detalle
  ///
  /// In es_VE, this message translates to:
  /// **'Datos del gimnasio'**
  String get adminAppsGymSection;

  /// Botón aprobar
  ///
  /// In es_VE, this message translates to:
  /// **'Aprobar'**
  String get adminAppsApprove;

  /// Botón rechazar
  ///
  /// In es_VE, this message translates to:
  /// **'Rechazar'**
  String get adminAppsReject;

  /// Título diálogo aprobar
  ///
  /// In es_VE, this message translates to:
  /// **'¿Aprobar {name}?'**
  String adminAppsApproveTitle(String name);

  /// Mensaje diálogo aprobar
  ///
  /// In es_VE, this message translates to:
  /// **'Se creará el gimnasio, la membresía del dueño y la suscripción Pluma por 1 año.'**
  String get adminAppsApproveMessage;

  /// Título diálogo rechazar
  ///
  /// In es_VE, this message translates to:
  /// **'Rechazar solicitud'**
  String get adminAppsRejectTitle;

  /// Label del motivo de rechazo
  ///
  /// In es_VE, this message translates to:
  /// **'Motivo del rechazo'**
  String get adminAppsRejectReasonLabel;

  /// Hint del motivo de rechazo
  ///
  /// In es_VE, this message translates to:
  /// **'Cuéntale al dueño por qué no fue aprobado...'**
  String get adminAppsRejectReasonHint;

  /// Toast de éxito al aprobar
  ///
  /// In es_VE, this message translates to:
  /// **'¡Gimnasio aprobado! El dueño ya puede entrar 🎉'**
  String get adminAppsApproveSuccess;

  /// Toast de éxito al rechazar
  ///
  /// In es_VE, this message translates to:
  /// **'Solicitud rechazada. El dueño verá el motivo.'**
  String get adminAppsRejectSuccess;

  /// Error al cargar solicitudes
  ///
  /// In es_VE, this message translates to:
  /// **'No pudimos cargar las solicitudes'**
  String get adminAppsError;

  /// Label teléfono
  ///
  /// In es_VE, this message translates to:
  /// **'Teléfono'**
  String get adminAppsFieldPhone;

  /// Label documento
  ///
  /// In es_VE, this message translates to:
  /// **'Documento'**
  String get adminAppsFieldDocument;

  /// Label dirección
  ///
  /// In es_VE, this message translates to:
  /// **'Dirección'**
  String get adminAppsFieldAddress;

  /// Label ciudad
  ///
  /// In es_VE, this message translates to:
  /// **'Ciudad'**
  String get adminAppsFieldCity;

  /// Label estado
  ///
  /// In es_VE, this message translates to:
  /// **'Estado'**
  String get adminAppsFieldState;

  /// Label Instagram
  ///
  /// In es_VE, this message translates to:
  /// **'Instagram'**
  String get adminAppsFieldInstagram;

  /// Label descripción
  ///
  /// In es_VE, this message translates to:
  /// **'Descripción'**
  String get adminAppsFieldDescription;

  /// Label RIF
  ///
  /// In es_VE, this message translates to:
  /// **'RIF'**
  String get adminAppsFieldRif;

  /// Label de StatCard gimnasios activos
  ///
  /// In es_VE, this message translates to:
  /// **'Gimnasios'**
  String get adminDashStatGyms;

  /// Sub de StatCard gimnasios
  ///
  /// In es_VE, this message translates to:
  /// **'Activos en la red'**
  String get adminDashStatGymsSub;

  /// Label de StatCard solicitudes pendientes
  ///
  /// In es_VE, this message translates to:
  /// **'Pendientes'**
  String get adminDashStatPending;

  /// Sub de StatCard pendientes
  ///
  /// In es_VE, this message translates to:
  /// **'Por revisar'**
  String get adminDashStatPendingSub;

  /// Label de StatCard suscripciones activas
  ///
  /// In es_VE, this message translates to:
  /// **'Suscripciones'**
  String get adminDashStatSubs;

  /// Sub de StatCard suscripciones
  ///
  /// In es_VE, this message translates to:
  /// **'Planes activos'**
  String get adminDashStatSubsSub;

  /// Título del PrimaryCard
  ///
  /// In es_VE, this message translates to:
  /// **'Solicitudes por revisar'**
  String get adminDashPrimaryTitle;

  /// Body del PrimaryCard
  ///
  /// In es_VE, this message translates to:
  /// **'Tienes {count} gimnasios esperando tu revisión. Llamar o visitar antes de aprobar.'**
  String adminDashPrimaryBody(int count);

  /// CTA del PrimaryCard
  ///
  /// In es_VE, this message translates to:
  /// **'Ver solicitudes'**
  String get adminDashPrimaryCta;

  /// CTA cuando no hay pendientes
  ///
  /// In es_VE, this message translates to:
  /// **'Todo al día'**
  String get adminDashPrimaryCtaNone;

  /// Sección de últimos aprobados
  ///
  /// In es_VE, this message translates to:
  /// **'Últimos gimnasios aprobados'**
  String get adminDashRecentSection;

  /// Estado vacío de recientes
  ///
  /// In es_VE, this message translates to:
  /// **'Aún no hay gimnasios aprobados'**
  String get adminDashRecentEmpty;

  /// Título del estado error
  ///
  /// In es_VE, this message translates to:
  /// **'No pudimos cargar tu panel'**
  String get adminDashErrorTitle;

  /// Body del estado error
  ///
  /// In es_VE, this message translates to:
  /// **'Tranquilo, suele pasar. Inténtalo de nuevo.'**
  String get adminDashErrorBody;

  /// Título del estado empty general
  ///
  /// In es_VE, this message translates to:
  /// **'Todo tranquilo por aquí'**
  String get adminDashEmptyTitle;

  /// Body del estado empty general
  ///
  /// In es_VE, this message translates to:
  /// **'Cuando se registren gimnasios, los números aparecen aquí.'**
  String get adminDashEmptyBody;

  /// Label StatCard kcal
  ///
  /// In es_VE, this message translates to:
  /// **'kcal hoy'**
  String get clientDashStatKcal;

  /// Sub StatCard kcal
  ///
  /// In es_VE, this message translates to:
  /// **'Meta: 2.200'**
  String get clientDashStatKcalSub;

  /// Label StatCard racha
  ///
  /// In es_VE, this message translates to:
  /// **'Racha'**
  String get clientDashStatStreak;

  /// Sub StatCard racha
  ///
  /// In es_VE, this message translates to:
  /// **'días seguidos'**
  String get clientDashStatStreakSub;

  /// Label StatCard próximo entreno
  ///
  /// In es_VE, this message translates to:
  /// **'Próximo'**
  String get clientDashStatNext;

  /// Sub StatCard próximo entreno
  ///
  /// In es_VE, this message translates to:
  /// **'entreno'**
  String get clientDashStatNextSub;

  /// Título PrimaryCard
  ///
  /// In es_VE, this message translates to:
  /// **'Entreno de hoy'**
  String get clientDashPrimaryTitle;

  /// Body PrimaryCard sin rutina
  ///
  /// In es_VE, this message translates to:
  /// **'Tu coach aún no te asigna una rutina. Cuando lo haga, aparece aquí para que empieces 💪'**
  String get clientDashPrimaryBody;

  /// CTA PrimaryCard con rutina
  ///
  /// In es_VE, this message translates to:
  /// **'Comenzar'**
  String get clientDashPrimaryCta;

  /// CTA cuando no hay rutina
  ///
  /// In es_VE, this message translates to:
  /// **'Sin entreno hoy'**
  String get clientDashPrimaryCtaNone;

  /// SectionHeader de hoy
  ///
  /// In es_VE, this message translates to:
  /// **'Hoy'**
  String get clientDashTodaySection;

  /// Empty de la sección hoy
  ///
  /// In es_VE, this message translates to:
  /// **'Nada programado para hoy. Aprovecha de descansar o hidrátate 💧'**
  String get clientDashTodayEmpty;

  /// Título estado error
  ///
  /// In es_VE, this message translates to:
  /// **'No pudimos cargar tu inicio'**
  String get clientDashErrorTitle;

  /// Body estado error
  ///
  /// In es_VE, this message translates to:
  /// **'Tranquilo, suele pasar. Inténtalo de nuevo.'**
  String get clientDashErrorBody;

  /// Label StatCard clientes activos
  ///
  /// In es_VE, this message translates to:
  /// **'Clientes'**
  String get ownerDashStatClients;

  /// Sub StatCard clientes
  ///
  /// In es_VE, this message translates to:
  /// **'Activos en tu gym'**
  String get ownerDashStatClientsSub;

  /// Label StatCard pagos por verificar
  ///
  /// In es_VE, this message translates to:
  /// **'Pagos'**
  String get ownerDashStatPayments;

  /// Sub StatCard pagos
  ///
  /// In es_VE, this message translates to:
  /// **'Por verificar'**
  String get ownerDashStatPaymentsSub;

  /// Label StatCard ingresos del mes
  ///
  /// In es_VE, this message translates to:
  /// **'Ingresos'**
  String get ownerDashStatIncome;

  /// Sub StatCard ingresos
  ///
  /// In es_VE, this message translates to:
  /// **'Este mes (Bs)'**
  String get ownerDashStatIncomeSub;

  /// Título PrimaryCard
  ///
  /// In es_VE, this message translates to:
  /// **'Comprobantes por verificar'**
  String get ownerDashPrimaryTitle;

  /// Body PrimaryCard
  ///
  /// In es_VE, this message translates to:
  /// **'Tienes {count} comprobantes de pago esperando tu revisión. Verifícalos pa\' mantener al día a tus clientes.'**
  String ownerDashPrimaryBody(int count);

  /// CTA PrimaryCard
  ///
  /// In es_VE, this message translates to:
  /// **'Ver comprobantes'**
  String get ownerDashPrimaryCta;

  /// CTA sin pendientes
  ///
  /// In es_VE, this message translates to:
  /// **'Todo al día'**
  String get ownerDashPrimaryCtaNone;

  /// SectionHeader últimos clientes
  ///
  /// In es_VE, this message translates to:
  /// **'Últimos clientes'**
  String get ownerDashRecentSection;

  /// Empty de últimos clientes
  ///
  /// In es_VE, this message translates to:
  /// **'Aún no tienes clientes registrados. Comparte el link de tu gym pa\' que se unan 💪'**
  String get ownerDashRecentEmpty;

  /// Título estado error
  ///
  /// In es_VE, this message translates to:
  /// **'No pudimos cargar tu panel'**
  String get ownerDashErrorTitle;

  /// Body estado error
  ///
  /// In es_VE, this message translates to:
  /// **'Tranquilo, suele pasar. Inténtalo de nuevo.'**
  String get ownerDashErrorBody;

  /// Label StatCard clientes asignados
  ///
  /// In es_VE, this message translates to:
  /// **'Clientes'**
  String get trainerDashStatClients;

  /// Sub StatCard clientes trainer
  ///
  /// In es_VE, this message translates to:
  /// **'Asignados a ti'**
  String get trainerDashStatClientsSub;

  /// Label StatCard sesiones hoy
  ///
  /// In es_VE, this message translates to:
  /// **'Sesiones'**
  String get trainerDashStatSessions;

  /// Sub StatCard sesiones
  ///
  /// In es_VE, this message translates to:
  /// **'Para hoy'**
  String get trainerDashStatSessionsSub;

  /// Label StatCard rutinas activas
  ///
  /// In es_VE, this message translates to:
  /// **'Rutinas'**
  String get trainerDashStatRoutines;

  /// Sub StatCard rutinas
  ///
  /// In es_VE, this message translates to:
  /// **'Activas'**
  String get trainerDashStatRoutinesSub;

  /// Título PrimaryCard trainer
  ///
  /// In es_VE, this message translates to:
  /// **'Sesiones de hoy'**
  String get trainerDashPrimaryTitle;

  /// Body PrimaryCard trainer
  ///
  /// In es_VE, this message translates to:
  /// **'Tienes {count} sesiones programadas para hoy. ¡A darle con todo! 💪'**
  String trainerDashPrimaryBody(int count);

  /// CTA PrimaryCard trainer
  ///
  /// In es_VE, this message translates to:
  /// **'Ver sesiones'**
  String get trainerDashPrimaryCta;

  /// CTA sin sesiones
  ///
  /// In es_VE, this message translates to:
  /// **'Sin sesiones hoy'**
  String get trainerDashPrimaryCtaNone;

  /// SectionHeader próximas sesiones
  ///
  /// In es_VE, this message translates to:
  /// **'Próximas sesiones'**
  String get trainerDashNextSection;

  /// Empty de próximas sesiones
  ///
  /// In es_VE, this message translates to:
  /// **'Nada programado por ahora. Cuando tus clientes agenden, aparece aquí.'**
  String get trainerDashNextEmpty;

  /// Título estado error trainer
  ///
  /// In es_VE, this message translates to:
  /// **'No pudimos cargar tu inicio'**
  String get trainerDashErrorTitle;

  /// Body estado error trainer
  ///
  /// In es_VE, this message translates to:
  /// **'Tranquilo, suele pasar. Inténtalo de nuevo.'**
  String get trainerDashErrorBody;

  /// Label StatCard planes activos
  ///
  /// In es_VE, this message translates to:
  /// **'Planes'**
  String get nutriDashStatPlans;

  /// Sub StatCard planes
  ///
  /// In es_VE, this message translates to:
  /// **'Activos'**
  String get nutriDashStatPlansSub;

  /// Label StatCard clientes con plan
  ///
  /// In es_VE, this message translates to:
  /// **'Clientes'**
  String get nutriDashStatClients;

  /// Sub StatCard clientes nutri
  ///
  /// In es_VE, this message translates to:
  /// **'Con plan asignado'**
  String get nutriDashStatClientsSub;

  /// Label StatCard consultas hoy
  ///
  /// In es_VE, this message translates to:
  /// **'Consultas'**
  String get nutriDashStatConsults;

  /// Sub StatCard consultas
  ///
  /// In es_VE, this message translates to:
  /// **'Para hoy'**
  String get nutriDashStatConsultsSub;

  /// Título PrimaryCard nutri
  ///
  /// In es_VE, this message translates to:
  /// **'Planes por revisar'**
  String get nutriDashPrimaryTitle;

  /// Body PrimaryCard nutri
  ///
  /// In es_VE, this message translates to:
  /// **'Tienes {count} planes que necesitan tu atención. Revísalos cuando puedas 🥗'**
  String nutriDashPrimaryBody(int count);

  /// CTA PrimaryCard nutri
  ///
  /// In es_VE, this message translates to:
  /// **'Ver planes'**
  String get nutriDashPrimaryCta;

  /// CTA sin planes pendientes
  ///
  /// In es_VE, this message translates to:
  /// **'Todo al día'**
  String get nutriDashPrimaryCtaNone;

  /// SectionHeader últimos planes
  ///
  /// In es_VE, this message translates to:
  /// **'Últimos planes'**
  String get nutriDashRecentSection;

  /// Empty de últimos planes
  ///
  /// In es_VE, this message translates to:
  /// **'Aún no has creado planes. Cuando lo hagas, aparecen aquí 🥗'**
  String get nutriDashRecentEmpty;

  /// Título estado error nutri
  ///
  /// In es_VE, this message translates to:
  /// **'No pudimos cargar tu inicio'**
  String get nutriDashErrorTitle;

  /// Body estado error nutri
  ///
  /// In es_VE, this message translates to:
  /// **'Tranquilo, suele pasar. Inténtalo de nuevo.'**
  String get nutriDashErrorBody;

  /// Título de la pantalla de equipo
  ///
  /// In es_VE, this message translates to:
  /// **'Mi equipo'**
  String get staffScreenTitle;

  /// Rol de entrenador en el equipo
  ///
  /// In es_VE, this message translates to:
  /// **'Entrenador'**
  String get staffRoleTrainer;

  /// Rol de nutricionista en el equipo
  ///
  /// In es_VE, this message translates to:
  /// **'Nutricionista'**
  String get staffRoleNutritionist;

  /// Estado activo de un miembro
  ///
  /// In es_VE, this message translates to:
  /// **'Activo'**
  String get staffStatusActive;

  /// Estado inactivo de un miembro
  ///
  /// In es_VE, this message translates to:
  /// **'Inactivo'**
  String get staffStatusInactive;

  /// Acción para activar a un miembro
  ///
  /// In es_VE, this message translates to:
  /// **'Activar'**
  String get staffActionActivate;

  /// Acción para desactivar a un miembro
  ///
  /// In es_VE, this message translates to:
  /// **'Desactivar'**
  String get staffActionDeactivate;

  /// Título de la sección de cupos del equipo
  ///
  /// In es_VE, this message translates to:
  /// **'Cupos del equipo'**
  String get staffLimitTitle;

  /// Estado de cupos ilimitados
  ///
  /// In es_VE, this message translates to:
  /// **'Cupos ilimitados'**
  String get staffLimitUnlimited;

  /// Aviso cuando los cupos están por agotarse
  ///
  /// In es_VE, this message translates to:
  /// **'¡Casi al límite!'**
  String get staffLimitNearLimit;

  /// Título estado vacío de equipo
  ///
  /// In es_VE, this message translates to:
  /// **'Aún no tienes equipo'**
  String get staffEmptyTitle;

  /// Body estado vacío de equipo
  ///
  /// In es_VE, this message translates to:
  /// **'Invita a tu primer entrenador o nutricionista y empieza a mover tu gimnasio 💪'**
  String get staffEmptyBody;

  /// Título estado error de equipo
  ///
  /// In es_VE, this message translates to:
  /// **'No se pudo cargar el equipo'**
  String get staffErrorTitle;

  /// Body estado error de equipo
  ///
  /// In es_VE, this message translates to:
  /// **'Revisa tu conexión e intenta de nuevo'**
  String get staffErrorBody;

  /// Título diálogo confirmación desactivar miembro
  ///
  /// In es_VE, this message translates to:
  /// **'¿Desactivar a esta persona?'**
  String get staffDeactivateConfirmTitle;

  /// Body diálogo confirmación desactivar miembro
  ///
  /// In es_VE, this message translates to:
  /// **'Dejará de aparecer como parte activa del equipo.'**
  String get staffDeactivateConfirmBody;

  /// Título diálogo confirmación activar miembro
  ///
  /// In es_VE, this message translates to:
  /// **'¿Activar a esta persona?'**
  String get staffActivateConfirmTitle;

  /// Body diálogo confirmación activar miembro
  ///
  /// In es_VE, this message translates to:
  /// **'Volverá a aparecer como parte activa del equipo.'**
  String get staffActivateConfirmBody;

  /// Mensaje de éxito al desactivar miembro
  ///
  /// In es_VE, this message translates to:
  /// **'Miembro desactivado'**
  String get staffDeactivatedSuccess;

  /// Mensaje de éxito al activar miembro
  ///
  /// In es_VE, this message translates to:
  /// **'Miembro activado'**
  String get staffActivatedSuccess;

  /// Mensaje de error genérico al realizar una acción
  ///
  /// In es_VE, this message translates to:
  /// **'No se pudo completar la acción'**
  String get staffActionError;

  /// FAB contextual para agregar staff en la pantalla Mi equipo.
  ///
  /// In es_VE, this message translates to:
  /// **'Agregar miembro del equipo'**
  String get fabAddStaff;

  /// Aviso amable de conexión débil.
  ///
  /// In es_VE, this message translates to:
  /// **'Parece que la señal está débil. Tus datos se guardan y se sincronizan solos 📶'**
  String get signalWeak;

  /// EmptyState de rutinas del cliente.
  ///
  /// In es_VE, this message translates to:
  /// **'Aún no tienes rutinas asignadas. Cuando tu coach te arme una, aparece aquí 💪'**
  String get noRoutinesYet;

  /// Toast visible de pago verificado.
  ///
  /// In es_VE, this message translates to:
  /// **'¡Pago verificado! Quedaste activo al instante ✅'**
  String get paymentVerified;

  /// Semantics sin emoji para pago verificado.
  ///
  /// In es_VE, this message translates to:
  /// **'Pago verificado. Quedaste activo al instante.'**
  String get paymentVerifiedSemantics;

  /// Celebra la racha. Texto visible.
  ///
  /// In es_VE, this message translates to:
  /// **'¡Burda! {days} días seguidos 🔥'**
  String streakCelebrate(int days);

  /// Semantics sin emoji para racha.
  ///
  /// In es_VE, this message translates to:
  /// **'¡Burda! {days} días seguidos.'**
  String streakCelebrateSemantics(int days);

  /// Semantics del botón de campana.
  ///
  /// In es_VE, this message translates to:
  /// **'Notificaciones'**
  String get notificationsLabel;

  /// Label de StatCard kcal.
  ///
  /// In es_VE, this message translates to:
  /// **'kcal hoy'**
  String get statKcalTodayLabel;

  /// Sub de StatCard kcal.
  ///
  /// In es_VE, this message translates to:
  /// **'De 2.200 kcal'**
  String get statKcalTodaySub;

  /// Label de StatCard racha.
  ///
  /// In es_VE, this message translates to:
  /// **'Racha'**
  String get statStreakLabel;

  /// Sub activo de racha.
  ///
  /// In es_VE, this message translates to:
  /// **'Vas por {days} días'**
  String streakActive(int days);

  /// Sub de racha en cero.
  ///
  /// In es_VE, this message translates to:
  /// **'Hoy puede ser el día 1'**
  String get streakIdle;

  /// Label de StatCard próximo entreno.
  ///
  /// In es_VE, this message translates to:
  /// **'Próximo entreno'**
  String get statNextWorkoutLabel;

  /// Label de StatCard progreso.
  ///
  /// In es_VE, this message translates to:
  /// **'Progreso'**
  String get statProgressLabel;

  /// Valor de StatCard progreso.
  ///
  /// In es_VE, this message translates to:
  /// **'68%'**
  String get statProgressValue;

  /// Sub de StatCard progreso.
  ///
  /// In es_VE, this message translates to:
  /// **'Plan semanal'**
  String get statProgressSub;

  /// Título de PrimaryCard.
  ///
  /// In es_VE, this message translates to:
  /// **'Entreno de hoy'**
  String get primaryCardTitle;

  /// CTA de PrimaryCard.
  ///
  /// In es_VE, this message translates to:
  /// **'Comenzar'**
  String get primaryCardAction;

  /// Sección secundaria del dashboard.
  ///
  /// In es_VE, this message translates to:
  /// **'Hoy'**
  String get sectionToday;

  /// Tile de hidratación.
  ///
  /// In es_VE, this message translates to:
  /// **'Hidratación'**
  String get hydrationTitle;

  /// Sub de tile de hidratación.
  ///
  /// In es_VE, this message translates to:
  /// **'Registra tu agua de hoy'**
  String get hydrationSubtitle;

  /// Semantics de StatCard kcal.
  ///
  /// In es_VE, this message translates to:
  /// **'Calorías de hoy: {value}.'**
  String statKcalTodaySemantic(int value);

  /// Semantics de StatCard racha.
  ///
  /// In es_VE, this message translates to:
  /// **'Racha de {days} días.'**
  String statStreakSemantic(int days);

  /// Semantics de StatCard próximo entreno.
  ///
  /// In es_VE, this message translates to:
  /// **'Próximo entreno: {title}.'**
  String statNextWorkoutSemantic(String title);

  /// No description provided for @staffAddTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Agregar miembro'**
  String get staffAddTitle;

  /// No description provided for @staffAddNameLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Nombre completo'**
  String get staffAddNameLabel;

  /// No description provided for @staffAddNameHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Ej: María Pérez'**
  String get staffAddNameHint;

  /// No description provided for @staffAddNameError.
  ///
  /// In es_VE, this message translates to:
  /// **'El nombre es obligatorio'**
  String get staffAddNameError;

  /// No description provided for @staffAddEmailLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Correo electrónico'**
  String get staffAddEmailLabel;

  /// No description provided for @staffAddEmailHint.
  ///
  /// In es_VE, this message translates to:
  /// **'correo@ejemplo.com'**
  String get staffAddEmailHint;

  /// No description provided for @staffAddEmailErrorEmpty.
  ///
  /// In es_VE, this message translates to:
  /// **'El correo es obligatorio'**
  String get staffAddEmailErrorEmpty;

  /// No description provided for @staffAddEmailErrorInvalid.
  ///
  /// In es_VE, this message translates to:
  /// **'Ese correo no parece válido'**
  String get staffAddEmailErrorInvalid;

  /// No description provided for @staffAddRoleLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Rol'**
  String get staffAddRoleLabel;

  /// No description provided for @staffAddPasswordLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Contraseña temporal'**
  String get staffAddPasswordLabel;

  /// No description provided for @staffAddPasswordHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Se genera automáticamente'**
  String get staffAddPasswordHint;

  /// No description provided for @staffAddPasswordError.
  ///
  /// In es_VE, this message translates to:
  /// **'Mínimo 6 caracteres'**
  String get staffAddPasswordError;

  /// No description provided for @staffAddPasswordRegenerate.
  ///
  /// In es_VE, this message translates to:
  /// **'Generar otra contraseña'**
  String get staffAddPasswordRegenerate;

  /// No description provided for @staffAddSubmit.
  ///
  /// In es_VE, this message translates to:
  /// **'Invitar al equipo'**
  String get staffAddSubmit;

  /// No description provided for @staffAddSubmitting.
  ///
  /// In es_VE, this message translates to:
  /// **'Invitando...'**
  String get staffAddSubmitting;

  /// No description provided for @staffAddSuccessTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'¡Miembro invitado!'**
  String get staffAddSuccessTitle;

  /// No description provided for @staffAddSuccessBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Comparte estos datos con tu nuevo miembro del equipo. La contraseña solo se muestra una vez.'**
  String get staffAddSuccessBody;

  /// No description provided for @staffAddCredentialEmail.
  ///
  /// In es_VE, this message translates to:
  /// **'Correo'**
  String get staffAddCredentialEmail;

  /// No description provided for @staffAddCredentialPassword.
  ///
  /// In es_VE, this message translates to:
  /// **'Contraseña temporal'**
  String get staffAddCredentialPassword;

  /// No description provided for @staffAddCopyTooltip.
  ///
  /// In es_VE, this message translates to:
  /// **'Copiar contraseña'**
  String get staffAddCopyTooltip;

  /// No description provided for @staffAddCopied.
  ///
  /// In es_VE, this message translates to:
  /// **'Contraseña copiada ✅'**
  String get staffAddCopied;

  /// No description provided for @staffAddCopiedSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Contraseña copiada'**
  String get staffAddCopiedSemantics;

  /// No description provided for @staffAddDone.
  ///
  /// In es_VE, this message translates to:
  /// **'Listo, volver al equipo'**
  String get staffAddDone;

  /// No description provided for @staffAddNoGym.
  ///
  /// In es_VE, this message translates to:
  /// **'No tienes un gimnasio asignado.'**
  String get staffAddNoGym;

  /// No description provided for @staffAddNoGymSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Error de gimnasio asignado'**
  String get staffAddNoGymSemantics;

  /// No description provided for @clientsScreenTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Clientes'**
  String get clientsScreenTitle;

  /// No description provided for @clientsStatActive.
  ///
  /// In es_VE, this message translates to:
  /// **'Activos'**
  String get clientsStatActive;

  /// No description provided for @clientsStatActiveSub.
  ///
  /// In es_VE, this message translates to:
  /// **'En tu gimnasio'**
  String get clientsStatActiveSub;

  /// No description provided for @clientsLimitTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Cupos de clientes'**
  String get clientsLimitTitle;

  /// No description provided for @clientsLimitUnlimited.
  ///
  /// In es_VE, this message translates to:
  /// **'Clientes ilimitados'**
  String get clientsLimitUnlimited;

  /// No description provided for @clientsLimitNearLimit.
  ///
  /// In es_VE, this message translates to:
  /// **'¡Casi al límite!'**
  String get clientsLimitNearLimit;

  /// No description provided for @clientsEmptyTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Aún no tienes clientes'**
  String get clientsEmptyTitle;

  /// No description provided for @clientsEmptyBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Cuando alguien se una a tu gimnasio, aparece aquí 💪'**
  String get clientsEmptyBody;

  /// No description provided for @clientsErrorTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'No se pudo cargar los clientes'**
  String get clientsErrorTitle;

  /// No description provided for @clientsErrorBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Revisa tu conexión e intenta de nuevo'**
  String get clientsErrorBody;

  /// No description provided for @clientsSearchHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Buscar por nombre...'**
  String get clientsSearchHint;

  /// No description provided for @clientDetailTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Detalle del cliente'**
  String get clientDetailTitle;

  /// No description provided for @clientDetailJoined.
  ///
  /// In es_VE, this message translates to:
  /// **'Miembro desde'**
  String get clientDetailJoined;

  /// No description provided for @clientDetailStatusActive.
  ///
  /// In es_VE, this message translates to:
  /// **'Activo'**
  String get clientDetailStatusActive;

  /// No description provided for @clientDetailStatusInactive.
  ///
  /// In es_VE, this message translates to:
  /// **'Inactivo'**
  String get clientDetailStatusInactive;

  /// No description provided for @clientDetailDeactivate.
  ///
  /// In es_VE, this message translates to:
  /// **'Desactivar membresía'**
  String get clientDetailDeactivate;

  /// No description provided for @clientDetailActivate.
  ///
  /// In es_VE, this message translates to:
  /// **'Activar membresía'**
  String get clientDetailActivate;

  /// No description provided for @clientDetailDeactivateConfirmTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'¿Desactivar este cliente?'**
  String get clientDetailDeactivateConfirmTitle;

  /// No description provided for @clientDetailDeactivateConfirmBody.
  ///
  /// In es_VE, this message translates to:
  /// **'El cliente perderá acceso a la app hasta que lo actives de nuevo.'**
  String get clientDetailDeactivateConfirmBody;

  /// No description provided for @clientDetailActivateConfirmTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'¿Activar este cliente?'**
  String get clientDetailActivateConfirmTitle;

  /// No description provided for @clientDetailActivateConfirmBody.
  ///
  /// In es_VE, this message translates to:
  /// **'El cliente recuperará el acceso a la app.'**
  String get clientDetailActivateConfirmBody;

  /// No description provided for @clientDeactivatedSuccess.
  ///
  /// In es_VE, this message translates to:
  /// **'Cliente desactivado'**
  String get clientDeactivatedSuccess;

  /// No description provided for @clientActivatedSuccess.
  ///
  /// In es_VE, this message translates to:
  /// **'Cliente activado'**
  String get clientActivatedSuccess;

  /// No description provided for @clientAddTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Agregar cliente'**
  String get clientAddTitle;

  /// No description provided for @clientAddNameLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Nombre completo'**
  String get clientAddNameLabel;

  /// No description provided for @clientAddNameHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Ej: Carlos Rodríguez'**
  String get clientAddNameHint;

  /// No description provided for @clientAddNameError.
  ///
  /// In es_VE, this message translates to:
  /// **'El nombre es obligatorio'**
  String get clientAddNameError;

  /// No description provided for @clientAddEmailLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Correo electrónico'**
  String get clientAddEmailLabel;

  /// No description provided for @clientAddEmailHint.
  ///
  /// In es_VE, this message translates to:
  /// **'correo@ejemplo.com'**
  String get clientAddEmailHint;

  /// No description provided for @clientAddEmailErrorEmpty.
  ///
  /// In es_VE, this message translates to:
  /// **'El correo es obligatorio'**
  String get clientAddEmailErrorEmpty;

  /// No description provided for @clientAddEmailErrorInvalid.
  ///
  /// In es_VE, this message translates to:
  /// **'Ese correo no parece válido'**
  String get clientAddEmailErrorInvalid;

  /// No description provided for @clientAddPasswordLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Contraseña temporal'**
  String get clientAddPasswordLabel;

  /// No description provided for @clientAddPasswordHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Se genera automáticamente'**
  String get clientAddPasswordHint;

  /// No description provided for @clientAddPasswordError.
  ///
  /// In es_VE, this message translates to:
  /// **'Mínimo 6 caracteres'**
  String get clientAddPasswordError;

  /// No description provided for @clientAddPasswordRegenerate.
  ///
  /// In es_VE, this message translates to:
  /// **'Generar otra contraseña'**
  String get clientAddPasswordRegenerate;

  /// No description provided for @clientAddSubmit.
  ///
  /// In es_VE, this message translates to:
  /// **'Agregar cliente'**
  String get clientAddSubmit;

  /// No description provided for @clientAddSubmitting.
  ///
  /// In es_VE, this message translates to:
  /// **'Agregando...'**
  String get clientAddSubmitting;

  /// No description provided for @clientAddSuccessTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'¡Cliente agregado!'**
  String get clientAddSuccessTitle;

  /// No description provided for @clientAddSuccessBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Comparte estos datos con tu cliente. La contraseña solo se muestra una vez.'**
  String get clientAddSuccessBody;

  /// No description provided for @clientAddCredentialEmail.
  ///
  /// In es_VE, this message translates to:
  /// **'Correo'**
  String get clientAddCredentialEmail;

  /// No description provided for @clientAddCredentialPassword.
  ///
  /// In es_VE, this message translates to:
  /// **'Contraseña temporal'**
  String get clientAddCredentialPassword;

  /// No description provided for @clientAddCopyTooltip.
  ///
  /// In es_VE, this message translates to:
  /// **'Copiar contraseña'**
  String get clientAddCopyTooltip;

  /// No description provided for @clientAddCopied.
  ///
  /// In es_VE, this message translates to:
  /// **'Contraseña copiada ✅'**
  String get clientAddCopied;

  /// No description provided for @clientAddCopiedSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Contraseña copiada'**
  String get clientAddCopiedSemantics;

  /// No description provided for @clientAddDone.
  ///
  /// In es_VE, this message translates to:
  /// **'Listo, volver a clientes'**
  String get clientAddDone;

  /// No description provided for @clientAddNoGym.
  ///
  /// In es_VE, this message translates to:
  /// **'No tienes un gimnasio asignado.'**
  String get clientAddNoGym;

  /// No description provided for @clientAddNoGymSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Error de gimnasio asignado'**
  String get clientAddNoGymSemantics;

  /// No description provided for @clientAddLimitReached.
  ///
  /// In es_VE, this message translates to:
  /// **'Ya llegaste al límite de clientes de tu plan. Actualiza a Hierro para agregar más.'**
  String get clientAddLimitReached;

  /// No description provided for @paymentsScreenTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Pagos'**
  String get paymentsScreenTitle;

  /// No description provided for @paymentsFilterPending.
  ///
  /// In es_VE, this message translates to:
  /// **'Pendientes'**
  String get paymentsFilterPending;

  /// No description provided for @paymentsFilterVerified.
  ///
  /// In es_VE, this message translates to:
  /// **'Verificados'**
  String get paymentsFilterVerified;

  /// No description provided for @paymentsFilterRejected.
  ///
  /// In es_VE, this message translates to:
  /// **'Rechazados'**
  String get paymentsFilterRejected;

  /// No description provided for @paymentsEmptyPendingTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Sin comprobantes pendientes'**
  String get paymentsEmptyPendingTitle;

  /// No description provided for @paymentsEmptyPendingBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Cuando un cliente suba un pago, aparece aquí.'**
  String get paymentsEmptyPendingBody;

  /// No description provided for @paymentsEmptyVerifiedTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Nada verificado todavía'**
  String get paymentsEmptyVerifiedTitle;

  /// No description provided for @paymentsEmptyVerifiedBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Los pagos aprobados aparecen aquí.'**
  String get paymentsEmptyVerifiedBody;

  /// No description provided for @paymentsEmptyRejectedTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Nada rechazado'**
  String get paymentsEmptyRejectedTitle;

  /// No description provided for @paymentsEmptyRejectedBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Los pagos rechazados aparecen aquí.'**
  String get paymentsEmptyRejectedBody;

  /// No description provided for @paymentsErrorTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'No pudimos cargar los pagos'**
  String get paymentsErrorTitle;

  /// No description provided for @paymentsErrorBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Tranquilo, suele pasar. Inténtalo de nuevo.'**
  String get paymentsErrorBody;

  /// No description provided for @paymentsOfflineEmpty.
  ///
  /// In es_VE, this message translates to:
  /// **'Sin conexión. Los pagos se revisan cuando vuelva la señal.'**
  String get paymentsOfflineEmpty;

  /// No description provided for @paymentDetailTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Detalle del pago'**
  String get paymentDetailTitle;

  /// No description provided for @paymentDetailClient.
  ///
  /// In es_VE, this message translates to:
  /// **'Cliente'**
  String get paymentDetailClient;

  /// No description provided for @paymentDetailAmountUsd.
  ///
  /// In es_VE, this message translates to:
  /// **'Monto USD'**
  String get paymentDetailAmountUsd;

  /// No description provided for @paymentDetailAmountBs.
  ///
  /// In es_VE, this message translates to:
  /// **'Monto Bs'**
  String get paymentDetailAmountBs;

  /// No description provided for @paymentDetailRate.
  ///
  /// In es_VE, this message translates to:
  /// **'Tasa usada'**
  String get paymentDetailRate;

  /// No description provided for @paymentDetailDate.
  ///
  /// In es_VE, this message translates to:
  /// **'Fecha'**
  String get paymentDetailDate;

  /// No description provided for @paymentDetailReceipt.
  ///
  /// In es_VE, this message translates to:
  /// **'Comprobante'**
  String get paymentDetailReceipt;

  /// No description provided for @paymentDetailApprove.
  ///
  /// In es_VE, this message translates to:
  /// **'Aprobar'**
  String get paymentDetailApprove;

  /// No description provided for @paymentDetailReject.
  ///
  /// In es_VE, this message translates to:
  /// **'Rechazar'**
  String get paymentDetailReject;

  /// No description provided for @paymentApproveConfirmTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'¿Aprobar este pago?'**
  String get paymentApproveConfirmTitle;

  /// No description provided for @paymentApproveConfirmBody.
  ///
  /// In es_VE, this message translates to:
  /// **'El cliente quedará activo y el pago marcado como verificado.'**
  String get paymentApproveConfirmBody;

  /// No description provided for @paymentRejectDialogTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Rechazar pago'**
  String get paymentRejectDialogTitle;

  /// No description provided for @paymentRejectDialogBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Cuéntale al cliente por qué no pudiste aprobarlo.'**
  String get paymentRejectDialogBody;

  /// No description provided for @paymentRejectReasonLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Motivo del rechazo'**
  String get paymentRejectReasonLabel;

  /// No description provided for @paymentRejectReasonHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Ej: la imagen está borrosa'**
  String get paymentRejectReasonHint;

  /// No description provided for @paymentRejectReasonError.
  ///
  /// In es_VE, this message translates to:
  /// **'Escribe un motivo'**
  String get paymentRejectReasonError;

  /// No description provided for @paymentApprovedSuccess.
  ///
  /// In es_VE, this message translates to:
  /// **'Pago aprobado ✅'**
  String get paymentApprovedSuccess;

  /// No description provided for @paymentApprovedSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Pago aprobado'**
  String get paymentApprovedSemantics;

  /// No description provided for @paymentRejectedSuccess.
  ///
  /// In es_VE, this message translates to:
  /// **'Pago rechazado'**
  String get paymentRejectedSuccess;

  /// No description provided for @paymentRejectedSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Pago rechazado'**
  String get paymentRejectedSemantics;

  /// No description provided for @paymentActionError.
  ///
  /// In es_VE, this message translates to:
  /// **'No pudimos completar la acción'**
  String get paymentActionError;

  /// No description provided for @paymentStatusPending.
  ///
  /// In es_VE, this message translates to:
  /// **'Pendiente'**
  String get paymentStatusPending;

  /// No description provided for @paymentStatusVerified.
  ///
  /// In es_VE, this message translates to:
  /// **'Verificado'**
  String get paymentStatusVerified;

  /// No description provided for @paymentStatusRejected.
  ///
  /// In es_VE, this message translates to:
  /// **'Rechazado'**
  String get paymentStatusRejected;

  /// No description provided for @paymentsFabRegister.
  ///
  /// In es_VE, this message translates to:
  /// **'Registrar pago'**
  String get paymentsFabRegister;

  /// No description provided for @uploadPaymentTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Subir pago'**
  String get uploadPaymentTitle;

  /// No description provided for @uploadPaymentSubtitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Registra tu pago manual (Pago Móvil o transferencia). Lo verificamos en menos de 24h.'**
  String get uploadPaymentSubtitle;

  /// No description provided for @uploadPaymentAmountBsLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Monto en Bs'**
  String get uploadPaymentAmountBsLabel;

  /// No description provided for @uploadPaymentAmountBsHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Ej: 15000'**
  String get uploadPaymentAmountBsHint;

  /// No description provided for @uploadPaymentAmountBsError.
  ///
  /// In es_VE, this message translates to:
  /// **'El monto debe ser mayor a cero'**
  String get uploadPaymentAmountBsError;

  /// No description provided for @uploadPaymentAmountUsdLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Monto en USD'**
  String get uploadPaymentAmountUsdLabel;

  /// No description provided for @uploadPaymentAmountUsdHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Se calcula con la tasa del gimnasio'**
  String get uploadPaymentAmountUsdHint;

  /// No description provided for @uploadPaymentRateLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Tasa usada'**
  String get uploadPaymentRateLabel;

  /// No description provided for @uploadPaymentRateError.
  ///
  /// In es_VE, this message translates to:
  /// **'No hay tasa configurada en tu gimnasio'**
  String get uploadPaymentRateError;

  /// No description provided for @uploadPaymentPickImage.
  ///
  /// In es_VE, this message translates to:
  /// **'Tomar o elegir foto del comprobante'**
  String get uploadPaymentPickImage;

  /// No description provided for @uploadPaymentPickImageError.
  ///
  /// In es_VE, this message translates to:
  /// **'Necesitamos una foto del comprobante'**
  String get uploadPaymentPickImageError;

  /// No description provided for @uploadPaymentReplaceImage.
  ///
  /// In es_VE, this message translates to:
  /// **'Cambiar foto'**
  String get uploadPaymentReplaceImage;

  /// No description provided for @uploadPaymentSubmit.
  ///
  /// In es_VE, this message translates to:
  /// **'Enviar comprobante'**
  String get uploadPaymentSubmit;

  /// No description provided for @uploadPaymentSubmitting.
  ///
  /// In es_VE, this message translates to:
  /// **'Subiendo...'**
  String get uploadPaymentSubmitting;

  /// No description provided for @uploadPaymentSuccessTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'¡Pago enviado! 📩'**
  String get uploadPaymentSuccessTitle;

  /// No description provided for @uploadPaymentSuccessBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Tu comprobante está en revisión. Te avisamos cuando lo aprobemos.'**
  String get uploadPaymentSuccessBody;

  /// No description provided for @uploadPaymentSuccessSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Pago enviado, en revisión'**
  String get uploadPaymentSuccessSemantics;

  /// No description provided for @uploadPaymentErrorTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'No pudimos subir tu pago'**
  String get uploadPaymentErrorTitle;

  /// No description provided for @uploadPaymentErrorSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Error al subir el pago'**
  String get uploadPaymentErrorSemantics;

  /// No description provided for @uploadPaymentNoRateTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Tu gimnasio no tiene tasa configurada'**
  String get uploadPaymentNoRateTitle;

  /// No description provided for @uploadPaymentNoRateBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Pídele al dueño que configure la tasa del día para poder subir pagos.'**
  String get uploadPaymentNoRateBody;

  /// No description provided for @clientDashPrimaryCtaUpload.
  ///
  /// In es_VE, this message translates to:
  /// **'Subir pago'**
  String get clientDashPrimaryCtaUpload;

  /// No description provided for @clientDashPrimaryUploadTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Tu mensualidad'**
  String get clientDashPrimaryUploadTitle;

  /// No description provided for @clientDashPrimaryUploadBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Sube el comprobante de tu pago para seguir activo en el gimnasio.'**
  String get clientDashPrimaryUploadBody;

  /// No description provided for @clientDashUploadFab.
  ///
  /// In es_VE, this message translates to:
  /// **'Subir pago'**
  String get clientDashUploadFab;

  /// No description provided for @plansScreenTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Planes del gimnasio'**
  String get plansScreenTitle;

  /// No description provided for @plansEmptyTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Aún no tienes planes'**
  String get plansEmptyTitle;

  /// No description provided for @plansEmptyBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Crea tu primer plan para que tus clientes elijan cuánto pagar 💪'**
  String get plansEmptyBody;

  /// No description provided for @plansCreateFab.
  ///
  /// In es_VE, this message translates to:
  /// **'Crear plan'**
  String get plansCreateFab;

  /// No description provided for @plansErrorTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'No pudimos cargar los planes'**
  String get plansErrorTitle;

  /// No description provided for @plansErrorBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Tranquilo, suele pasar. Inténtalo de nuevo.'**
  String get plansErrorBody;

  /// No description provided for @planFormCreateTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Crear plan'**
  String get planFormCreateTitle;

  /// No description provided for @planFormEditTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Editar plan'**
  String get planFormEditTitle;

  /// No description provided for @planFormNameLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Nombre del plan'**
  String get planFormNameLabel;

  /// No description provided for @planFormNameHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Ej: Con Coach'**
  String get planFormNameHint;

  /// No description provided for @planFormNameError.
  ///
  /// In es_VE, this message translates to:
  /// **'El nombre es obligatorio'**
  String get planFormNameError;

  /// No description provided for @planFormDescriptionLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Descripción (opcional)'**
  String get planFormDescriptionLabel;

  /// No description provided for @planFormDescriptionHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Qué incluye este plan'**
  String get planFormDescriptionHint;

  /// No description provided for @planFormPriceLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Precio en USD'**
  String get planFormPriceLabel;

  /// No description provided for @planFormPriceHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Ej: 30'**
  String get planFormPriceHint;

  /// No description provided for @planFormPriceError.
  ///
  /// In es_VE, this message translates to:
  /// **'El precio debe ser mayor a cero'**
  String get planFormPriceError;

  /// No description provided for @planFormDurationLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Duración (días)'**
  String get planFormDurationLabel;

  /// No description provided for @planFormDurationHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Ej: 30'**
  String get planFormDurationHint;

  /// No description provided for @planFormDurationError.
  ///
  /// In es_VE, this message translates to:
  /// **'La duración debe ser al menos 1 día'**
  String get planFormDurationError;

  /// No description provided for @planFormIncludesTrainer.
  ///
  /// In es_VE, this message translates to:
  /// **'Incluye entrenador personal'**
  String get planFormIncludesTrainer;

  /// No description provided for @planFormIncludesNutritionist.
  ///
  /// In es_VE, this message translates to:
  /// **'Incluye nutricionista'**
  String get planFormIncludesNutritionist;

  /// No description provided for @planFormSubmit.
  ///
  /// In es_VE, this message translates to:
  /// **'Guardar plan'**
  String get planFormSubmit;

  /// No description provided for @planFormSubmitting.
  ///
  /// In es_VE, this message translates to:
  /// **'Guardando...'**
  String get planFormSubmitting;

  /// No description provided for @planCreatedSuccess.
  ///
  /// In es_VE, this message translates to:
  /// **'Plan creado ✅'**
  String get planCreatedSuccess;

  /// No description provided for @planCreatedSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Plan creado'**
  String get planCreatedSemantics;

  /// No description provided for @planUpdatedSuccess.
  ///
  /// In es_VE, this message translates to:
  /// **'Plan actualizado ✅'**
  String get planUpdatedSuccess;

  /// No description provided for @planUpdatedSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Plan actualizado'**
  String get planUpdatedSemantics;

  /// No description provided for @planLimitReachedTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Límite de planes alcanzado'**
  String get planLimitReachedTitle;

  /// No description provided for @planLimitReachedBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Tu plan actual no permite más planes. Actualiza a Hierro para crear más.'**
  String get planLimitReachedBody;

  /// No description provided for @planDeactivateConfirmTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'¿Desactivar este plan?'**
  String get planDeactivateConfirmTitle;

  /// No description provided for @planDeactivateConfirmBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Los clientes actuales lo mantienen, pero no se podrá asignar a nuevos clientes.'**
  String get planDeactivateConfirmBody;

  /// No description provided for @planDeactivatedSuccess.
  ///
  /// In es_VE, this message translates to:
  /// **'Plan desactivado'**
  String get planDeactivatedSuccess;

  /// No description provided for @planDeactivatedSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Plan desactivado'**
  String get planDeactivatedSemantics;

  /// No description provided for @planActiveBadge.
  ///
  /// In es_VE, this message translates to:
  /// **'Activo'**
  String get planActiveBadge;

  /// No description provided for @planInactiveBadge.
  ///
  /// In es_VE, this message translates to:
  /// **'Inactivo'**
  String get planInactiveBadge;

  /// No description provided for @planPerMonth.
  ///
  /// In es_VE, this message translates to:
  /// **'/mes'**
  String get planPerMonth;

  /// No description provided for @planDurationDays.
  ///
  /// In es_VE, this message translates to:
  /// **'{days} días'**
  String planDurationDays(Object days);

  /// No description provided for @subscriptionCardTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Tu plan'**
  String get subscriptionCardTitle;

  /// No description provided for @subscriptionCardNoPlanTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Sin plan asignado'**
  String get subscriptionCardNoPlanTitle;

  /// No description provided for @subscriptionCardNoPlanBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Tu gimnasio aún no te asigna un plan. Pregúntale al dueño 💪'**
  String get subscriptionCardNoPlanBody;

  /// No description provided for @subscriptionBalanceOwed.
  ///
  /// In es_VE, this message translates to:
  /// **'Debes'**
  String get subscriptionBalanceOwed;

  /// No description provided for @subscriptionBalancePaid.
  ///
  /// In es_VE, this message translates to:
  /// **'Estás al día'**
  String get subscriptionBalancePaid;

  /// No description provided for @subscriptionBalanceCredit.
  ///
  /// In es_VE, this message translates to:
  /// **'Tienes a favor'**
  String get subscriptionBalanceCredit;

  /// No description provided for @subscriptionExpiresLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Vence'**
  String get subscriptionExpiresLabel;

  /// No description provided for @subscriptionPayCta.
  ///
  /// In es_VE, this message translates to:
  /// **'Pagar'**
  String get subscriptionPayCta;

  /// No description provided for @subscriptionStatusActive.
  ///
  /// In es_VE, this message translates to:
  /// **'Activo'**
  String get subscriptionStatusActive;

  /// No description provided for @subscriptionStatusExpired.
  ///
  /// In es_VE, this message translates to:
  /// **'Vencido'**
  String get subscriptionStatusExpired;

  /// No description provided for @subscriptionStatusSuspended.
  ///
  /// In es_VE, this message translates to:
  /// **'Suspendido'**
  String get subscriptionStatusSuspended;

  /// No description provided for @assignPlanTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Asignar plan'**
  String get assignPlanTitle;

  /// No description provided for @assignPlanSubtitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Elige el plan para este cliente'**
  String get assignPlanSubtitle;

  /// No description provided for @assignPlanNoPlansTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'No tienes planes creados'**
  String get assignPlanNoPlansTitle;

  /// No description provided for @assignPlanNoPlansBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Primero crea un plan en la sección de planes.'**
  String get assignPlanNoPlansBody;

  /// No description provided for @assignPlanConfirm.
  ///
  /// In es_VE, this message translates to:
  /// **'Asignar'**
  String get assignPlanConfirm;

  /// No description provided for @assignPlanSuccess.
  ///
  /// In es_VE, this message translates to:
  /// **'Plan asignado ✅'**
  String get assignPlanSuccess;

  /// No description provided for @assignPlanSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Plan asignado'**
  String get assignPlanSemantics;

  /// No description provided for @assignPlanCurrentLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Plan actual'**
  String get assignPlanCurrentLabel;

  /// No description provided for @assignPlanChangeCta.
  ///
  /// In es_VE, this message translates to:
  /// **'Cambiar plan'**
  String get assignPlanChangeCta;

  /// No description provided for @assignPlanAssignCta.
  ///
  /// In es_VE, this message translates to:
  /// **'Asignar plan'**
  String get assignPlanAssignCta;

  /// No description provided for @uploadPaymentPlanLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Plan'**
  String get uploadPaymentPlanLabel;

  /// No description provided for @uploadPaymentBalanceLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Saldo pendiente'**
  String get uploadPaymentBalanceLabel;

  /// No description provided for @uploadPaymentCreditLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Saldo a favor'**
  String get uploadPaymentCreditLabel;

  /// No description provided for @ownerClientPlanSection.
  ///
  /// In es_VE, this message translates to:
  /// **'Plan del cliente'**
  String get ownerClientPlanSection;

  /// No description provided for @ownerClientNoPlan.
  ///
  /// In es_VE, this message translates to:
  /// **'Sin plan asignado'**
  String get ownerClientNoPlan;

  /// No description provided for @fabCreatePlan.
  ///
  /// In es_VE, this message translates to:
  /// **'Nuevo plan'**
  String get fabCreatePlan;

  /// No description provided for @exercisesScreenTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Ejercicios'**
  String get exercisesScreenTitle;

  /// No description provided for @exercisesSearchHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Buscar ejercicio...'**
  String get exercisesSearchHint;

  /// No description provided for @exercisesEmptyTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Aún no hay ejercicios'**
  String get exercisesEmptyTitle;

  /// No description provided for @exercisesEmptyBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Crea tu primer ejercicio personalizado o usa la biblioteca base 💪'**
  String get exercisesEmptyBody;

  /// No description provided for @exercisesErrorTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'No pudimos cargar los ejercicios'**
  String get exercisesErrorTitle;

  /// No description provided for @exercisesErrorBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Tranquilo, suele pasar. Inténtalo de nuevo.'**
  String get exercisesErrorBody;

  /// No description provided for @exercisesGlobalBadge.
  ///
  /// In es_VE, this message translates to:
  /// **'Biblioteca'**
  String get exercisesGlobalBadge;

  /// No description provided for @exercisesCustomBadge.
  ///
  /// In es_VE, this message translates to:
  /// **'Del gym'**
  String get exercisesCustomBadge;

  /// No description provided for @exerciseFormCreateTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Crear ejercicio'**
  String get exerciseFormCreateTitle;

  /// No description provided for @exerciseFormEditTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Editar ejercicio'**
  String get exerciseFormEditTitle;

  /// No description provided for @exerciseFormNameLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Nombre del ejercicio'**
  String get exerciseFormNameLabel;

  /// No description provided for @exerciseFormNameHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Ej: Sentadilla búlgara'**
  String get exerciseFormNameHint;

  /// No description provided for @exerciseFormNameError.
  ///
  /// In es_VE, this message translates to:
  /// **'El nombre es obligatorio'**
  String get exerciseFormNameError;

  /// No description provided for @exerciseFormDescriptionLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Descripción (opcional)'**
  String get exerciseFormDescriptionLabel;

  /// No description provided for @exerciseFormDescriptionHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Cómo se hace, qué trabaja'**
  String get exerciseFormDescriptionHint;

  /// No description provided for @exerciseFormMuscleGroupLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Grupo muscular'**
  String get exerciseFormMuscleGroupLabel;

  /// No description provided for @exerciseFormSubmit.
  ///
  /// In es_VE, this message translates to:
  /// **'Guardar ejercicio'**
  String get exerciseFormSubmit;

  /// No description provided for @exerciseFormSubmitting.
  ///
  /// In es_VE, this message translates to:
  /// **'Guardando...'**
  String get exerciseFormSubmitting;

  /// No description provided for @exerciseCreatedSuccess.
  ///
  /// In es_VE, this message translates to:
  /// **'Ejercicio creado ✅'**
  String get exerciseCreatedSuccess;

  /// No description provided for @exerciseCreatedSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Ejercicio creado'**
  String get exerciseCreatedSemantics;

  /// No description provided for @exerciseUpdatedSuccess.
  ///
  /// In es_VE, this message translates to:
  /// **'Ejercicio actualizado ✅'**
  String get exerciseUpdatedSuccess;

  /// No description provided for @exerciseUpdatedSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Ejercicio actualizado'**
  String get exerciseUpdatedSemantics;

  /// No description provided for @routinesScreenTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Rutinas'**
  String get routinesScreenTitle;

  /// No description provided for @routinesEmptyTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Aún no tienes rutinas'**
  String get routinesEmptyTitle;

  /// No description provided for @routinesEmptyBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Crea la primera rutina para tus clientes 💪'**
  String get routinesEmptyBody;

  /// No description provided for @routinesErrorTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'No pudimos cargar las rutinas'**
  String get routinesErrorTitle;

  /// No description provided for @routinesErrorBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Tranquilo, suele pasar. Inténtalo de nuevo.'**
  String get routinesErrorBody;

  /// No description provided for @routineFormCreateTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Nueva rutina'**
  String get routineFormCreateTitle;

  /// No description provided for @routineFormEditTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Editar rutina'**
  String get routineFormEditTitle;

  /// No description provided for @routineFormNameLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Nombre de la rutina'**
  String get routineFormNameLabel;

  /// No description provided for @routineFormNameHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Ej: Tren superior - Día 1'**
  String get routineFormNameHint;

  /// No description provided for @routineFormNameError.
  ///
  /// In es_VE, this message translates to:
  /// **'El nombre es obligatorio'**
  String get routineFormNameError;

  /// No description provided for @routineFormDescriptionLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Descripción (opcional)'**
  String get routineFormDescriptionLabel;

  /// No description provided for @routineFormDescriptionHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Objetivo de la rutina'**
  String get routineFormDescriptionHint;

  /// No description provided for @routineFormClientLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Cliente'**
  String get routineFormClientLabel;

  /// No description provided for @routineFormClientError.
  ///
  /// In es_VE, this message translates to:
  /// **'Selecciona un cliente'**
  String get routineFormClientError;

  /// No description provided for @routineFormExercisesLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Ejercicios'**
  String get routineFormExercisesLabel;

  /// No description provided for @routineFormAddExercise.
  ///
  /// In es_VE, this message translates to:
  /// **'Agregar ejercicio'**
  String get routineFormAddExercise;

  /// No description provided for @routineFormNoExercises.
  ///
  /// In es_VE, this message translates to:
  /// **'Agrega al menos un ejercicio'**
  String get routineFormNoExercises;

  /// No description provided for @routineFormSubmit.
  ///
  /// In es_VE, this message translates to:
  /// **'Guardar rutina'**
  String get routineFormSubmit;

  /// No description provided for @routineFormSubmitting.
  ///
  /// In es_VE, this message translates to:
  /// **'Guardando...'**
  String get routineFormSubmitting;

  /// No description provided for @routineCreatedSuccess.
  ///
  /// In es_VE, this message translates to:
  /// **'Rutina creada ✅'**
  String get routineCreatedSuccess;

  /// No description provided for @routineCreatedSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Rutina creada'**
  String get routineCreatedSemantics;

  /// No description provided for @routineUpdatedSuccess.
  ///
  /// In es_VE, this message translates to:
  /// **'Rutina actualizada ✅'**
  String get routineUpdatedSuccess;

  /// No description provided for @routineUpdatedSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Rutina actualizada'**
  String get routineUpdatedSemantics;

  /// No description provided for @routineExerciseSets.
  ///
  /// In es_VE, this message translates to:
  /// **'Series'**
  String get routineExerciseSets;

  /// No description provided for @routineExerciseReps.
  ///
  /// In es_VE, this message translates to:
  /// **'Reps'**
  String get routineExerciseReps;

  /// No description provided for @routineExerciseWeight.
  ///
  /// In es_VE, this message translates to:
  /// **'Peso (kg)'**
  String get routineExerciseWeight;

  /// No description provided for @routineExerciseRest.
  ///
  /// In es_VE, this message translates to:
  /// **'Descanso (seg)'**
  String get routineExerciseRest;

  /// No description provided for @routineExerciseNotes.
  ///
  /// In es_VE, this message translates to:
  /// **'Notas'**
  String get routineExerciseNotes;

  /// No description provided for @muscleGroupChest.
  ///
  /// In es_VE, this message translates to:
  /// **'Pecho'**
  String get muscleGroupChest;

  /// No description provided for @muscleGroupBack.
  ///
  /// In es_VE, this message translates to:
  /// **'Espalda'**
  String get muscleGroupBack;

  /// No description provided for @muscleGroupShoulders.
  ///
  /// In es_VE, this message translates to:
  /// **'Hombros'**
  String get muscleGroupShoulders;

  /// No description provided for @muscleGroupBiceps.
  ///
  /// In es_VE, this message translates to:
  /// **'Bíceps'**
  String get muscleGroupBiceps;

  /// No description provided for @muscleGroupTriceps.
  ///
  /// In es_VE, this message translates to:
  /// **'Tríceps'**
  String get muscleGroupTriceps;

  /// No description provided for @muscleGroupLegs.
  ///
  /// In es_VE, this message translates to:
  /// **'Piernas'**
  String get muscleGroupLegs;

  /// No description provided for @muscleGroupGlutes.
  ///
  /// In es_VE, this message translates to:
  /// **'Glúteos'**
  String get muscleGroupGlutes;

  /// No description provided for @muscleGroupCore.
  ///
  /// In es_VE, this message translates to:
  /// **'Core'**
  String get muscleGroupCore;

  /// No description provided for @muscleGroupCardio.
  ///
  /// In es_VE, this message translates to:
  /// **'Cardio'**
  String get muscleGroupCardio;

  /// No description provided for @muscleGroupFullBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Full body'**
  String get muscleGroupFullBody;

  /// No description provided for @muscleGroupAll.
  ///
  /// In es_VE, this message translates to:
  /// **'Todos'**
  String get muscleGroupAll;

  /// No description provided for @fabCreateExercise.
  ///
  /// In es_VE, this message translates to:
  /// **'Crear ejercicio'**
  String get fabCreateExercise;

  /// No description provided for @fabCreateRoutine.
  ///
  /// In es_VE, this message translates to:
  /// **'Nueva rutina'**
  String get fabCreateRoutine;

  /// No description provided for @clientRoutineScreenTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Mi rutina'**
  String get clientRoutineScreenTitle;

  /// No description provided for @clientRoutineEmptyTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Sin rutina asignada'**
  String get clientRoutineEmptyTitle;

  /// No description provided for @clientRoutineEmptyBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Tu entrenador aún no te asigna una rutina. Cuando lo haga, aparece aquí 💪'**
  String get clientRoutineEmptyBody;

  /// No description provided for @clientRoutineErrorTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'No pudimos cargar tu rutina'**
  String get clientRoutineErrorTitle;

  /// No description provided for @clientRoutineErrorBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Tranquilo, suele pasar. Inténtalo de nuevo.'**
  String get clientRoutineErrorBody;

  /// No description provided for @clientRoutineExerciseCount.
  ///
  /// In es_VE, this message translates to:
  /// **'{count} ejercicios'**
  String clientRoutineExerciseCount(Object count);

  /// No description provided for @clientRoutineExerciseSets.
  ///
  /// In es_VE, this message translates to:
  /// **'{sets} series'**
  String clientRoutineExerciseSets(Object sets);

  /// No description provided for @clientRoutineExerciseReps.
  ///
  /// In es_VE, this message translates to:
  /// **'{reps} reps'**
  String clientRoutineExerciseReps(Object reps);

  /// No description provided for @clientRoutineExerciseWeight.
  ///
  /// In es_VE, this message translates to:
  /// **'{weight} kg'**
  String clientRoutineExerciseWeight(Object weight);

  /// No description provided for @clientRoutineExerciseRest.
  ///
  /// In es_VE, this message translates to:
  /// **'{rest}s descanso'**
  String clientRoutineExerciseRest(Object rest);

  /// No description provided for @clientRoutineExerciseNotes.
  ///
  /// In es_VE, this message translates to:
  /// **'Notas'**
  String get clientRoutineExerciseNotes;

  /// No description provided for @clientDashPrimaryRoutineTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Tu rutina'**
  String get clientDashPrimaryRoutineTitle;

  /// No description provided for @clientDashPrimaryRoutineBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Tienes {count} ejercicios por hacer hoy'**
  String clientDashPrimaryRoutineBody(Object count);

  /// No description provided for @clientDashPrimaryRoutineCta.
  ///
  /// In es_VE, this message translates to:
  /// **'Ver rutina'**
  String get clientDashPrimaryRoutineCta;

  /// No description provided for @clientDashPrimaryRoutineCtaNone.
  ///
  /// In es_VE, this message translates to:
  /// **'Sin rutina'**
  String get clientDashPrimaryRoutineCtaNone;

  /// No description provided for @plansTabTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Planes'**
  String get plansTabTitle;

  /// No description provided for @routinesTabTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Rutinas'**
  String get routinesTabTitle;

  /// No description provided for @trainingPlansScreenTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Planes de entrenamiento'**
  String get trainingPlansScreenTitle;

  /// No description provided for @trainingPlansEmptyTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Aún no tienes planes'**
  String get trainingPlansEmptyTitle;

  /// No description provided for @trainingPlansEmptyBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Crea un plan semanal para tus clientes y olvídate de asignar rutinas a diario 💪'**
  String get trainingPlansEmptyBody;

  /// No description provided for @trainingPlansErrorTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'No pudimos cargar los planes'**
  String get trainingPlansErrorTitle;

  /// No description provided for @trainingPlansErrorBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Tranquilo, suele pasar. Inténtalo de nuevo.'**
  String get trainingPlansErrorBody;

  /// No description provided for @trainingPlanFormCreateTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Nuevo plan'**
  String get trainingPlanFormCreateTitle;

  /// No description provided for @trainingPlanFormEditTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Editar plan'**
  String get trainingPlanFormEditTitle;

  /// No description provided for @trainingPlanFormNameLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Nombre del plan'**
  String get trainingPlanFormNameLabel;

  /// No description provided for @trainingPlanFormNameHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Ej: Plan de Juan - Mes 1'**
  String get trainingPlanFormNameHint;

  /// No description provided for @trainingPlanFormNameError.
  ///
  /// In es_VE, this message translates to:
  /// **'El nombre es obligatorio'**
  String get trainingPlanFormNameError;

  /// No description provided for @trainingPlanFormDescriptionLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Descripción (opcional)'**
  String get trainingPlanFormDescriptionLabel;

  /// No description provided for @trainingPlanFormDescriptionHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Objetivo del plan'**
  String get trainingPlanFormDescriptionHint;

  /// No description provided for @trainingPlanFormClientLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Cliente'**
  String get trainingPlanFormClientLabel;

  /// No description provided for @trainingPlanFormClientError.
  ///
  /// In es_VE, this message translates to:
  /// **'Selecciona un cliente'**
  String get trainingPlanFormClientError;

  /// No description provided for @trainingPlanFormSubmit.
  ///
  /// In es_VE, this message translates to:
  /// **'Guardar plan'**
  String get trainingPlanFormSubmit;

  /// No description provided for @trainingPlanFormSubmitting.
  ///
  /// In es_VE, this message translates to:
  /// **'Guardando...'**
  String get trainingPlanFormSubmitting;

  /// No description provided for @trainingPlanCreatedSuccess.
  ///
  /// In es_VE, this message translates to:
  /// **'Plan creado ✅'**
  String get trainingPlanCreatedSuccess;

  /// No description provided for @trainingPlanCreatedSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Plan creado'**
  String get trainingPlanCreatedSemantics;

  /// No description provided for @trainingPlanUpdatedSuccess.
  ///
  /// In es_VE, this message translates to:
  /// **'Plan actualizado ✅'**
  String get trainingPlanUpdatedSuccess;

  /// No description provided for @trainingPlanUpdatedSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Plan actualizado'**
  String get trainingPlanUpdatedSemantics;

  /// No description provided for @trainingPlanWeekLabel.
  ///
  /// In es_VE, this message translates to:
  /// **'Semana {number}'**
  String trainingPlanWeekLabel(Object number);

  /// No description provided for @trainingPlanWeekNameHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Ej: Fuerza, Volumen, Descarga'**
  String get trainingPlanWeekNameHint;

  /// No description provided for @trainingPlanAddWeek.
  ///
  /// In es_VE, this message translates to:
  /// **'Agregar semana'**
  String get trainingPlanAddWeek;

  /// No description provided for @trainingPlanDuplicateWeek.
  ///
  /// In es_VE, this message translates to:
  /// **'Duplicar'**
  String get trainingPlanDuplicateWeek;

  /// No description provided for @trainingPlanDeleteWeek.
  ///
  /// In es_VE, this message translates to:
  /// **'Eliminar'**
  String get trainingPlanDeleteWeek;

  /// No description provided for @trainingPlanWeekLimitTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Límite de semanas'**
  String get trainingPlanWeekLimitTitle;

  /// No description provided for @trainingPlanWeekLimitBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Tu plan actual permite hasta {limit} semanas por plan. Actualiza a Hierro para más 💪'**
  String trainingPlanWeekLimitBody(Object limit);

  /// No description provided for @trainingPlanDuplicateLockedTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Duplicar semanas'**
  String get trainingPlanDuplicateLockedTitle;

  /// No description provided for @trainingPlanDuplicateLockedBody.
  ///
  /// In es_VE, this message translates to:
  /// **'La duplicación de semanas está disponible desde el plan Hierro 💪'**
  String get trainingPlanDuplicateLockedBody;

  /// No description provided for @trainingPlanDayRest.
  ///
  /// In es_VE, this message translates to:
  /// **'Descanso'**
  String get trainingPlanDayRest;

  /// No description provided for @trainingPlanDayEmpty.
  ///
  /// In es_VE, this message translates to:
  /// **'Sin rutina'**
  String get trainingPlanDayEmpty;

  /// No description provided for @trainingPlanDayAssign.
  ///
  /// In es_VE, this message translates to:
  /// **'Asignar rutina'**
  String get trainingPlanDayAssign;

  /// No description provided for @trainingPlanDayNotes.
  ///
  /// In es_VE, this message translates to:
  /// **'Notas del día'**
  String get trainingPlanDayNotes;

  /// No description provided for @trainingPlanDayNotesHint.
  ///
  /// In es_VE, this message translates to:
  /// **'Ej: Subir peso en sentadilla'**
  String get trainingPlanDayNotesHint;

  /// No description provided for @trainingPlanSelectRoutine.
  ///
  /// In es_VE, this message translates to:
  /// **'Elegir rutina'**
  String get trainingPlanSelectRoutine;

  /// No description provided for @trainingPlanCurrentWeek.
  ///
  /// In es_VE, this message translates to:
  /// **'Semana {current} de {total}'**
  String trainingPlanCurrentWeek(Object current, Object total);

  /// No description provided for @trainingPlanAdvanceWeek.
  ///
  /// In es_VE, this message translates to:
  /// **'Avanzar semana'**
  String get trainingPlanAdvanceWeek;

  /// No description provided for @trainingPlanClientViewTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Mi plan'**
  String get trainingPlanClientViewTitle;

  /// No description provided for @trainingPlanClientEmptyTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Sin plan de entrenamiento'**
  String get trainingPlanClientEmptyTitle;

  /// No description provided for @trainingPlanClientEmptyBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Tu entrenador aún no te arma un plan. Cuando lo haga, aparece aquí 💪'**
  String get trainingPlanClientEmptyBody;

  /// No description provided for @trainingPlanClientToday.
  ///
  /// In es_VE, this message translates to:
  /// **'Hoy'**
  String get trainingPlanClientToday;

  /// No description provided for @trainingPlanActiveBadge.
  ///
  /// In es_VE, this message translates to:
  /// **'Activo'**
  String get trainingPlanActiveBadge;

  /// No description provided for @trainingPlanInactiveBadge.
  ///
  /// In es_VE, this message translates to:
  /// **'Inactivo'**
  String get trainingPlanInactiveBadge;

  /// No description provided for @dayMonday.
  ///
  /// In es_VE, this message translates to:
  /// **'Lunes'**
  String get dayMonday;

  /// No description provided for @dayTuesday.
  ///
  /// In es_VE, this message translates to:
  /// **'Martes'**
  String get dayTuesday;

  /// No description provided for @dayWednesday.
  ///
  /// In es_VE, this message translates to:
  /// **'Miércoles'**
  String get dayWednesday;

  /// No description provided for @dayThursday.
  ///
  /// In es_VE, this message translates to:
  /// **'Jueves'**
  String get dayThursday;

  /// No description provided for @dayFriday.
  ///
  /// In es_VE, this message translates to:
  /// **'Viernes'**
  String get dayFriday;

  /// No description provided for @daySaturday.
  ///
  /// In es_VE, this message translates to:
  /// **'Sábado'**
  String get daySaturday;

  /// No description provided for @daySunday.
  ///
  /// In es_VE, this message translates to:
  /// **'Domingo'**
  String get daySunday;

  /// No description provided for @workoutScreenTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Entreno en curso'**
  String get workoutScreenTitle;

  /// No description provided for @workoutStartCta.
  ///
  /// In es_VE, this message translates to:
  /// **'Comenzar'**
  String get workoutStartCta;

  /// No description provided for @workoutStartSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Comenzar entrenamiento'**
  String get workoutStartSemantics;

  /// No description provided for @workoutFinishCta.
  ///
  /// In es_VE, this message translates to:
  /// **'Terminar entreno'**
  String get workoutFinishCta;

  /// No description provided for @workoutFinishConfirmTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'¿Terminar entreno?'**
  String get workoutFinishConfirmTitle;

  /// No description provided for @workoutFinishConfirmBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Vas a guardar tu progreso. Podrás verlo en tu historial 💪'**
  String get workoutFinishConfirmBody;

  /// No description provided for @workoutStartedSuccess.
  ///
  /// In es_VE, this message translates to:
  /// **'¡A darle! Entreno iniciado 🔥'**
  String get workoutStartedSuccess;

  /// No description provided for @workoutStartedSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Entreno iniciado'**
  String get workoutStartedSemantics;

  /// No description provided for @workoutFinishedSuccess.
  ///
  /// In es_VE, this message translates to:
  /// **'¡Entreno completado! Buen trabajo ✅'**
  String get workoutFinishedSuccess;

  /// No description provided for @workoutFinishedSemantics.
  ///
  /// In es_VE, this message translates to:
  /// **'Entreno completado'**
  String get workoutFinishedSemantics;

  /// No description provided for @workoutSetsProgress.
  ///
  /// In es_VE, this message translates to:
  /// **'{done} de {total} series'**
  String workoutSetsProgress(int done, int total);

  /// No description provided for @workoutRestTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Descanso'**
  String get workoutRestTitle;

  /// No description provided for @workoutRestSubtitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Recupera el aliento, que viene la próxima 💪'**
  String get workoutRestSubtitle;

  /// No description provided for @workoutRestSkip.
  ///
  /// In es_VE, this message translates to:
  /// **'Saltar'**
  String get workoutRestSkip;

  /// No description provided for @workoutRestAddMinute.
  ///
  /// In es_VE, this message translates to:
  /// **'+1 min'**
  String get workoutRestAddMinute;

  /// No description provided for @workoutRestDone.
  ///
  /// In es_VE, this message translates to:
  /// **'¡A darle!'**
  String get workoutRestDone;

  /// No description provided for @workoutAlreadyActiveTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Ya tienes un entreno en curso'**
  String get workoutAlreadyActiveTitle;

  /// No description provided for @workoutAlreadyActiveBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Te llevamos a donde lo dejaste 💪'**
  String get workoutAlreadyActiveBody;

  /// No description provided for @workoutErrorTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'No pudimos cargar tu entreno'**
  String get workoutErrorTitle;

  /// No description provided for @workoutEmptyTitle.
  ///
  /// In es_VE, this message translates to:
  /// **'Este entreno no tiene series'**
  String get workoutEmptyTitle;

  /// No description provided for @workoutEmptyBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Pídele a tu coach que le agregue ejercicios 💪'**
  String get workoutEmptyBody;

  /// No description provided for @workoutErrorBody.
  ///
  /// In es_VE, this message translates to:
  /// **'Tranquilo, suele pasar. Inténtalo de nuevo.'**
  String get workoutErrorBody;

  /// No description provided for @workoutSetWeight.
  ///
  /// In es_VE, this message translates to:
  /// **'{kg} kg'**
  String workoutSetWeight(String kg);

  /// No description provided for @workoutSetReps.
  ///
  /// In es_VE, this message translates to:
  /// **'{reps} reps'**
  String workoutSetReps(int reps);

  /// No description provided for @workoutDurationMinutes.
  ///
  /// In es_VE, this message translates to:
  /// **'{minutes} min'**
  String workoutDurationMinutes(int minutes);
}

class _AppStringsDelegate extends LocalizationsDelegate<AppStrings> {
  const _AppStringsDelegate();

  @override
  Future<AppStrings> load(Locale locale) {
    return SynchronousFuture<AppStrings>(lookupAppStrings(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppStringsDelegate old) => false;
}

AppStrings lookupAppStrings(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'es':
      {
        switch (locale.countryCode) {
          case 'VE':
            return AppStringsEsVe();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es':
      return AppStringsEs();
  }

  throw FlutterError(
    'AppStrings.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
