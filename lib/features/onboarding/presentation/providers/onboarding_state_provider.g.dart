// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider que persiste el estado del onboarding en SharedPreferences.
///
/// - `isFirstLaunch`: true solo la primera vez que se abre la app.
/// - `hasAcceptedTerms`: true cuando el usuario aceptó T&C y privacidad.

@ProviderFor(OnboardingState)
final onboardingStateProvider = OnboardingStateProvider._();

/// Provider que persiste el estado del onboarding en SharedPreferences.
///
/// - `isFirstLaunch`: true solo la primera vez que se abre la app.
/// - `hasAcceptedTerms`: true cuando el usuario aceptó T&C y privacidad.
final class OnboardingStateProvider
    extends $AsyncNotifierProvider<OnboardingState, OnboardingData> {
  /// Provider que persiste el estado del onboarding en SharedPreferences.
  ///
  /// - `isFirstLaunch`: true solo la primera vez que se abre la app.
  /// - `hasAcceptedTerms`: true cuando el usuario aceptó T&C y privacidad.
  OnboardingStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingStateHash();

  @$internal
  @override
  OnboardingState create() => OnboardingState();
}

String _$onboardingStateHash() => r'ffb038e6f180c7c7fc93b2f42cc54d3a02203211';

/// Provider que persiste el estado del onboarding en SharedPreferences.
///
/// - `isFirstLaunch`: true solo la primera vez que se abre la app.
/// - `hasAcceptedTerms`: true cuando el usuario aceptó T&C y privacidad.

abstract class _$OnboardingState extends $AsyncNotifier<OnboardingData> {
  FutureOr<OnboardingData> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<OnboardingData>, OnboardingData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<OnboardingData>, OnboardingData>,
              AsyncValue<OnboardingData>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
