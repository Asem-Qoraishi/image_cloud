import 'package:flutter/material.dart';

class ImageItem extends StatelessWidget {
  final String imageUrl;
  const ImageItem({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Card(
        clipBehavior: Clip.hardEdge,
        color: Colors.blue,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: Color.fromRGBO(200, 220, 255, 1),
            width: 2,
          ),
        ),
        child: Image.network(
          imageUrl,
          width: 400,
          height: 250,
          fit: BoxFit.cover,
        ),
      ),
    ]);
  }
}
