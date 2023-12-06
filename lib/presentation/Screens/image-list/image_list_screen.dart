import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cloud/presentation/Providers/image/images.provider.dart';
import 'package:image_cloud/presentation/Screens/image-list/widgets/image_item.dart';
import 'package:image_cloud/presentation/Screens/image-view/image_view_screen.dart';

class ImageListScreen extends ConsumerWidget {
  const ImageListScreen({Key? key}) : super(key: key);

  void onImagePressed(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageViewScreen(imageUrl: imageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(240, 240, 250, 1),
        title: const Row(children: [
          Text(
            "My Images",
          ),
          Icon(
            Icons.emoji_emotions,
            color: Colors.blue,
          ),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder(
          future: ref.read(imageControllerProvider.notifier).getImages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.error != null) {
                return Center(child: Text(snapshot.data!.error!));
              }

              var imageEntities = snapshot.data!.imageEntities;
              return ListView.builder(
                itemCount: imageEntities.length,
                itemBuilder: (context, index) => ImageItem(
                  imageUrl: imageEntities[index].imageUrl,
                  onPressed: () => onImagePressed(context, imageEntities[index].imageUrl),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
          },
        ),
      ),
    );
  }
}
