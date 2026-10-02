// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_subscription_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(clientSubscriptionRepository)
final clientSubscriptionRepositoryProvider =
    ClientSubscriptionRepositoryProvider._();

final class ClientSubscriptionRepositoryProvider
    extends
        $FunctionalProvider<
          ClientSubscriptionRepository,
          ClientSubscriptionRepository,
          ClientSubscriptionRepository
        >
    with $Provider<ClientSubscriptionRepository> {
  ClientSubscriptionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientSubscriptionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientSubscriptionRepositoryHash();

  @$internal
  @override
  $ProviderElement<ClientSubscriptionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ClientSubscriptionRepository create(Ref ref) {
    return clientSubscriptionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClientSubscriptionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClientSubscriptionRepository>(value),
    );
  }
}

String _$clientSubscriptionRepositoryHash() =>
    r'9e0c93c8bc32306f0bc8dab1403d2ea875c0e650';

/// Suscripción activa del cliente actual (para el dashboard del cliente).

@ProviderFor(ClientSubscriptionController)
final clientSubscriptionControllerProvider =
    ClientSubscriptionControllerProvider._();

/// Suscripción activa del cliente actual (para el dashboard del cliente).
final class ClientSubscriptionControllerProvider
    extends
        $NotifierProvider<
          ClientSubscriptionController,
          AsyncValue<ClientSubscription?>
        > {
  /// Suscripción activa del cliente actual (para el dashboard del cliente).
  ClientSubscriptionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientSubscriptionControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientSubscriptionControllerHash();

  @$internal
  @override
  ClientSubscriptionController create() => ClientSubscriptionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<ClientSubscription?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<ClientSubscription?>>(
        value,
      ),
    );
  }
}

String _$clientSubscriptionControllerHash() =>
    r'5c5a9248ee06d86754d503482c5441806cf5bc07';

/// Suscripción activa del cliente actual (para el dashboard del cliente).

abstract class _$ClientSubscriptionController
    extends $Notifier<AsyncValue<ClientSubscription?>> {
  AsyncValue<ClientSubscription?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<ClientSubscription?>,
              AsyncValue<ClientSubscription?>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ClientSubscription?>,
                AsyncValue<ClientSubscription?>
              >,
              AsyncValue<ClientSubscription?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
