import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AddFoodDataSource {
  Future<void> addFoodItem({
    required String imageUrl,
    required String name,
    required String price,
    required String detail,
    required String category,
  });
}

class AddFoodDataSourceImpl implements AddFoodDataSource {
  final FirebaseFirestore firestore;
  AddFoodDataSourceImpl(this.firestore);

  @override
  Future<void> addFoodItem({
    required String imageUrl,
    required String name,
    required String price,
    required String detail,
    required String category,
  }) async {
    try {
      await firestore.collection(category).add({
        'image': imageUrl,
        'name': name,
        'price': price,
        'details': detail,
      });
    } catch (e) {
      rethrow;
    }
  }
}