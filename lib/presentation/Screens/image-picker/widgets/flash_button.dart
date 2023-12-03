import 'package:flutter/material.dart';

class FlashButton extends StatelessWidget {
  final bool isOn;
  final VoidCallback onPressed;
  const FlashButton({Key? key, required this.isOn, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(isOn ? Icons.flash_on : Icons.flash_off, color: Colors.white),
    );
  }
}
