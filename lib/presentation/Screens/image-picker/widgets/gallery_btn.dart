import 'package:flutter/material.dart';

class GalleryBtn extends StatelessWidget {
  final VoidCallback onPressed;
  const GalleryBtn({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Image.asset(
        'assets/images/gallery.png',
        width: 40,
        height: 40,
      ),
    );
    // return IconButton(
    //   onPressed: () {},
    //   icon: Icon(
    //     Icons.image,
    //     size: 40,
    //     color: Colors.cyan.shade100,
    //   ),
    // );
  }
}
