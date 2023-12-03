import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cloud/presentation/Providers/camera/camera.provider.dart';

class CameraPreviewWidget extends ConsumerWidget {
  const CameraPreviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CameraController? controller = ref.watch(cameraControllerProvider).controller;
    var isCameraReady = controller != null && controller.value.isInitialized;
    return isCameraReady
        ? CameraPreview(controller)
        : const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(' Initilizing Camerea...'),
                SizedBox(
                  height: 24,
                ),
                CircularProgressIndicator(
                  color: Colors.black,
                ),
              ],
            ),
          );
  }
}
