import 'package:cloud_firestore/cloud_firestore.dart';

class dataBase {
  Future userDetails(Map<String, dynamic> userInfoMap, String Id) async {
    return await FirebaseFirestore.instance.collection('user').doc(Id).set(
        userInfoMap);
  }

  Future addFoodItem(Map<String, dynamic>userInfoMap, String id) async {
    return await FirebaseFirestore.instance.collection('user').doc(id).set(
        userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getFoodItem(String name) async {
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

  Future addFoodCart(Map<String, dynamic> userInfoMap, String Id) async {
    return await FirebaseFirestore.instance.collection('user')
        .doc(Id).collection('cart')
        .add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getFoodCart(String id) async {
    return await FirebaseFirestore.instance.collection('user')
        .doc(id)
        .collection('cart')
        .snapshots();
  }
  Future updateWalletBalance(String id, int balance) async {
    return await FirebaseFirestore.instance.collection('user').doc(id).update({'wallet': balance});
  }
}