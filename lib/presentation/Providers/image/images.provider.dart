import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cloud/data/image/repository/image_repository_imp.dart';
import 'package:image_cloud/domain/image/image_repository.dart';
import 'package:image_cloud/presentation/Providers/image/image_state.dart';

// final imageRepositoryProvider = Provider<ImageRepository>((ref) => ImageRepositoryImp());

final imageControllerProvider = StateNotifierProvider<ImageController, ImageState>(
  (ref) => ImageController(
    imageRepository: ImageRepositoryImp(),
  ),
);

class ImageController extends StateNotifier<ImageState> {
  final ImageRepository imageRepository;
  ImageController({required this.imageRepository}) : super(ImageState.initial());

  Future<void> uploadImage({
    required Uint8List image,
    required void Function(double) onProgress,
    required void Function() onComplete,
  }) async {
    await imageRepository.uploadImageFile(
      image: image,
      onProgress: onProgress,
      onComplete: onComplete,
    );
  }

  Future<ImageState> getImages() async {
    try {
      var imageEntities = await imageRepository.getImages();
      state = ImageState(imageEntities: imageEntities, error: null);
    } catch (e) {
      state = ImageState(imageEntities: const [], error: 'Error : $e');
    }
    return state;
  }
}
