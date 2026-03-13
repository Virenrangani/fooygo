import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/feature/auth/domain/usecase/login_use_case.dart';
import 'auth_state.dart';

class LoginCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  LoginCubit(this.loginUseCase) : super(AuthInitial());

  Future<void> login({required String email, required String password,}) async {
    emit(AuthLoading());
    try {
      await loginUseCase.loginCall(email, password);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "An error occurred"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}