import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cloud/presentation/Providers/bottom-nav/bottom_nav_provider.dart';
import 'package:image_cloud/presentation/Screens/image-picker/image_picker_screen.dart';

import '../image-list/image_list_screen.dart';

class MainWrapper extends ConsumerWidget {
  MainWrapper({Key? key}) : super(key: key);
  final List<Widget> pages = [ImageListScreen(), const ImagePickerScreen()];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int pageIndex = ref.watch(bottomNavProvider);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 60,
        elevation: 0,
        selectedIndex: pageIndex,
        backgroundColor: const Color.fromRGBO(240, 240, 250, 1),
        indicatorColor: const Color.fromRGBO(200, 220, 250, 1),
        onDestinationSelected: (index) => ref.read(bottomNavProvider.notifier).state = index,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.camera_enhance_outlined),
            selectedIcon: Icon(Icons.camera_enhance_rounded),
            label: "Gallery",
          ),
        ],
      ),
      body: pages[pageIndex],
    );
  }
}
