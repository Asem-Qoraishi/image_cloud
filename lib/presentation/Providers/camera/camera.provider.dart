import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cloud/main.dart';
import 'package:image_cloud/presentation/Providers/camera/camera_state.dart';
import 'package:image_picker/image_picker.dart';

final cameraControllerProvider =
    StateNotifierProvider<CameraFeaturesController, CameraState>((ref) => CameraFeaturesController(CameraState(
        controller: CameraController(
          cameras.first,
          ResolutionPreset.max,
          enableAudio: false,
          imageFormatGroup: ImageFormatGroup.jpeg,
        ),
        image: null)));

class CameraFeaturesController extends StateNotifier<CameraState> {
  CameraFeaturesController(super._state);
  FlashMode _flashMode = FlashMode.off;

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    final CameraController? oldController = state.controller;
    if (oldController != null) {
      state.copyWith(controller: null);
      await oldController.dispose();
    }
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    cameraController.setFlashMode(_flashMode);
    state = state.copyWith(controller: cameraController);

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      //Make sure that our widget is in the tree widget.
      if (mounted) {
        state = state.copyWith(controller: state.controller);
      }
      if (cameraController.value.hasError) {
        log('Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await state.controller!.initialize();
    } on CameraException catch (e) {
      log('CameraException error is $e');
    }

    if (mounted) {
      state = state.copyWith(controller: state.controller);
    }
  }

  FlashMode get flashMode => _flashMode;

  Future<void> swithcFlashMode() async {
    if (_flashMode == FlashMode.off) {
      _flashMode = FlashMode.always;
    } else {
      _flashMode = FlashMode.off;
    }
    state.controller!.setFlashMode(_flashMode);
  }

  Future<XFile?> pickImageFromGallery() async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      return image;
    } catch (e) {
      print(e);
    }
  }

  Future<void> switchCamera() async {
    if (state.controller!.description.lensDirection == CameraLensDirection.front) {
      switchToBackCamera();
    } else {
      switchToFrontCamera();
    }
  }

  Future<void> switchToFrontCamera() async {
    if (state.controller!.description.lensDirection != CameraLensDirection.front) {
      await onNewCameraSelected(
        cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front),
      );
    }
  }

  Future<void> switchToBackCamera() async {
    if (state.controller!.description.lensDirection != CameraLensDirection.back) {
      await onNewCameraSelected(
        cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back),
      );
    }
  }

  Future<XFile?> takePhoto() async {
    final CameraController? cameraController = state.controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      log('Error: select a camera first.');
      return null;
    }

    // A capture is already pending, do nothing.
    if (cameraController.value.isTakingPicture) {
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print("Error when taking picture : $e");
      return null;
    }
  }
}
