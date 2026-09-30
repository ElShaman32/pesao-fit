import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Scaffold base oficial de PESAO FIT.
///
/// Une:
/// - AppBar slot.
/// - Banner slot (por ejemplo OfflineBanner).
/// - Body.
/// - Bottom nav.
/// - FAB contextual.
class PesaoShell extends StatelessWidget {
  const PesaoShell({
    super.key,
    required this.body,
    this.appBar,
    this.banner,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? banner;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    Widget content = body;

    if (banner != null) {
      content = Column(
        children: [
          banner!,
          Expanded(child: body),
        ],
      );
    }

    if (appBar == null) {
      content = SafeArea(
        top: true,
        bottom: false,
        child: content,
      );
    }

    final fabLocation = floatingActionButtonLocation ??
        (bottomNavigationBar != null
            ? FloatingActionButtonLocation.centerDocked
            : FloatingActionButtonLocation.endFloat);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: appBar,
      body: content,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: fabLocation,
    );
  }
}
