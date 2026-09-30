import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/l10n/app_strings.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

/// Entry point de PESAO FIT.
///
/// Inicializa:
/// 1. Supabase (placeholder, se activa en FASE 1)
/// 2. Riverpod (gestión de estado global)
/// 3. AuthProvider (placeholder, se reemplaza con Supabase auth)
/// 4. Tema "Dark Athletic Luxe" + textos es_VE
/// 5. GoRouter con redirect por rol
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cargar variables de entorno desde .env
  await dotenv.load(fileName: '.env');

  // Inicializar Supabase con credenciales del .env
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    publishableKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // TODO: Inicializar Sentry en FASE 1
  // await SentryFlutter.init(
  //   (options) => options.dsn = 'TU_SENTRY_DSN',
  //   appRunner: () => runApp(const ProviderScope(child: PesaoFitApp())),
  // );

  runApp(const ProviderScope(child: PesaoFitApp()));
}

/// Widget raíz que configura tema, localización y autenticación.
class PesaoFitApp extends StatelessWidget {
  const PesaoFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    // El authProvider ahora se inicializa solo desde Supabase Auth.
    // Ya no necesita login simulado: la sesión real se restaura
    // automáticamente si hay token persistido.

    return MaterialApp.router(
      title: 'PESAO FIT',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(oled: false),
      darkTheme: AppTheme.build(oled: false),
      themeMode: ThemeMode.dark,
      localizationsDelegates: const [
        AppStrings.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es', 'VE')],
      routerConfig: appRouter,
    );
  }
}
