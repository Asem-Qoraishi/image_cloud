import 'package:flutter/material.dart';
import 'package:image_cloud/domain/image/image_entity.dart';

@immutable
class ImageState {
  final List<ImageEntity> imageEntities;
  final String? error;
  const ImageState({
    required this.imageEntities,
    required this.error,
  });

  factory ImageState.initial() {
    return const ImageState(imageEntities: [], error: null);
  }
}
