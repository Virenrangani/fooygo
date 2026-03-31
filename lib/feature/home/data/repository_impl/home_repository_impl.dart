import '../../domain/food_entity/food_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../data_source/home_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource homeDataSource;
  HomeRepositoryImpl(this.homeDataSource);

  @override
  Stream<List<FoodEntity>> getFoodItems(String category) {
    return homeDataSource.getFoodItems(category).map(
          (models) => models
          .map((m) => FoodEntity(
        id: m.id,
        name: m.name,
        details: m.details,
        image: m.image,
        price: m.price,
      ))
          .toList(),
    );
  }
}