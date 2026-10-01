// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_payments_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(clientPaymentsRepository)
final clientPaymentsRepositoryProvider = ClientPaymentsRepositoryProvider._();

final class ClientPaymentsRepositoryProvider
    extends
        $FunctionalProvider<
          ClientPaymentsRepository,
          ClientPaymentsRepository,
          ClientPaymentsRepository
        >
    with $Provider<ClientPaymentsRepository> {
  ClientPaymentsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientPaymentsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientPaymentsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ClientPaymentsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ClientPaymentsRepository create(Ref ref) {
    return clientPaymentsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClientPaymentsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClientPaymentsRepository>(value),
    );
  }
}

String _$clientPaymentsRepositoryHash() =>
    r'700ca37a97c272ff6fbb52f8702eb06aca3f6f62';

@ProviderFor(ClientPaymentUploadController)
final clientPaymentUploadControllerProvider =
    ClientPaymentUploadControllerProvider._();

final class ClientPaymentUploadControllerProvider
    extends
        $NotifierProvider<
          ClientPaymentUploadController,
          ClientPaymentUploadState
        > {
  ClientPaymentUploadControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientPaymentUploadControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientPaymentUploadControllerHash();

  @$internal
  @override
  ClientPaymentUploadController create() => ClientPaymentUploadController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClientPaymentUploadState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClientPaymentUploadState>(value),
    );
  }
}

String _$clientPaymentUploadControllerHash() =>
    r'3d605a5b6ef50bf92146e0ba376d5b6e152f46a7';

abstract class _$ClientPaymentUploadController
    extends $Notifier<ClientPaymentUploadState> {
  ClientPaymentUploadState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<ClientPaymentUploadState, ClientPaymentUploadState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ClientPaymentUploadState, ClientPaymentUploadState>,
              ClientPaymentUploadState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
