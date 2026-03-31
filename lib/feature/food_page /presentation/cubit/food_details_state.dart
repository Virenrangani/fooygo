abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsQuantityUpdated extends DetailsState {
  final int quantity;
  final int total;

  DetailsQuantityUpdated({
    required this.quantity,
    required this.total,
  });
}

class CartAdding extends DetailsState {}

class CartSuccess extends DetailsState {}

class CartFailure extends DetailsState {
  final String message;
  CartFailure(this.message);
}