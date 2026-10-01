import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_typography.dart';
import 'pesao_button.dart';

/// Campo para elegir una imagen (cámara o galería).
///
/// Muestra un placeholder cuando no hay imagen y un preview cuando sí.
/// El estado de los bytes se mantiene en el padre.
class ImagePickerField extends StatelessWidget {
  final Uint8List? imageBytes;
  final String pickLabel;
  final String replaceLabel;
  final String? error;
  final ValueChanged<Uint8List> onImagePicked;
  final VoidCallback? onImageCleared;

  const ImagePickerField({
    super.key,
    required this.imageBytes,
    required this.pickLabel,
    required this.replaceLabel,
    required this.onImagePicked,
    this.error,
    this.onImageCleared,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imageBytes != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => _pickImage(context),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.surfaceHigh,
              borderRadius: AppDimens.cardBorderRadius,
              border: Border.all(
                color: error != null
                    ? AppColors.error
                    : (hasImage ? AppColors.primary : AppColors.outline),
                width: hasImage ? 2 : 1,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: hasImage
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.memory(imageBytes!, fit: BoxFit.cover),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: _EditBadge(label: replaceLabel),
                      ),
                    ],
                  )
                : _Placeholder(label: pickLabel),
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: AppDimens.xs),
            child: Text(
              error!,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.errorText,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.l),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PesaoButton(
                  label: 'Tomar foto',
                  variant: PesaoButtonVariant.primary,
                  icon: Icons.camera_alt_rounded,
                  onPressed: () =>
                      Navigator.pop(sheetContext, ImageSource.camera),
                ),
                const SizedBox(height: AppDimens.s),
                PesaoButton(
                  label: 'Elegir de galería',
                  variant: PesaoButtonVariant.secondary,
                  icon: Icons.photo_library_rounded,
                  onPressed: () =>
                      Navigator.pop(sheetContext, ImageSource.gallery),
                ),
                const SizedBox(height: AppDimens.s),
                PesaoButton(
                  label: 'Cancelar',
                  variant: PesaoButtonVariant.ghost,
                  onPressed: () => Navigator.pop(sheetContext),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (source == null) return;

    final picked = await picker.pickImage(
      source: source,
      maxWidth: 1600,
      maxHeight: 1600,
      imageQuality: 85,
    );

    if (picked == null) return;

    final bytes = await picked.readAsBytes();
    onImagePicked(bytes);
  }
}

class _Placeholder extends StatelessWidget {
  final String label;
  const _Placeholder({required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.add_photo_alternate_rounded,
          size: 48,
          color: AppColors.textSecondary,
        ),
        const SizedBox(height: AppDimens.s),
        Text(
          label,
          style: AppTypography.body.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _EditBadge extends StatelessWidget {
  final String label;
  const _EditBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.m,
        vertical: AppDimens.xs,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: AppDimens.pillBorderRadius,
      ),
      child: Text(
        label,
        style: AppTypography.label.copyWith(color: AppColors.onPrimary),
      ),
    );
  }
}
