import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DetailsDataSource {
  Future<void> addToCart(String userId, Map<String, dynamic> item);
}

class DetailsDataSourceImpl implements DetailsDataSource {
  final FirebaseFirestore firestore;
  DetailsDataSourceImpl(this.firestore);

  @override
  Future<void> addToCart(String userId, Map<String, dynamic> item) async {
    try {
      await firestore
          .collection('user')
          .doc(userId)
          .collection('cart')
          .add(item);
    } catch (e) {
      rethrow;
    }
  }
}