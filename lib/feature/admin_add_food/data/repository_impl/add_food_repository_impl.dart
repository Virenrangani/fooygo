import '../../domain/repository/add_food_repository.dart';
import '../data_source/add_food_data_source.dart';

class AddFoodRepositoryImpl implements AddFoodRepository {
  final AddFoodDataSource addFoodDataSource;
  AddFoodRepositoryImpl(this.addFoodDataSource);

  @override
  Future<void> addFoodItem({
    required String imageUrl,
    required String name,
    required String price,
    required String detail,
    required String category,
  }) {
    return addFoodDataSource.addFoodItem(
      imageUrl: imageUrl,
      name: name,
      price: price,
      detail: detail,
      category: category,
    );
  }
}