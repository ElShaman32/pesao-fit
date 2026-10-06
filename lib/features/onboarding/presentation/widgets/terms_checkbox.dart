import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Checkbox de aceptación de términos y privacidad.
///
/// Muestra el texto con enlaces clickeables que abren el LegalSummarySheet.
class TermsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onTapTerms;
  final VoidCallback onTapPrivacy;

  const TermsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.onTapTerms,
    required this.onTapPrivacy,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Checkbox.
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
          checkColor: AppColors.onPrimary,
        ),

        // Texto con enlaces.
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: RichText(
              text: TextSpan(
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
                children: [
                  TextSpan(
                    text: l10n.onboardingTermsCheckbox
                        .split(l10n.onboardingTermsButton)
                        .first,
                  ),
                  TextSpan(
                    text: l10n.onboardingTermsButton,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = onTapTerms,
                  ),
                  const TextSpan(text: ' y la '),
                  TextSpan(
                    text: l10n.onboardingPrivacyButton,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = onTapPrivacy,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
