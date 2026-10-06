import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_state_provider.g.dart';

/// Datos de estado del onboarding.
class OnboardingData {
  final bool isFirstLaunch;
  final bool hasAcceptedTerms;

  const OnboardingData({
    required this.isFirstLaunch,
    required this.hasAcceptedTerms,
  });

  OnboardingData copyWith({bool? isFirstLaunch, bool? hasAcceptedTerms}) {
    return OnboardingData(
      isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
      hasAcceptedTerms: hasAcceptedTerms ?? this.hasAcceptedTerms,
    );
  }
}

/// Provider que persiste el estado del onboarding en SharedPreferences.
///
/// - `isFirstLaunch`: true solo la primera vez que se abre la app.
/// - `hasAcceptedTerms`: true cuando el usuario aceptó T&C y privacidad.
@Riverpod(keepAlive: true)
class OnboardingState extends _$OnboardingState {
  static const _keyFirstLaunch = 'pesao_first_launch';
  static const _keyTermsAccepted = 'pesao_terms_accepted';

  @override
  Future<OnboardingData> build() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool(_keyFirstLaunch) ?? true;
    final hasAcceptedTerms = prefs.getBool(_keyTermsAccepted) ?? false;
    return OnboardingData(
      isFirstLaunch: isFirstLaunch,
      hasAcceptedTerms: hasAcceptedTerms,
    );
  }

  /// Marca el onboarding como completado (ya no es primera vez).
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyFirstLaunch, false);
    state = AsyncValue.data(
      state.value?.copyWith(isFirstLaunch: false) ??
          const OnboardingData(isFirstLaunch: false, hasAcceptedTerms: false),
    );
  }

  /// Marca los términos como aceptados.
  Future<void> acceptTerms() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyTermsAccepted, true);
    state = AsyncValue.data(
      state.value?.copyWith(hasAcceptedTerms: true) ??
          const OnboardingData(isFirstLaunch: true, hasAcceptedTerms: true),
    );
  }
}
