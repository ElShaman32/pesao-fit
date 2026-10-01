// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Proveedor del repositorio de pagos.

@ProviderFor(paymentsRepository)
final paymentsRepositoryProvider = PaymentsRepositoryProvider._();

/// Proveedor del repositorio de pagos.

final class PaymentsRepositoryProvider
    extends
        $FunctionalProvider<
          PaymentsRepository,
          PaymentsRepository,
          PaymentsRepository
        >
    with $Provider<PaymentsRepository> {
  /// Proveedor del repositorio de pagos.
  PaymentsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paymentsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paymentsRepositoryHash();

  @$internal
  @override
  $ProviderElement<PaymentsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PaymentsRepository create(Ref ref) {
    return paymentsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaymentsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaymentsRepository>(value),
    );
  }
}

String _$paymentsRepositoryHash() =>
    r'445a3af7e9872b240d90f2366baedd8180734ea6';

/// Controlador de pagos del dueño.

@ProviderFor(OwnerPaymentsController)
final ownerPaymentsControllerProvider = OwnerPaymentsControllerProvider._();

/// Controlador de pagos del dueño.
final class OwnerPaymentsControllerProvider
    extends $NotifierProvider<OwnerPaymentsController, PaymentsState> {
  /// Controlador de pagos del dueño.
  OwnerPaymentsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ownerPaymentsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ownerPaymentsControllerHash();

  @$internal
  @override
  OwnerPaymentsController create() => OwnerPaymentsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaymentsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaymentsState>(value),
    );
  }
}

String _$ownerPaymentsControllerHash() =>
    r'5176894ff27e37c0f2cb3af65e58bdbf3d0b16e1';

/// Controlador de pagos del dueño.

abstract class _$OwnerPaymentsController extends $Notifier<PaymentsState> {
  PaymentsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PaymentsState, PaymentsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PaymentsState, PaymentsState>,
              PaymentsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
