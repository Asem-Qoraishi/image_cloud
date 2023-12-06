import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cloud/main.dart';
import 'package:image_cloud/presentation/Providers/camera/camera.provider.dart';
import 'package:image_cloud/presentation/Screens/image-picker/widgets/camera_preview.dart';
import 'package:image_cloud/presentation/Screens/image-picker/widgets/flash_button.dart';
import 'package:image_cloud/presentation/Screens/image-picker/widgets/gallery_btn.dart';
import 'package:image_cloud/presentation/Screens/image-picker/widgets/switch_camera._btn.dart';
import 'package:image_cloud/presentation/Screens/image-picker/widgets/take_photo_btn.dart';
import 'package:image_cloud/presentation/Screens/upload-image/upload_image_screen.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/utils.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends ConsumerStatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends ConsumerState<ImagePickerScreen> with WidgetsBindingObserver {
  ImagePicker picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ref.watch(cameraControllerProvider.notifier).onNewCameraSelected(cameras.first);
    WidgetsBinding.instance.addObserver(this);
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    CameraController? controller = ref.watch(cameraControllerProvider).controller;
    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      controller.dispose();
    } else if (state == AppLifecycleState.resumed) {
      ref.watch(cameraControllerProvider.notifier).onNewCameraSelected(controller.description);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> navigateToImageEditor(Uint8List image) async {
    await Navigator.push(
      ref.context,
      MaterialPageRoute(
        builder: (context) => ImageEditor(
          image: image,
          features: const ImageEditorFeatures(
            blur: true,
            emoji: true,
            crop: true,
            flip: true,
            text: true,
            filters: true,
            rotate: true,
          ),
        ),
      ),
    ).then(
      (value) {
        if (value != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return UploadImageScreen(
                  image: value,
                );
              },
            ),
          );
        }
      },
    );
  }

  Future<void> uploadImageToFirabaseStorage(Uint8List file) async {
    Reference ref =
        FirebaseStorage.instance.ref().child('images').child('${DateTime.now().microsecondsSinceEpoch}.png');
    ref.putData(file);
  }

  Future<void> takePhoto() async {
    try {
      XFile? image = await ref.watch(cameraControllerProvider.notifier).takePhoto();
      if (image != null) {
        await navigateToImageEditor(await image.readAsBytes());
        print("You teaked a picture.");
      } else {
        print("Error : no image file");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> switchCamera() async {
    await ref.watch(cameraControllerProvider.notifier).switchCamera();
  }

  void swithcFlashMode() {
    ref.watch(cameraControllerProvider.notifier).swithcFlashMode();
  }

  void pickImageFromGallery() async {
    XFile? image = await ref.watch(cameraControllerProvider.notifier).pickImageFromGallery();
    if (image != null) {
      await navigateToImageEditor(await image.readAsBytes());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          // padding: EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.topCenter,
            children: [
              const CameraPreviewWidget(),

              //Flash button to turn on of off flash of camera
              Positioned(
                top: 24,
                left: 16,
                child: FlashButton(
                  isOn: ref.watch(cameraControllerProvider).flashMode != FlashMode.off,
                  onPressed: swithcFlashMode,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 30,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GalleryBtn(
                          onPressed: pickImageFromGallery,
                        ),
                        TakePhotoBtn(onPressed: takePhoto),
                        SwitchCameraBtn(onPressed: switchCamera),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
