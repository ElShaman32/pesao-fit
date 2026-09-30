import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/supabase_provider.dart';
import '../../data/datasources/owner_application_remote_datasource.dart';
import '../../data/repositories/owner_application_repository_impl.dart';
import '../../domain/entities/owner_application.dart';
import '../../domain/repositories/owner_application_repository.dart';

part 'owner_application_controller.g.dart';

/// Estado del formulario de solicitud de dueño.
class OwnerApplicationState {
  const OwnerApplicationState({
    this.ownerPhone = '',
    this.ownerDocument = '',
    this.gymName = '',
    this.gymRif = '',
    this.gymAddress = '',
    this.gymState = '',
    this.gymCity = '',
    this.gymPhone = '',
    this.gymInstagram = '',
    this.gymDescription = '',
    this.gymPhotoUrl,
    this.latitude,
    this.longitude,
    this.isSubmitting = false,
    this.isSubmitted = false,
    this.error,
  });

  final String ownerPhone;
  final String ownerDocument;
  final String gymName;
  final String gymRif;
  final String gymAddress;
  final String gymState;
  final String gymCity;
  final String gymPhone;
  final String gymInstagram;
  final String gymDescription;
  final String? gymPhotoUrl;
  final double? latitude;
  final double? longitude;
  final bool isSubmitting;
  final bool isSubmitted;
  final String? error;

  bool get isValid {
    final phoneOk = RegExp(r'^0[0-9]{3}-?[0-9]{7}$').hasMatch(ownerPhone);
    final nameOk = gymName.trim().isNotEmpty;
    final addressOk = gymAddress.trim().isNotEmpty;
    final stateOk = gymState.isNotEmpty;
    final cityOk = gymCity.trim().isNotEmpty;
    final gymPhoneOk = RegExp(r'^0[0-9]{2,3}-?[0-9]{7}$').hasMatch(gymPhone);
    return phoneOk &&
        nameOk &&
        addressOk &&
        stateOk &&
        cityOk &&
        gymPhoneOk &&
        !isSubmitting;
  }

  OwnerApplicationState copyWith({
    String? ownerPhone,
    String? ownerDocument,
    String? gymName,
    String? gymRif,
    String? gymAddress,
    String? gymState,
    String? gymCity,
    String? gymPhone,
    String? gymInstagram,
    String? gymDescription,
    String? gymPhotoUrl,
    double? latitude,
    double? longitude,
    bool? isSubmitting,
    bool? isSubmitted,
    String? error,
    bool clearError = false,
  }) {
    return OwnerApplicationState(
      ownerPhone: ownerPhone ?? this.ownerPhone,
      ownerDocument: ownerDocument ?? this.ownerDocument,
      gymName: gymName ?? this.gymName,
      gymRif: gymRif ?? this.gymRif,
      gymAddress: gymAddress ?? this.gymAddress,
      gymState: gymState ?? this.gymState,
      gymCity: gymCity ?? this.gymCity,
      gymPhone: gymPhone ?? this.gymPhone,
      gymInstagram: gymInstagram ?? this.gymInstagram,
      gymDescription: gymDescription ?? this.gymDescription,
      gymPhotoUrl: gymPhotoUrl ?? this.gymPhotoUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Controlador del formulario de solicitud de dueño.
@riverpod
class OwnerApplicationController extends _$OwnerApplicationController {
  late final OwnerApplicationRepository _repository;

  @override
  OwnerApplicationState build() {
    _repository = OwnerApplicationRepositoryImpl(
      remote: OwnerApplicationRemoteDatasource(supabaseClient),
    );
    return const OwnerApplicationState();
  }

  void setOwnerPhone(String value) {
    state = state.copyWith(ownerPhone: value, clearError: true);
  }

  void setOwnerDocument(String value) {
    state = state.copyWith(ownerDocument: value, clearError: true);
  }

  void setGymName(String value) {
    state = state.copyWith(gymName: value, clearError: true);
  }

  void setGymRif(String value) {
    state = state.copyWith(gymRif: value, clearError: true);
  }

  void setGymAddress(String value) {
    state = state.copyWith(gymAddress: value, clearError: true);
  }

  void setGymState(String? value) {
    state = state.copyWith(gymState: value ?? '', clearError: true);
  }

  void setGymCity(String value) {
    state = state.copyWith(gymCity: value, clearError: true);
  }

  void setGymPhone(String value) {
    state = state.copyWith(gymPhone: value, clearError: true);
  }

  void setGymInstagram(String value) {
    state = state.copyWith(gymInstagram: value, clearError: true);
  }

  void setGymDescription(String value) {
    state = state.copyWith(gymDescription: value, clearError: true);
  }

  void setGymPhotoUrl(String? value) {
    state = state.copyWith(gymPhotoUrl: value, clearError: true);
  }

  void setLocation(double? latitude, double? longitude) {
    state = state.copyWith(
      latitude: latitude,
      longitude: longitude,
      clearError: true,
    );
  }

  /// Envía la solicitud a Supabase.
  Future<void> submit() async {
    if (!state.isValid || state.isSubmitting) {
      debugPrint(
        '❌ Validación falló: isValid=${state.isValid}, isSubmitting=${state.isSubmitting}',
      );
      debugPrint('Estado actual: $state');
      return;
    }

    state = state.copyWith(isSubmitting: true, clearError: true);

    final application = OwnerApplication(
      ownerPhone: state.ownerPhone.trim(),
      ownerDocument: state.ownerDocument.trim().isEmpty
          ? null
          : state.ownerDocument.trim(),
      gymName: state.gymName.trim(),
      gymRif: state.gymRif.trim().isEmpty ? null : state.gymRif.trim(),
      gymAddress: state.gymAddress.trim(),
      gymState: state.gymState,
      gymCity: state.gymCity.trim(),
      gymPhone: state.gymPhone.trim(),
      gymInstagram: state.gymInstagram.trim().isEmpty
          ? null
          : state.gymInstagram.trim(),
      gymDescription: state.gymDescription.trim().isEmpty
          ? null
          : state.gymDescription.trim(),
      gymPhotoUrl: state.gymPhotoUrl,
      latitude: state.latitude,
      longitude: state.longitude,
    );

    debugPrint('📤 Enviando solicitud: $application');

    final result = await _repository.submit(application);

    debugPrint('📥 Resultado: $result');

    result.when(
      idle: () => debugPrint('Estado: idle'),
      loading: () => debugPrint('Estado: loading'),
      success: (data) {
        debugPrint('✅ Éxito: $data');
        state = state.copyWith(isSubmitting: false, isSubmitted: true);
      },
      failure: (error) {
        debugPrint('❌ Error: ${error.code} - ${error.message}');
        debugPrint('Causa: ${error.cause}');
        state = state.copyWith(
          isSubmitting: false,
          error: error.message ?? 'Error al enviar solicitud',
        );
      },
    );
  }
}
