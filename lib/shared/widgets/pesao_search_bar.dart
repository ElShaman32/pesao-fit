import 'package:flutter/material.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_typography.dart';

/// Barra de búsqueda oficial de PESAO FIT.
///
/// Reglas (design-system.md §7):
/// - h52, r12, fondo surfaceHigh.
/// - Ícono de búsqueda como prefijo.
/// - Botón de limpiar con touch target 48x48 cuando hay texto.
class PesaoSearchBar extends StatefulWidget {
  const PesaoSearchBar({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.autofocus = false,
    this.enabled = true,
  });

  /// Si no se provee, el widget crea y gestiona uno interno.
  final TextEditingController? controller;

  /// Si es null se usa AppStrings.commonSearch.
  final String? hintText;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool autofocus;
  final bool enabled;

  @override
  State<PesaoSearchBar> createState() => _PesaoSearchBarState();
}

class _PesaoSearchBarState extends State<PesaoSearchBar> {
  late final TextEditingController _controller;
  bool _ownsController = false;

  @override
  void initState() {
    super.initState();
    final external = widget.controller;
    if (external != null) {
      _controller = external;
    } else {
      _controller = TextEditingController();
      _ownsController = true;
    }
    _controller.addListener(_handleTextChanged);
  }

  void _handleTextChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChanged);
    if (_ownsController) _controller.dispose();
    super.dispose();
  }

  void _clearText() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  InputBorder _border(Color color, [double width = 1]) {
    return OutlineInputBorder(
      borderRadius: AppDimens.inputBorderRadius,
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final hint = widget.hintText ?? strings.commonSearch;
    final hasText = _controller.text.isNotEmpty;

    return SizedBox(
      height: AppDimens.inputHeight,
      child: TextField(
        controller: _controller,
        enabled: widget.enabled,
        autofocus: widget.autofocus,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        textInputAction: TextInputAction.search,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: AppColors.primary,
        style: AppTypography.body.copyWith(
          color: widget.enabled
              ? AppColors.textPrimary
              : AppColors.textDisabled,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.enabled
              ? AppColors.surfaceHigh
              : AppColors.surface,
          hintText: hint,
          hintStyle: AppTypography.bodySmall.copyWith(
            color: AppColors.textDisabled,
          ),
          prefixIcon: const Icon(
            AppIcons.search,
            size: 20,
            color: AppColors.textSecondary,
          ),
          suffixIcon: hasText
              ? SizedBox(
                  width: AppDimens.touchTarget,
                  height: AppDimens.touchTarget,
                  child: Semantics(
                    button: true,
                    label: strings.commonClose,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _clearText,
                      child: const Center(
                        child: Icon(
                          AppIcons.close,
                          size: 18,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                )
              : null,
          prefixIconColor: AppColors.textSecondary,
          suffixIconColor: AppColors.textSecondary,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppDimens.l,
          ),
          isDense: true,
          border: _border(AppColors.outline),
          enabledBorder: _border(AppColors.outline),
          focusedBorder: _border(AppColors.primary, 1.5),
        ),
      ),
    );
  }
}
