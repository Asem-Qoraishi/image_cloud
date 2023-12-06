import 'dart:typed_data';

import 'package:image_cloud/domain/image/image_entity.dart';

abstract class ImageRepository {
  Future<void> uploadImageFile({
    required Uint8List image,
    required void Function(double progress) onProgress,
    required void Function() onComplete,
  });

  Future<List<ImageEntity>> getImages();
}
