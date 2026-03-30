import 'package:firebase_auth/firebase_auth.dart';

abstract class ForgetPassDataSource {
  Future<void> resetPassword(String email);
}

class ForgetPassDataSourceImpl implements ForgetPassDataSource {
  final FirebaseAuth firebaseAuth;
  ForgetPassDataSourceImpl(this.firebaseAuth);

  @override
  Future<void> resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}