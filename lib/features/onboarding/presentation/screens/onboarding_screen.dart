import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../providers/onboarding_state_provider.dart';
import '../widgets/legal_summary_sheet.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/terms_checkbox.dart';

/// Pantalla de onboarding de PESAO FIT.
///
/// Muestra 4 slides vendiendo el producto. El slide 1 incluye
/// checkbox de aceptación de términos y privacidad.
/// Solo aparece en el primer uso de la app.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;
  bool _termsAccepted = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeOnboarding() async {
    if (!_termsAccepted) return;

    // Marcar términos como aceptados.
    await ref.read(onboardingStateProvider.notifier).acceptTerms();
    // Marcar onboarding como completado.
    await ref.read(onboardingStateProvider.notifier).completeOnboarding();

    if (!mounted) return;

    // Navegar al selector de rol.
    context.go(RouteNames.roleSelector);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // PageView con los 4 slides.
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                children: [
                  // Slide 1: Bienvenida + términos.
                  OnboardingPage(
                    icon: Icons.fitness_center,
                    title: l10n.onboardingSlide1Title,
                    subtitle: l10n.onboardingSlide1Subtitle,
                    trailing: Column(
                      children: [
                        const SizedBox(height: 32),
                        TermsCheckbox(
                          value: _termsAccepted,
                          onChanged: (value) {
                            setState(() => _termsAccepted = value ?? false);
                          },
                          onTapTerms: () =>
                              LegalSummarySheet.showTerms(context),
                          onTapPrivacy: () =>
                              LegalSummarySheet.showPrivacy(context),
                        ),
                      ],
                    ),
                  ),

                  // Slide 2: Rutinas inteligentes.
                  OnboardingPage(
                    icon: Icons.auto_awesome,
                    title: l10n.onboardingSlide2Title,
                    subtitle: l10n.onboardingSlide2Subtitle,
                  ),

                  // Slide 3: Planes nutricionales.
                  OnboardingPage(
                    icon: Icons.restaurant_menu,
                    title: l10n.onboardingSlide3Title,
                    subtitle: l10n.onboardingSlide3Subtitle,
                  ),

                  // Slide 4: Comunidad.
                  OnboardingPage(
                    icon: Icons.groups,
                    title: l10n.onboardingSlide4Title,
                    subtitle: l10n.onboardingSlide4Subtitle,
                  ),
                ],
              ),
            ),

            // Indicador de página + botón.
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Indicador de página.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (index) => Container(
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primary
                              : AppColors.textDisabled,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Botón de acción.
                  if (_currentPage < 3)
                    PesaoButton(
                      label: l10n.onboardingSwipeHint,
                      onPressed: _nextPage,
                      variant: PesaoButtonVariant.secondary,
                    )
                  else
                    PesaoButton(
                      label: l10n.onboardingStart,
                      onPressed: _termsAccepted ? _completeOnboarding : null,
                      variant: PesaoButtonVariant.primary,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
