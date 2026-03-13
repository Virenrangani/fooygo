import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/feature/auth/domain/usecase/sign_up_use_case.dart';
import 'auth_state.dart';

class SignupCubit extends Cubit<AuthState> {
  final SignUpUseCase signUpUseCase;
  SignupCubit(this.signUpUseCase) : super(AuthInitial());

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(AuthLoading());
    try {
      await signUpUseCase.signUpCall(email, name, password);

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Registration failed"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}