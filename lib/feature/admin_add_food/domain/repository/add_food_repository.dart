abstract class AddFoodRepository {
  Future<void> addFoodItem({
    required String imageUrl,
    required String name,
    required String price,
    required String detail,
    required String category,
  });
}