import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/feature/auth/domain/usecase/sign_up_use_case.dart';
import '../../../../core/storage/shared_pref/shared_pref_service.dart';
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
      final user = await signUpUseCase.signUpCall(email, name, password);

      await SharedPrefService.saveUser(
        id: user.id,
        email: user.email,
        name: user.name ?? '',
      );

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.toString()));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}