import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/owner_application.dart';

/// DataSource remoto de solicitudes de dueño.
/// Único punto de contacto con Supabase para gym_applications.
class OwnerApplicationRemoteDatasource {
  OwnerApplicationRemoteDatasource(this._client);

  final SupabaseClient _client;

  /// Inserta una nueva solicitud en gym_applications.
  Future<OwnerApplication> submit(OwnerApplication application) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('Usuario no autenticado');
    }

    final response = await _client
        .from('gym_applications')
        .insert({
          'user_id': userId,
          'owner_name':
              (await _client
                      .from('profiles')
                      .select('full_name')
                      .eq('id', userId)
                      .single())['full_name']
                  as String,
          'owner_phone': application.ownerPhone,
          'owner_document': application.ownerDocument,
          'gym_name': application.gymName,
          'gym_rif': application.gymRif,
          'gym_address': application.gymAddress,
          'gym_state': application.gymState,
          'gym_city': application.gymCity,
          'gym_phone': application.gymPhone,
          'gym_instagram': application.gymInstagram,
          'gym_description': application.gymDescription,
          'gym_photo_url': application.gymPhotoUrl,
          'latitude': application.latitude,
          'longitude': application.longitude,
        })
        .select()
        .single();

    return OwnerApplication(
      id: response['id'] as String,
      ownerPhone: response['owner_phone'] as String,
      ownerDocument: response['owner_document'] as String?,
      gymName: response['gym_name'] as String,
      gymRif: response['gym_rif'] as String?,
      gymAddress: response['gym_address'] as String,
      gymState: response['gym_state'] as String,
      gymCity: response['gym_city'] as String,
      gymPhone: response['gym_phone'] as String,
      gymInstagram: response['gym_instagram'] as String?,
      gymDescription: response['gym_description'] as String?,
      gymPhotoUrl: response['gym_photo_url'] as String?,
      latitude: (response['latitude'] as num?)?.toDouble(),
      longitude: (response['longitude'] as num?)?.toDouble(),
    );
  }
}
