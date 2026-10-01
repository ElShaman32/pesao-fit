import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/cloudinary_provider.dart';
import '../../../../core/utils/result.dart';
import '../../data/datasources/client_payments_remote_datasource.dart';
import '../../data/repositories/client_payments_repository_impl.dart';
import '../../domain/entities/payment.dart';
import '../../domain/entities/upload_payment_request.dart';
import '../../domain/repositories/client_payments_repository.dart';

part 'client_payments_controller.g.dart';

/// Estado del formulario de subida de pago del cliente.
class ClientPaymentUploadState {
  final bool isUploading;
  final String? error;

  const ClientPaymentUploadState({this.isUploading = false, this.error});

  ClientPaymentUploadState copyWith({
    bool? isUploading,
    String? error,
    bool clearError = false,
  }) {
    return ClientPaymentUploadState(
      isUploading: isUploading ?? this.isUploading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

@riverpod
ClientPaymentsRepository clientPaymentsRepository(Ref ref) {
  return ClientPaymentsRepositoryImpl(
    remote: ClientPaymentsRemoteDatasource(
      client: Supabase.instance.client,
      cloudinary: ref.watch(cloudinaryServiceProvider),
    ),
  );
}

@Riverpod(keepAlive: true)
class ClientPaymentUploadController extends _$ClientPaymentUploadController {
  late final ClientPaymentsRepository _repository;

  @override
  ClientPaymentUploadState build() {
    _repository = ref.watch(clientPaymentsRepositoryProvider);
    return const ClientPaymentUploadState();
  }

  /// Sube el comprobante. Devuelve el pago creado si tiene éxito.
  Future<Result<Payment>> upload(UploadPaymentRequest request) async {
    state = state.copyWith(isUploading: true, clearError: true);

    final result = await _repository.uploadPayment(request);

    result.when(
      idle: () {},
      loading: () {},
      success: (payment) {
        debugPrint('✅ CLIENT UPLOAD: pago creado id=${payment.id}');
        state = state.copyWith(isUploading: false);
      },
      failure: (error) {
        debugPrint('❌ CLIENT UPLOAD: $error');
        state = state.copyWith(isUploading: false, error: error.toString());
      },
    );

    return result;
  }

  /// Obtiene la tasa vigente del gimnasio.
  Future<double?> getCurrentRate() async {
    final gymId = authProvider.userGymId;
    if (gymId == null) return null;

    final result = await _repository.getCurrentRate(gymId);
    return result.dataOrNull;
  }
}
