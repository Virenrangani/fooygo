import '../food_entity/food_entity.dart';

abstract class HomeRepository {
  Stream<List<FoodEntity>> getFoodItems(String category);
}