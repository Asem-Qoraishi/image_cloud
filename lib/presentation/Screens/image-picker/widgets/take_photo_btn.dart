import 'package:flutter/material.dart';

class TakePhotoBtn extends StatelessWidget {
  final VoidCallback onPressed;

  const TakePhotoBtn({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: ElevatedButton(
        clipBehavior: Clip.hardEdge,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
            side: const BorderSide(width: 2, color: Colors.grey),
          ),
        ),
        onPressed: onPressed,
        child: Container(),
      ),
    );
  }
}
