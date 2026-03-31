import '../../domain/food_entity/food_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<FoodEntity> foods;
  final String selectedCategory;

  HomeLoaded({
    required this.foods,
    required this.selectedCategory,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}