// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_dashboard_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador del dashboard del superadmin.
/// keepAlive para que conserve estado al cambiar entre tabs del shell.

@ProviderFor(AdminDashboardController)
final adminDashboardControllerProvider = AdminDashboardControllerProvider._();

/// Controlador del dashboard del superadmin.
/// keepAlive para que conserve estado al cambiar entre tabs del shell.
final class AdminDashboardControllerProvider
    extends $NotifierProvider<AdminDashboardController, AdminDashboardState> {
  /// Controlador del dashboard del superadmin.
  /// keepAlive para que conserve estado al cambiar entre tabs del shell.
  AdminDashboardControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminDashboardControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminDashboardControllerHash();

  @$internal
  @override
  AdminDashboardController create() => AdminDashboardController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminDashboardState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminDashboardState>(value),
    );
  }
}

String _$adminDashboardControllerHash() =>
    r'282adbd526a293c659a823d20a16ddbe69fe3386';

/// Controlador del dashboard del superadmin.
/// keepAlive para que conserve estado al cambiar entre tabs del shell.

abstract class _$AdminDashboardController
    extends $Notifier<AdminDashboardState> {
  AdminDashboardState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AdminDashboardState, AdminDashboardState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AdminDashboardState, AdminDashboardState>,
              AdminDashboardState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
