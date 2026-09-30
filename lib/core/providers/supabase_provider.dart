import 'package:supabase_flutter/supabase_flutter.dart';

/// Instancia global del cliente de Supabase.
///
/// Se usa en datasources que necesitan el cliente sin pasar por Riverpod
/// (ej: AuthNotifier que se instancia como singleton fuera del widget tree).
///
/// En pantallas y providers, preferir `Supabase.instance.client` o
/// inyectar el cliente vía Riverpod.
final supabaseClient = Supabase.instance.client;
