import 'package:image_cloud/domain/image/image_entity.dart';

class ImageModel extends ImageEntity {
  ImageModel({required super.imageUrl});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(imageUrl: json["imageUrl"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "imageUrl": imageUrl,
    };
  }

  ImageEntity toEntity() {
    return ImageEntity(imageUrl: imageUrl);
  }
}
