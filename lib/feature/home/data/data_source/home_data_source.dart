import 'package:cloud_firestore/cloud_firestore.dart';
import '../food_model/food_model.dart';

abstract class HomeDataSource {
  Stream<List<FoodModel>> getFoodItems(String category);
}

class HomeDataSourceImpl implements HomeDataSource {
  final FirebaseFirestore firestore;
  HomeDataSourceImpl(this.firestore);

  @override
  Stream<List<FoodModel>> getFoodItems(String category) {
    return firestore.collection(category).snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) =>
          FoodModel.fromFirestore(doc.data(), doc.id))
          .toList(),
    );
  }
}