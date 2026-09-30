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
