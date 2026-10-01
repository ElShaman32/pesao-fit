// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Proveedor del datasource remoto de staff.

@ProviderFor(staffRemoteDatasource)
final staffRemoteDatasourceProvider = StaffRemoteDatasourceProvider._();

/// Proveedor del datasource remoto de staff.

final class StaffRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          StaffRemoteDatasource,
          StaffRemoteDatasource,
          StaffRemoteDatasource
        >
    with $Provider<StaffRemoteDatasource> {
  /// Proveedor del datasource remoto de staff.
  StaffRemoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'staffRemoteDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$staffRemoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<StaffRemoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StaffRemoteDatasource create(Ref ref) {
    return staffRemoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StaffRemoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StaffRemoteDatasource>(value),
    );
  }
}

String _$staffRemoteDatasourceHash() =>
    r'6f59e9c0e271aab7e3d2109073ccbc90529da484';

/// Proveedor del datasource local de staff.

@ProviderFor(staffLocalDatasource)
final staffLocalDatasourceProvider = StaffLocalDatasourceProvider._();

/// Proveedor del datasource local de staff.

final class StaffLocalDatasourceProvider
    extends
        $FunctionalProvider<
          StaffLocalDatasource,
          StaffLocalDatasource,
          StaffLocalDatasource
        >
    with $Provider<StaffLocalDatasource> {
  /// Proveedor del datasource local de staff.
  StaffLocalDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'staffLocalDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$staffLocalDatasourceHash();

  @$internal
  @override
  $ProviderElement<StaffLocalDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StaffLocalDatasource create(Ref ref) {
    return staffLocalDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StaffLocalDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StaffLocalDatasource>(value),
    );
  }
}

String _$staffLocalDatasourceHash() =>
    r'5aebe17e190fa7305eb906124ca6dcf1ed659b0f';

/// Proveedor del repositorio de staff.

@ProviderFor(staffRepository)
final staffRepositoryProvider = StaffRepositoryProvider._();

/// Proveedor del repositorio de staff.

final class StaffRepositoryProvider
    extends
        $FunctionalProvider<StaffRepository, StaffRepository, StaffRepository>
    with $Provider<StaffRepository> {
  /// Proveedor del repositorio de staff.
  StaffRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'staffRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$staffRepositoryHash();

  @$internal
  @override
  $ProviderElement<StaffRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StaffRepository create(Ref ref) {
    return staffRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StaffRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StaffRepository>(value),
    );
  }
}

String _$staffRepositoryHash() => r'1afdc73abd57e14b4f10a6024f7066da6c0dbbc8';

/// Controller del staff del gimnasio del owner actual.
/// keepAlive para evitar recargas innecesarias.
/// Escucha authProvider para recargar cuando cambia la sesión.

@ProviderFor(OwnerStaffController)
final ownerStaffControllerProvider = OwnerStaffControllerProvider._();

/// Controller del staff del gimnasio del owner actual.
/// keepAlive para evitar recargas innecesarias.
/// Escucha authProvider para recargar cuando cambia la sesión.
final class OwnerStaffControllerProvider
    extends $AsyncNotifierProvider<OwnerStaffController, StaffOverview> {
  /// Controller del staff del gimnasio del owner actual.
  /// keepAlive para evitar recargas innecesarias.
  /// Escucha authProvider para recargar cuando cambia la sesión.
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
}

String _$ownerStaffControllerHash() =>
    r'e127b5751004e60fb7949c8edd23e8187ab4680d';

/// Controller del staff del gimnasio del owner actual.
/// keepAlive para evitar recargas innecesarias.
/// Escucha authProvider para recargar cuando cambia la sesión.

abstract class _$OwnerStaffController extends $AsyncNotifier<StaffOverview> {
  FutureOr<StaffOverview> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<StaffOverview>, StaffOverview>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<StaffOverview>, StaffOverview>,
              AsyncValue<StaffOverview>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
