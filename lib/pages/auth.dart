import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import '../widget/service.dart';
import '../widget/sharedpref.dart';
import 'bottomnav.dart';

class Auth {

  Future<void> SignUp({
    required String email,
    required String pass,
    required String name,
    required BuildContext context,
  }) async
  {
    try {
      await FirebaseAuth.instance.
      createUserWithEmailAndPassword(email: email, password: pass);
      String Id=randomAlphaNumeric(10);
      Map<String,dynamic> addUserInfo={
        'name':name,
        'email':email,
        'wallet':"0",
        'Id':Id,
      };
      await dataBase().userDetails(addUserInfo, Id);
      await sharedPrefHelper().saveUserName(name);
      await sharedPrefHelper().saveUserEmail(email);
      await sharedPrefHelper().saveWalletId('0');
      await sharedPrefHelper().saveUserId(Id);
      Navigator.pushReplacement(context, MaterialPageRoute
        (builder: (context) =>BottomNav(),));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar
        (content:Text('REGISTATION IS SUCCESSFULLY',style:TextStyle
        (fontSize:25,fontWeight:FontWeight.bold),)));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar
          (content:Text('provided password is weak')));
      } else
      if (e.code == 'email already used') {
        ScaffoldMessenger.of(context).showSnackBar
          (SnackBar(content:Text("email is already exist")));
      }
    }
  }
  Future<void> Signin({
    required String email,
    required String pass,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      Navigator.pushReplacement(
       context,
        MaterialPageRoute(builder: (context) => BottomNav()),
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar
        (content:Text('REGISTATION IS SUCCESSFULLY',style:TextStyle
        (fontSize:25,fontWeight:FontWeight.bold),)));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Provided password is wrong')),
        );
      } else if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please signup first')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong')),
        );
      }
    }
  }
}
