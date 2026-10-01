// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clients_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Proveedor del repositorio de clientes.

@ProviderFor(clientsRepository)
final clientsRepositoryProvider = ClientsRepositoryProvider._();

/// Proveedor del repositorio de clientes.

final class ClientsRepositoryProvider
    extends
        $FunctionalProvider<
          ClientsRepository,
          ClientsRepository,
          ClientsRepository
        >
    with $Provider<ClientsRepository> {
  /// Proveedor del repositorio de clientes.
  ClientsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ClientsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ClientsRepository create(Ref ref) {
    return clientsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClientsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClientsRepository>(value),
    );
  }
}

String _$clientsRepositoryHash() => r'1837b2972210fa45219e5e57d456d2c75fd5be7f';

/// Controlador de clientes del dueño.

@ProviderFor(OwnerClientsController)
final ownerClientsControllerProvider = OwnerClientsControllerProvider._();

/// Controlador de clientes del dueño.
final class OwnerClientsControllerProvider
    extends $NotifierProvider<OwnerClientsController, Result<ClientOverview>> {
  /// Controlador de clientes del dueño.
  OwnerClientsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ownerClientsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ownerClientsControllerHash();

  @$internal
  @override
  OwnerClientsController create() => OwnerClientsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Result<ClientOverview> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Result<ClientOverview>>(value),
    );
  }
}

String _$ownerClientsControllerHash() =>
    r'0f52b57fd7718b9682654c1ce1b8cde8cc2e52e4';

/// Controlador de clientes del dueño.

abstract class _$OwnerClientsController
    extends $Notifier<Result<ClientOverview>> {
  Result<ClientOverview> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<Result<ClientOverview>, Result<ClientOverview>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Result<ClientOverview>, Result<ClientOverview>>,
              Result<ClientOverview>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Proveedor para detalle de cliente.

@ProviderFor(clientDetail)
final clientDetailProvider = ClientDetailFamily._();

/// Proveedor para detalle de cliente.

final class ClientDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<ClientMember>,
          ClientMember,
          FutureOr<ClientMember>
        >
    with $FutureModifier<ClientMember>, $FutureProvider<ClientMember> {
  /// Proveedor para detalle de cliente.
  ClientDetailProvider._({
    required ClientDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'clientDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$clientDetailHash();

  @override
  String toString() {
    return r'clientDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ClientMember> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ClientMember> create(Ref ref) {
    final argument = this.argument as String;
    return clientDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ClientDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$clientDetailHash() => r'b3cbe29928381c274ba6ea681344779351d4578a';

/// Proveedor para detalle de cliente.

final class ClientDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ClientMember>, String> {
  ClientDetailFamily._()
    : super(
        retry: null,
        name: r'clientDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Proveedor para detalle de cliente.

  ClientDetailProvider call(String membershipId) =>
      ClientDetailProvider._(argument: membershipId, from: this);

  @override
  String toString() => r'clientDetailProvider';
}
