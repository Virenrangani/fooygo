import '../entity/cart_entity.dart';

abstract class CartRepository {
  Stream<List<CartEntity>> getCart(String userId);
  Future<void> checkout(String userId, int newBalance);
}