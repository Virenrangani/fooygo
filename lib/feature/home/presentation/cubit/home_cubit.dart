import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_case/food_use_case.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetFoodUseCase getFoodUseCase;

  StreamSubscription? _foodSubscription;
  String _selectedCategory = 'pizza';

  HomeCubit({ required this.getFoodUseCase}) : super(HomeInitial());

  void loadCategory(String category) {
    _selectedCategory = category;
    emit(HomeLoading());
    _foodSubscription?.cancel();

    _foodSubscription = getFoodUseCase(category).listen(
          (foods) => emit(
        HomeLoaded(foods: foods, selectedCategory: _selectedCategory),
      ),
      onError: (e) => emit(HomeError(e.toString())),
    );
  }

  @override
  Future<void> close() {
    _foodSubscription?.cancel();
    return super.close();
  }
}