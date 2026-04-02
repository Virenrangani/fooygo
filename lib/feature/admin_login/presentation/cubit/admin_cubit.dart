import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_case/admin_use_case.dart';
import 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  final AdminLoginUseCase adminLoginUseCase;
  AdminCubit(this.adminLoginUseCase) : super(AdminInitial());

  Future<void> login({
    required String id,
    required String password,
  }) async {
    emit(AdminLoading());
    try {
      await adminLoginUseCase.call(id, password);
      emit(AdminLoginSuccess());
    } catch (e) {
      emit(AdminLoginFailure(e.toString()));
    }
  }
}