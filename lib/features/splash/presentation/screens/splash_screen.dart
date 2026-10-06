import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Pantalla de splash de PESAO FIT.
///
/// Reproduce el audio del disco cayendo completo, anima el logo
/// con scale + fade (Curves.easeOutBack) y muestra el footer SiReBaI.
/// Navega automáticamente cuando el audio termina y auth está listo.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  // Animación del logo.
  late final AnimationController _animController;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _footerAnim;

  // Estado del audio.
  bool _audioDone = false;
  bool _hasNavigated = false;
  AudioPlayer? _audioPlayer;

  @override
  void initState() {
    super.initState();

    // Configuración de animación del logo.
    _animController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Scale con rebote sutil (easeOutBack).
    _scaleAnim = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
    );

    // Fade-in del logo (primeros 60% de la animación).
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    );

    // Fade-in del footer SiReBaI (últimos 60% de la animación).
    _footerAnim = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
    );

    _animController.forward();

    // Reproducir audio.
    _playSplashAudio();
  }

  @override
  void dispose() {
    _animController.dispose();
    _audioPlayer?.dispose();
    super.dispose();
  }

  /// Reproduce el audio del splash completo.
  /// Si el archivo no existe o falla, espera 2.5s y continúa.
  Future<void> _playSplashAudio() async {
    try {
      _audioPlayer = AudioPlayer();
      await _audioPlayer!.play(AssetSource('audio/splash.mp3'));
      // Esperar a que termine el audio completo.
      await _audioPlayer!.onPlayerComplete.first;
    } catch (_) {
      // Si el audio falla, esperar un mínimo para que el logo se vea.
      await Future.delayed(const Duration(milliseconds: 2500));
    }

    if (mounted) {
      setState(() => _audioDone = true);
      _tryNavigate();
    }
  }

  /// Intenta navegar cuando el audio terminó y auth está listo.
  void _tryNavigate() {
    if (!_audioDone || _hasNavigated) return;

    // Esperar a que auth termine de inicializar.
    if (authProvider.isInitializing) {
      Future.delayed(const Duration(milliseconds: 100), _tryNavigate);
      return;
    }

    _hasNavigated = true;

    // Determinar siguiente ruta según estado de auth.
    if (!authProvider.isLoggedIn) {
      context.go(RouteNames.onboarding);
    } else if (authProvider.needsOnboarding) {
      context.go(RouteNames.onboarding);
    } else {
      context.go(_homeForRole(authProvider.userRole));
    }
  }

  /// Devuelve la ruta de inicio según el rol del usuario.
  String _homeForRole(UserRole? role) {
    switch (role) {
      case UserRole.client:
        return RouteNames.clientHome;
      case UserRole.trainer:
        return RouteNames.trainerHome;
      case UserRole.owner:
        return RouteNames.ownerHome;
      case UserRole.nutritionist:
        return RouteNames.nutritionistHome;
      case UserRole.admin:
        return RouteNames.adminHome;
      case null:
        return RouteNames.onboarding;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Logo animado (centro).
            Center(
              child: AnimatedBuilder(
                animation: _animController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnim.value,
                    child: Transform.scale(
                      scale: _scaleAnim.value,
                      child: child,
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo PESAO FIT.
                    Image.asset(
                      'assets/images/logo.png',
                      width: 160,
                      height: 160,
                      semanticLabel: l10n.splashBrandSemantics,
                    ),
                    const SizedBox(height: 16),
                    // Nombre de la marca.
                    Text(
                      'PESAO FIT',
                      style: AppTypography.display.copyWith(
                        color: AppColors.primary,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Footer SiReBaI (abajo).
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _animController,
                builder: (context, child) {
                  return Opacity(opacity: _footerAnim.value, child: child);
                },
                child: Text(
                  'SiReBaI',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textDisabled,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
