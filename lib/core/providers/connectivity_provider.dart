import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_provider.g.dart';

/// Estado de conectividad global de la app.
/// True = hay internet, False = offline.
@Riverpod(keepAlive: true)
Stream<bool> connectivity(Ref ref) {
  return Connectivity().onConnectivityChanged.map(
    (results) => !results.contains(ConnectivityResult.none),
  );
}

/// Versión síncrona para uso en widgets (último valor conocido).
@Riverpod(keepAlive: true)
Future<bool> isOnline(Ref ref) async {
  final results = await Connectivity().checkConnectivity();
  return !results.contains(ConnectivityResult.none);
}
