import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/cloudinary_service.dart';

part 'cloudinary_provider.g.dart';

/// Proveedor global del servicio Cloudinary.
@Riverpod(keepAlive: true)
CloudinaryService cloudinaryService(Ref ref) {
  return CloudinaryService();
}
