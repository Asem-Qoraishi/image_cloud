import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cloud/presentation/Providers/bottom-nav/bottom_nav_provider.dart';
import 'package:image_cloud/presentation/Providers/image/images.provider.dart';
import 'package:image_cloud/presentation/Screens/main-warpper/main_wrapper.dart';
import 'package:lottie/lottie.dart';

class UploadImageScreen extends ConsumerStatefulWidget {
  final Uint8List? image;
  const UploadImageScreen({required this.image, Key? key}) : super(key: key);

  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends ConsumerState<UploadImageScreen> {
  double progress = 0;
  @override
  void initState() {
    super.initState();
    uploadImage();
  }

  Future<void> uploadImage() async {
    await ref.read(imageControllerProvider.notifier).uploadImage(
          image: widget.image!,
          onProgress: (p0) {
            setState(() {
              progress = p0;
            });
          },
          onComplete: () {
            ref.read(bottomNavProvider.notifier).state = 0;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainWrapper(),
              ),
            );
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Lottie.asset('assets/animations/upload_animation.json', repeat: true, width: 250, height: 250),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
              child: LinearProgressIndicator(
                minHeight: 12,
                value: progress,
                backgroundColor: Colors.grey,
                color: Colors.green,
              ),
            ),
            Text('${(progress * 100).roundToDouble()}%')
          ],
        ),
      ),
    );
  }
}
