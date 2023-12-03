import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

@immutable
class CameraState {
  final CameraController? controller;
  final XFile? image;

  const CameraState({
    required this.controller,
    required this.image,
  });

  CameraState copyWith({CameraController? controller, XFile? image}) {
    return CameraState(
      controller: controller ?? this.controller,
      image: image ?? this.image,
    );
  }
}
