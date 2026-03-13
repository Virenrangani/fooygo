import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class SignupCubit extends Cubit<AuthState> {
  SignupCubit() : super(AuthInitial());

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user?.updateDisplayName(name);

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Registration failed"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}