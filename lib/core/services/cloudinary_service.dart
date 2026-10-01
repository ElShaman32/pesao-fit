import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

/// Resultado de una subida exitosa a Cloudinary.
class CloudinaryUploadResult {
  /// URL final de la imagen con transformaciones aplicadas.
  final String secureUrl;

  /// ID público usado en Cloudinary (ej: `receipts/{payment_id}`).
  final String publicId;

  const CloudinaryUploadResult({
    required this.secureUrl,
    required this.publicId,
  });
}

/// Servicio de subida directa unsigned a Cloudinary (ADR-008).
///
/// Se usa la cuenta 2 (progress/receipts) para comprobantes de pago
/// y fotos de progreso. No se debe invocar desde widgets.
class CloudinaryService {
  late final Dio _dio;
  late final String _cloudName;
  late final String _uploadPreset;

  CloudinaryService() {
    _cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
    _uploadPreset = dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? '';

    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.cloudinary.com/v1_1/$_cloudName',
        connectTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }

  /// Sube una imagen como multipart unsigned.
  ///
  /// - [bytes]: bytes de la imagen.
  /// - [publicId]: identificador único (ej: `{payment_id}`).
  /// - [folder]: carpeta en Cloudinary (ej: `receipts`).
  /// - [filename]: nombre de archivo de origen (sin extensión).
  Future<CloudinaryUploadResult> uploadImage({
    required Uint8List bytes,
    required String publicId,
    required String folder,
    String filename = 'upload',
  }) async {
    if (_cloudName.isEmpty || _uploadPreset.isEmpty) {
      throw Exception(
        'Cloudinary no está configurado: revisa CLOUDINARY_CLOUD_NAME '
        'y CLOUDINARY_UPLOAD_PRESET en tu .env',
      );
    }

    final multipartFile = MultipartFile.fromBytes(
      bytes,
      filename: '$filename.jpg',
    );

    final formData = FormData.fromMap({
      'file': multipartFile,
      'upload_preset': _uploadPreset,
      'folder': folder,
      'public_id': publicId,
      // Transformación de entrada: tamaño y calidad razonables.
      'transformation': 'w_1000,h_1400,c_limit,q_auto,f_auto',
    });

    debugPrint('☁️ CLOUDINARY: subiendo $folder/$publicId');

    final response = await _dio.post('/image/upload', data: formData);

    final secureUrl = response.data['secure_url'] as String;
    final returnedPublicId = response.data['public_id'] as String;

    debugPrint('✅ CLOUDINARY: subida OK. url=$secureUrl');

    return CloudinaryUploadResult(
      secureUrl: secureUrl,
      publicId: returnedPublicId,
    );
  }
}
