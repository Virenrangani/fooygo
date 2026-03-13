import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class LoginCubit extends Cubit<AuthState> {
  LoginCubit() : super(AuthInitial());

  Future<void> login({required String email, required String password,}) async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "An error occurred"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}