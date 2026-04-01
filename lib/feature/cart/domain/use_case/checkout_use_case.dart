import '../repository/cart_repository.dart';

class CheckoutUseCase {
  final CartRepository repository;
  CheckoutUseCase(this.repository);

  Future<void> call(String userId, int newBalance) {
    return repository.checkout(userId, newBalance);
  }
}