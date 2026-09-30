import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_typography.dart';

/// Avatar oficial de PESAO FIT.
///
/// Importante:
/// - El widget NO construye URLs de Cloudinary.
/// - Recibe la URL final ya transformada desde datasource/utils.
class PesaoAvatar extends StatelessWidget {
  const PesaoAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = 40,
    this.ringColor,
    this.semanticLabel,
  });

  final String? imageUrl;
  final String? name;
  final double size;
  final Color? ringColor;
  final String? semanticLabel;

  String? get _initials {
    final rawName = name?.trim() ?? '';
    if (rawName.isEmpty) {
      return null;
    }

    final parts = rawName.split(RegExp(r'\s+'));
    final first = parts.first.isNotEmpty ? parts.first[0] : '';
    final second = parts.length > 1 && parts.last.isNotEmpty
        ? parts.last[0]
        : '';

    final initials = '$first$second'.toUpperCase();
    return initials.isEmpty ? null : initials;
  }

  Widget _placeholder() {
    final initials = _initials;

    return Container(
      width: size,
      height: size,
      color: AppColors.surfaceHigh,
      alignment: Alignment.center,
      child: initials != null
          ? Text(
              initials,
              style: AppTypography.label.copyWith(
                color: AppColors.textSecondary,
              ),
            )
          : Icon(
              AppIcons.profile,
              size: size * 0.5,
              color: AppColors.textSecondary,
            ),
    );
  }

  Widget _content() {
    final url = imageUrl?.trim() ?? '';

    if (url.isEmpty) {
      return _placeholder();
    }

    return CachedNetworkImage(
      imageUrl: url,
      width: size,
      height: size,
      fit: BoxFit.cover,
      placeholder: (context, url) => _placeholder(),
      errorWidget: (context, url, error) => _placeholder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final label = semanticLabel ?? name;

    Widget avatar = ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: _content(),
      ),
    );

    if (ringColor != null) {
      avatar = Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: ringColor!,
            width: 2,
          ),
        ),
        child: avatar,
      );
    }

    return Semantics(
      label: label,
      image: label != null,
      child: avatar,
    );
  }
}
