import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cloud/presentation/Screens/image-list/widgets/image_item.dart';

class ImageList extends ConsumerWidget {
  ImageList({Key? key}) : super(key: key);
  List<String> imageUrls = [
    'https://via.placeholder.com/600/92c952',
    'https://via.placeholder.com/600/771796',
    'https://via.placeholder.com/600/24f355',
    "https://via.placeholder.com/600/d32776",
    "https://via.placeholder.com/600/f66b97",
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(240, 240, 250, 1),
        title: const Row(children: [
          Text(
            "My Images",
            // style: TextStyle(color: Colors.yellow),
          ),
          Icon(
            Icons.emoji_emotions,
            color: Colors.blue,
          ),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: imageUrls.length,
          itemBuilder: (context, index) => ImageItem(imageUrl: imageUrls[index]),
        ),
      ),
    );
  }
}
