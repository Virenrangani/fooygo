import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_case/forget_pass_use_case.dart';
import 'forget_pass_state.dart';

class ForgetPassCubit extends Cubit<ForgetPassState> {
  final ForgetPassUseCase forgetPassUseCase;
  ForgetPassCubit(this.forgetPassUseCase) : super(ForgetPassInitial());

  Future<void> resetPassword(String email) async {
    emit(ForgetPassLoading());
    try {
      await forgetPassUseCase.resetPasswordCall(email);
      emit(ForgetPassSuccess());
    } on FirebaseAuthException catch (e) {
      emit(ForgetPassFailure(e.toString()));
    } catch (e) {
      emit(ForgetPassFailure(e.toString()));
    }
  }
}