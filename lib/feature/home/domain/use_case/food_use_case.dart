import '../food_entity/food_entity.dart';
import '../repository/home_repository.dart';

class GetFoodUseCase {
  final HomeRepository repository;
  GetFoodUseCase(this.repository);

  Stream<List<FoodEntity>> call(String category) {
    return repository.getFoodItems(category);
  }
}