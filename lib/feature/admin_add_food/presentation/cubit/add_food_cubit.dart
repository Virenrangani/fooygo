import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_case/add_food_use_case.dart';
import 'add_food_state.dart';

class AddFoodCubit extends Cubit<AddFoodState> {
  final AddFoodUseCase addFoodUseCase;
  AddFoodCubit(this.addFoodUseCase) : super(AddFoodInitial());

  Future<void> addFood({
    required String imageUrl,
    required String name,
    required String price,
    required String detail,
    required String category,
  }) async {
    emit(AddFoodLoading());
    try {
      await addFoodUseCase(
        imageUrl: imageUrl,
        name: name,
        price: price,
        detail: detail,
        category: category,
      );
      emit(AddFoodSuccess());
    } catch (e) {
      emit(AddFoodFailure(e.toString()));
    }
  }
}