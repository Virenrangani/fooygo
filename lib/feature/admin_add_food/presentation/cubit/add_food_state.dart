abstract class AddFoodState {}

class AddFoodInitial extends AddFoodState {}

class AddFoodLoading extends AddFoodState {}

class AddFoodSuccess extends AddFoodState {}

class AddFoodFailure extends AddFoodState {
  final String message;
  AddFoodFailure(this.message);
}