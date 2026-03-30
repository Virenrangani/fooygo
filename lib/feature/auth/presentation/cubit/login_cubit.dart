import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/feature/auth/domain/usecase/login_use_case.dart';
import '../../../../core/validation/email_validation/email_password_validation.dart';
import '../../../../core/validation/password_validation/password_validation.dart';
import 'auth_state.dart';

class LoginCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  LoginCubit(this.loginUseCase) : super(AuthInitial());

  bool emailTouched = false;
  bool passwordTouched = false;

  String? emailError;
  String? passwordError;


  void emailValidation(String value) {
    emailTouched=true;
    emailError = validateEmail(value);
    emit(AuthFormValid());
  }

  void passwordValidation(String value) {
    passwordTouched=true;
    passwordError = validatePassword(value);
    emit(AuthFormValid());
  }

  bool get isFormValid {
    return emailError == null
        && passwordError == null
        && emailTouched
        && passwordTouched;
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await loginUseCase.loginCall(email, password);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.toString()));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      await loginUseCase.googleCall();
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.toString()));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signInWithGithub() async {
    emit(AuthLoading());
    try {
      await loginUseCase.githubCall();
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.toString()));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}