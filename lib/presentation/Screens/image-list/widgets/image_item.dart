import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageItem extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onPressed;
  const ImageItem({Key? key, required this.imageUrl, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 400,
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
              color: Color.fromRGBO(200, 220, 255, 1),
              width: 2,
            ),
          ),
          child: Center(
            child: CachedNetworkImage(
              fadeInDuration: const Duration(milliseconds: 500),
              width: double.infinity,
              height: double.infinity,
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return const Icon(Icons.error);
              },
              placeholder: (context, url) => const CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
