import '../../domain/repository/food_details_repository.dart';
import '../data_source/food_details_data_source.dart';

class DetailsRepositoryImpl implements DetailsRepository {
  final DetailsDataSource detailsDataSource;
  DetailsRepositoryImpl(this.detailsDataSource);

  @override
  Future<void> addToCart(String userId, Map<String, dynamic> item) {
    return detailsDataSource.addToCart(userId, item);
  }
}