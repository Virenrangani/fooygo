import '../repository/food_details_repository.dart';

class AddToCartUseCase {
  final DetailsRepository repository;
  AddToCartUseCase(this.repository);

  Future<void> call(String userId, Map<String, dynamic> item) {
    return repository.addToCart(userId, item);
  }
}