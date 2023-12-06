import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_cloud/data/image/model/image_model.dart';

class FireStoreRemoteDataSource {
  final FirebaseFirestore fireStoreDB = FirebaseFirestore.instance;

  Future<void> saveImageUrl(ImageModel imageModel) async {
    await fireStoreDB.collection('images').add(imageModel.toJson());
  }

  Future<List<ImageModel>> getImages() async {
    QuerySnapshot querySnapshot = await fireStoreDB.collection('images').get();
    List<ImageModel> imageModels = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      print('${json['imageUrl']}');
      imageModels.add(ImageModel.fromJson(json));
    }
    return imageModels;
  }
}
