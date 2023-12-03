import 'package:flutter/material.dart';

class SwitchCameraBtn extends StatelessWidget {
  final VoidCallback onPressed;
  const SwitchCameraBtn({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.cameraswitch_outlined,
        color: Colors.white,
        size: 40,
      ),
      onPressed: onPressed,
    );
  }
}
