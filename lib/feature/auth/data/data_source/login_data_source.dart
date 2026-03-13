import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/constant/string/custom_string.dart';
import '../model/user_model.dart';


abstract class LoginDataSource{
  Future<UserModel> login(String email,String password);

  Future<UserModel> signInWithGoogle();

  Future<UserModel> signInWithGithub();
}

class LoginDataSourceImpl implements LoginDataSource {
  final FirebaseAuth firebaseAuth;

  LoginDataSourceImpl(this.firebaseAuth);

  @override
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user=result.user!;

      if(!user.emailVerified){
        throw Exception(CustomString.userNotVerify);
      }
      return UserModel.fromFirebase(user);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }


  @override
  Future<UserModel> signInWithGoogle() async{
    await Future.delayed(Duration(seconds: 1));
    await GoogleSignIn().signOut();
    final googleUser=await GoogleSignIn().signIn();

    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential=await firebaseAuth.signInWithCredential(credential);

    final user=userCredential.user;
    if(user == null){
      throw Exception(CustomString.userNotFound);
    }
    return UserModel.fromFirebase(userCredential.user!);
  }


  @override
  Future<UserModel> signInWithGithub()async {

    GithubAuthProvider githubProvider=GithubAuthProvider();

    final UserCredential credential=await firebaseAuth
        .signInWithProvider(githubProvider);

    final user=credential.user;

    if (user==null){
      throw Exception(CustomString.userNotCreated);
    }
    return UserModel.fromFirebase(user);
  }

}
