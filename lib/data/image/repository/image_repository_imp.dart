import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cloud/data/image/model/image_model.dart';
import 'package:image_cloud/data/image/remote-datasource/fire_store_remote_dateasourece.dart';
import 'package:image_cloud/domain/image/image_entity.dart';
import 'package:image_cloud/domain/image/image_repository.dart';

class ImageRepositoryImp extends ImageRepository {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  @override
  Future<List<ImageEntity>> getImages() async {
    return await FireStoreRemoteDataSource().getImages();
  }

  @override
  Future<void> uploadImageFile({
    required Uint8List image,
    required void Function(double progress) onProgress,
    required void Function() onComplete,
  }) async {
    Reference ref = _firebaseStorage.ref().child('images').child('${DateTime.now().microsecondsSinceEpoch}.png');
    UploadTask uploadTask = ref.putData(image);
    uploadTask.snapshotEvents.listen(
      (TaskSnapshot snapshot) {
        final double progress = snapshot.bytesTransferred / snapshot.totalBytes;
        onProgress(progress);
      },
      onError: (Object e) {
        throw Exception('Error while uploading image: $e');
      },
      onDone: () async {},
    );
    uploadTask.whenComplete(
      () async {
        String imageUrl = await ref.getDownloadURL();
        FireStoreRemoteDataSource().saveImageUrl(ImageModel(imageUrl: imageUrl));
        onComplete();
      },
    );
  }
}
