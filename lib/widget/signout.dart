import 'package:firebase_auth/firebase_auth.dart';

class AuthData{
  final FirebaseAuth auth=FirebaseAuth.instance;
  getCurrentUser()async{
    return auth.currentUser;
  }

  Future signOut()async{
    await FirebaseAuth.instance.signOut();
  }

  Future delete()async{
    User? user=await FirebaseAuth.instance.currentUser;
    user?.delete();

  }
}