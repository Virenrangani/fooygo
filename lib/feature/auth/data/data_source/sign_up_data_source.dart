import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/constant/string/custom_string.dart';
import '../model/user_model.dart';

abstract class SignUpDataSource {
  Future<UserModel> signUp(String email, String name, String password);
}

class SignUpDataSourceImpl implements SignUpDataSource {
  final FirebaseAuth firebaseAuth;
  SignUpDataSourceImpl(this.firebaseAuth);

  @override
  Future<UserModel> signUp(String email, String name, String password) async {
    try {
      UserCredential credential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = credential.user;
      if (user == null) throw Exception(CustomString.somethingWentWrong);

      await user.updateDisplayName(name);
      await user.reload();

      await user.sendEmailVerification();

      return UserModel.fromFirebase(firebaseAuth.currentUser!);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception(CustomString.somethingWentWrong);
    }
  }
}