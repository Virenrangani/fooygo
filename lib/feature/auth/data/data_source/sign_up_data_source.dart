import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/constant/string/custom_string.dart';
import '../model/user_model.dart';

abstract class SignUpDataSource {
  Future<UserModel> signUp(String email,String name,String password);
}

class SignUpDataSourceImpl implements SignUpDataSource{
  final FirebaseAuth firebaseAuth;
  SignUpDataSourceImpl(this.firebaseAuth);

  @override
  Future<UserModel> signUp(String email, String name, String password) async{
    try{
      UserCredential credential=
          await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      final user= credential.user;

      if (user!=null && !user.emailVerified){
        await user.sendEmailVerification();
      }
      return UserModel.fromFirebase(user!);
    }catch(e){
      throw Exception(CustomString.somethingWentWrong);
    }
  }
}