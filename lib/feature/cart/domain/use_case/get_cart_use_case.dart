import '../entity/cart_entity.dart';
import '../repository/cart_repository.dart';

class GetCartUseCase {
  final CartRepository repository;
  GetCartUseCase(this.repository);

  Stream<List<CartEntity>> call(String userId) {
    return repository.getCart(userId);
  }
}