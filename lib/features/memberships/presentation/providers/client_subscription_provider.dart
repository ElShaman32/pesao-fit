import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/datasources/client_subscription_remote_datasource.dart';
import '../../data/repositories/client_subscription_repository_impl.dart';
import '../../domain/entities/client_subscription.dart';
import '../../domain/repositories/client_subscription_repository.dart';

part 'client_subscription_provider.g.dart';

@riverpod
ClientSubscriptionRepository clientSubscriptionRepository(Ref ref) {
  return ClientSubscriptionRepositoryImpl(
    remote: ClientSubscriptionRemoteDatasource(Supabase.instance.client),
  );
}

/// Suscripción activa del cliente actual (para el dashboard del cliente).
@Riverpod(keepAlive: true)
class ClientSubscriptionController extends _$ClientSubscriptionController {
  late final ClientSubscriptionRepository _repository;

  @override
  AsyncValue<ClientSubscription?> build() {
    _repository = ref.watch(clientSubscriptionRepositoryProvider);
    Future.microtask(load);
    return const AsyncValue.loading();
  }

  Future<void> load() async {
    state = const AsyncValue.loading();
    final result = await _repository.getMySubscription();

    result.when(
      idle: () {},
      loading: () {},
      success: (subscription) => state = AsyncValue.data(subscription),
      failure: (error) => state = AsyncValue.error(error, StackTrace.current),
    );
  }
}
