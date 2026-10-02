// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_plans_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(membershipPlansRepository)
final membershipPlansRepositoryProvider = MembershipPlansRepositoryProvider._();

final class MembershipPlansRepositoryProvider
    extends
        $FunctionalProvider<
          MembershipPlansRepository,
          MembershipPlansRepository,
          MembershipPlansRepository
        >
    with $Provider<MembershipPlansRepository> {
  MembershipPlansRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'membershipPlansRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$membershipPlansRepositoryHash();

  @$internal
  @override
  $ProviderElement<MembershipPlansRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MembershipPlansRepository create(Ref ref) {
    return membershipPlansRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MembershipPlansRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MembershipPlansRepository>(value),
    );
  }
}

String _$membershipPlansRepositoryHash() =>
    r'1971cd8b70ca0618255ceb47f854d4ad5379218f';

@ProviderFor(MembershipPlansController)
final membershipPlansControllerProvider = MembershipPlansControllerProvider._();

final class MembershipPlansControllerProvider
    extends
        $NotifierProvider<
          MembershipPlansController,
          AsyncValue<List<GymMembershipPlan>>
        > {
  MembershipPlansControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'membershipPlansControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$membershipPlansControllerHash();

  @$internal
  @override
  MembershipPlansController create() => MembershipPlansController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<GymMembershipPlan>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<GymMembershipPlan>>>(
        value,
      ),
    );
  }
}

String _$membershipPlansControllerHash() =>
    r'b6206fb422628ab24bf037db4ff0105deb618a51';

abstract class _$MembershipPlansController
    extends $Notifier<AsyncValue<List<GymMembershipPlan>>> {
  AsyncValue<List<GymMembershipPlan>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<GymMembershipPlan>>,
              AsyncValue<List<GymMembershipPlan>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<GymMembershipPlan>>,
                AsyncValue<List<GymMembershipPlan>>
              >,
              AsyncValue<List<GymMembershipPlan>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
