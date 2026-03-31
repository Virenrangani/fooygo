abstract class DetailsRepository {
  Future<void> addToCart(String userId, Map<String, dynamic> item);
}