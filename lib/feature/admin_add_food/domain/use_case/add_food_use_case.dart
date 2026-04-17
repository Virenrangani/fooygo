import '../repository/add_food_repository.dart';

class AddFoodUseCase {
  final AddFoodRepository repository;
  AddFoodUseCase(this.repository);

  Future<void> call({
    required String imageUrl,
    required String name,
    required String price,
    required String detail,
    required String category,
  }) {
    return repository.addFoodItem(
      imageUrl: imageUrl,
      name: name,
      price: price,
      detail: detail,
      category: category,
    );
  }
}