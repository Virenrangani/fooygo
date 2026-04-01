import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodygo/feature/cart/data/model/cart_model.dart';

abstract class CartDataSource {
  Stream<List<CartModel>> getCart(String userId);
  Future<void> checkout(String userId, int newBalance);
}

class CartDataSourceImpl implements CartDataSource {
  final FirebaseFirestore firestore;
  CartDataSourceImpl(this.firestore);

  @override
  Stream<List<CartModel>> getCart(String userId) {
    return firestore
        .collection('user')
        .doc(userId)
        .collection('cart')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => CartModel.fromFirestore(doc.data()))
        .toList());
  }

  @override
  Future<void> checkout(String userId, int newBalance) async {
    try {
      await firestore
          .collection('user')
          .doc(userId)
          .update({'wallet': newBalance});
    } catch (e) {
      rethrow;
    }
  }
}