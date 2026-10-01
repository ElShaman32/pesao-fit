// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OwnerStaffController)
final ownerStaffControllerProvider = OwnerStaffControllerProvider._();

final class OwnerStaffControllerProvider
    extends $NotifierProvider<OwnerStaffController, Result<StaffOverview>> {
  OwnerStaffControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ownerStaffControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ownerStaffControllerHash();

  @$internal
  @override
  OwnerStaffController create() => OwnerStaffController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Result<StaffOverview> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Result<StaffOverview>>(value),
    );
  }
}

String _$ownerStaffControllerHash() =>
    r'5ff2506a91d5a2122ccbf6b85565f9f590fcaf9b';

abstract class _$OwnerStaffController extends $Notifier<Result<StaffOverview>> {
  Result<StaffOverview> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Result<StaffOverview>, Result<StaffOverview>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Result<StaffOverview>, Result<StaffOverview>>,
              Result<StaffOverview>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
