import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/constant/string/custom_string.dart';
import '../../../../core/storage/shared_pref/shared_pref_service.dart';
import '../model/user_model.dart';

abstract class LoginDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithGithub();
}

class LoginDataSourceImpl implements LoginDataSource {
  final FirebaseAuth firebaseAuth;
  LoginDataSourceImpl(this.firebaseAuth);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user!;

      if (!user.emailVerified) {
        await firebaseAuth.signOut();
        throw Exception(CustomString.userNotVerify);
      }

      await SharedPrefService.saveUser(
        id: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? '',
      );

      return UserModel.fromFirebase(user);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) throw Exception(CustomString.googleSignInFailed);

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user == null) throw Exception(CustomString.userNotFound);

      await SharedPrefService.saveUser(
        id: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? '',
      );

      return UserModel.fromFirebase(user);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signInWithGithub() async {
    try {
      final GithubAuthProvider githubProvider = GithubAuthProvider();
      final UserCredential userCredential =
      await firebaseAuth.signInWithProvider(githubProvider);

      final user = userCredential.user;
      if (user == null) throw Exception(CustomString.userNotCreated);

      await SharedPrefService.saveUser(
        id: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? '',
      );

      return UserModel.fromFirebase(user);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}