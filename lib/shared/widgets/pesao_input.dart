import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_typography.dart';

/// Campo de texto oficial de PESAO FIT.
///
/// Reglas visuales:
/// - Altura 52.
/// - Radio 12.
/// - Fondo surfaceHigh.
/// - Error suave venezolano, nunca agresivo.
/// - Label, helper y error deben venir desde AppStrings.
class PesaoInput extends StatelessWidget {
  const PesaoInput({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helper,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.autocorrect = true,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helper;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final bool autocorrect;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;

  InputBorder _border(Color color, [double width = 1]) {
    return OutlineInputBorder(
      borderRadius: AppDimens.inputBorderRadius,
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null && errorText!.trim().isNotEmpty;

    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: enabled ? AppColors.surfaceHigh : AppColors.surface,
      hintText: hint,
      hintStyle: AppTypography.bodySmall.copyWith(
        color: AppColors.textDisabled,
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      prefixIconColor: AppColors.textSecondary,
      suffixIconColor: AppColors.textSecondary,
      contentPadding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
      isDense: true,
      border: _border(hasError ? AppColors.error : AppColors.outline),
      enabledBorder: _border(hasError ? AppColors.error : AppColors.outline),
      focusedBorder: _border(
        hasError ? AppColors.error : AppColors.primary,
        1.5,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppTypography.label.copyWith(
              color: hasError ? AppColors.errorText : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimens.xs),
        ],
        SizedBox(
          height: AppDimens.inputHeight,
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            enabled: enabled,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            autocorrect: autocorrect,
            textCapitalization: textCapitalization,
            textAlignVertical: TextAlignVertical.center,
            cursorColor: AppColors.primary,
            inputFormatters: inputFormatters,
            style: AppTypography.body.copyWith(
              color: enabled ? AppColors.textPrimary : AppColors.textDisabled,
            ),
            decoration: inputDecoration,
          ),
        ),
        if (hasError || helper != null) ...[
          const SizedBox(height: AppDimens.xs),
          if (hasError)
            Row(
              children: [
                const Icon(
                  AppIcons.error,
                  size: 16,
                  color: AppColors.errorText,
                ),
                const SizedBox(width: AppDimens.xs),
                Expanded(
                  child: Text(
                    errorText!,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.errorText,
                    ),
                  ),
                ),
              ],
            )
          else
            Text(
              helper!,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
        ],
      ],
    );
  }
}
