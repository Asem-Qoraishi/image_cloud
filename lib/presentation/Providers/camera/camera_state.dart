import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

@immutable
class CameraState {
  final FlashMode flashMode;
  final CameraController? controller;
  final XFile? image;

  const CameraState({
    required this.controller,
    required this.image,
    this.flashMode = FlashMode.off,
  });

  CameraState copyWith({CameraController? controller, XFile? image, FlashMode? flashMode}) {
    return CameraState(
      controller: controller ?? this.controller,
      image: image ?? this.image,
      flashMode: flashMode ?? this.flashMode,
    );
  }
}
