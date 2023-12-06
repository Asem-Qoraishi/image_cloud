class ImageEntity {
  final String imageUrl;
  const ImageEntity({required this.imageUrl});

  ImageEntity copyWith({required String imageUrl}) {
    return ImageEntity(imageUrl: imageUrl);
  }
}
