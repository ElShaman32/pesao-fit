import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/utils/result.dart';
import '../../data/datasources/payments_remote_datasource.dart';
import '../../data/repositories/payments_repository_impl.dart';
import '../../domain/entities/payment.dart';
import '../../domain/repositories/payments_repository.dart';

part 'payments_providers.g.dart';

/// Filtro visible de la lista de pagos.
enum PaymentFilter { pending, verified, rejected }

/// Estado de la pantalla de pagos del dueño.
class PaymentsState {
  final List<Payment> payments;
  final bool isLoading;
  final bool isActing;
  final String? error;
  final PaymentFilter filter;

  const PaymentsState({
    this.payments = const [],
    this.isLoading = false,
    this.isActing = false,
    this.error,
    this.filter = PaymentFilter.pending,
  });

  bool get hasData => payments.isNotEmpty;

  List<Payment> get filteredPayments {
    switch (filter) {
      case PaymentFilter.pending:
        return payments
            .where((p) => p.status == PaymentStatus.pending)
            .toList();
      case PaymentFilter.verified:
        return payments
            .where((p) => p.status == PaymentStatus.verified)
            .toList();
      case PaymentFilter.rejected:
        return payments
            .where((p) => p.status == PaymentStatus.rejected)
            .toList();
    }
  }

  PaymentsState copyWith({
    List<Payment>? payments,
    bool? isLoading,
    bool? isActing,
    String? error,
    bool clearError = false,
    PaymentFilter? filter,
  }) {
    return PaymentsState(
      payments: payments ?? this.payments,
      isLoading: isLoading ?? this.isLoading,
      isActing: isActing ?? this.isActing,
      error: clearError ? null : (error ?? this.error),
      filter: filter ?? this.filter,
    );
  }
}

/// Proveedor del repositorio de pagos.
@riverpod
PaymentsRepository paymentsRepository(Ref ref) {
  return PaymentsRepositoryImpl(
    remote: PaymentsRemoteDatasource(Supabase.instance.client),
  );
}

/// Controlador de pagos del dueño.
@Riverpod(keepAlive: true)
class OwnerPaymentsController extends _$OwnerPaymentsController {
  late final PaymentsRepository _repository;

  @override
  PaymentsState build() {
    _repository = ref.watch(paymentsRepositoryProvider);

    authProvider.addListener(_onAuthChange);
    ref.onDispose(() => authProvider.removeListener(_onAuthChange));

    if (authProvider.isLoggedIn && !authProvider.isInitializing) {
      Future.microtask(load);
    }

    return const PaymentsState();
  }

  void _onAuthChange() {
    if (!authProvider.isLoggedIn) {
      state = const PaymentsState();
      return;
    }

    if (!authProvider.isInitializing && !state.isLoading && !state.hasData) {
      load();
    }
  }

  Future<void> load() async {
    final gymId = authProvider.userGymId;
    debugPrint('🔍 PAYMENTS LOAD: gymId=$gymId');

    if (gymId == null) {
      debugPrint('⚠️ PAYMENTS LOAD: gymId es null.');
      state = state.copyWith(
        isLoading: false,
        error: 'No tienes un gimnasio activo.',
      );
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.getOwnerPayments(gymId: gymId);

    result.when(
      idle: () {},
      loading: () {},
      success: (payments) {
        debugPrint('✅ PAYMENTS LOAD: ${payments.length} pagos.');
        state = state.copyWith(isLoading: false, payments: payments);
      },
      failure: (error) {
        debugPrint('❌ PAYMENTS LOAD: $error');
        state = state.copyWith(isLoading: false, error: error.toString());
      },
    );
  }

  Future<void> setFilter(PaymentFilter filter) async {
    state = state.copyWith(filter: filter);
  }

  Future<Result<void>> approvePayment(String paymentId) async {
    state = state.copyWith(isActing: true);

    final result = await _repository.approvePayment(paymentId: paymentId);

    if (result.isSuccess) {
      await load();
    }

    state = state.copyWith(isActing: false);
    return result;
  }

  Future<Result<void>> rejectPayment(String paymentId, String reason) async {
    state = state.copyWith(isActing: true);

    final result = await _repository.rejectPayment(
      paymentId: paymentId,
      reason: reason,
    );

    if (result.isSuccess) {
      await load();
    }

    state = state.copyWith(isActing: false);
    return result;
  }
}
