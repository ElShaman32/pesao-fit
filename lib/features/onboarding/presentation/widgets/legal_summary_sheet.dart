import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_button.dart';

/// BottomSheet que muestra resumen de T&C, Privacidad o Descargo.
///
/// Incluye bullets resumen + CTA para leer cláusulas completas en la web.
class LegalSummarySheet extends StatelessWidget {
  final String title;
  final String summary;
  final String webUrl;

  const LegalSummarySheet({
    super.key,
    required this.title,
    required this.summary,
    required this.webUrl,
  });

  /// Muestra el sheet de Términos y Condiciones.
  static Future<void> showTerms(BuildContext context) {
    final l10n = AppStrings.of(context);
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => LegalSummarySheet(
        title: l10n.legalTermsTitle,
        summary: l10n.legalTermsSummary,
        webUrl: 'https://pesao.camburpinton.com.ve/#terminos',
      ),
    );
  }

  /// Muestra el sheet de Política de Privacidad.
  static Future<void> showPrivacy(BuildContext context) {
    final l10n = AppStrings.of(context);
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => LegalSummarySheet(
        title: l10n.legalPrivacyTitle,
        summary: l10n.legalPrivacySummary,
        webUrl: 'https://pesao.camburpinton.com.ve/#privacidad',
      ),
    );
  }

  /// Muestra el sheet de Descargo de Responsabilidad.
  static Future<void> showDisclaimer(BuildContext context) {
    final l10n = AppStrings.of(context);
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => LegalSummarySheet(
        title: l10n.legalDisclaimerTitle,
        summary: l10n.legalDisclaimerSummary,
        webUrl: 'https://pesao.camburpinton.com.ve/legal#descargo',
      ),
    );
  }

  Future<void> _launchUrl() async {
    final uri = Uri.parse(webUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle decorativo.
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textDisabled,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Título.
          Text(
            title,
            style: AppTypography.title.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 16),

          // Resumen con bullets.
          Text(
            summary,
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),

          // CTA para leer cláusulas completas.
          PesaoButton(
            label: l10n.legalReadFull,
            onPressed: _launchUrl,
            variant: PesaoButtonVariant.secondary,
          ),
          const SizedBox(height: 12),

          // Botón cerrar.
          PesaoButton(
            label: l10n.legalClose,
            onPressed: () => Navigator.pop(context),
            variant: PesaoButtonVariant.ghost,
          ),
        ],
      ),
    );
  }
}
