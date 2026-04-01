import 'package:foodygo/feature/cart/domain/entity/cart_entity.dart';
import 'package:foodygo/feature/cart/domain/repository/cart_repository.dart';
import '../data_source/cart_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDataSource cartDataSource;
  CartRepositoryImpl(this.cartDataSource);

  @override
  Stream<List<CartEntity>> getCart(String userId) {
    return cartDataSource.getCart(userId).map(
          (models) => models
          .map((m) => CartEntity(
        name: m.name,
        image: m.image,
        quantity: m.quantity,
        total: m.total,
      ))
          .toList(),
    );
  }

  @override
  Future<void> checkout(String userId, int newBalance) {
    return cartDataSource.checkout(userId, newBalance);
  }
}