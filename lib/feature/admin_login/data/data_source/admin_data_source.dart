import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AdminDataSource {
  Future<void> login(String id, String password);
}

class AdminDataSourceImpl implements AdminDataSource {
  final FirebaseFirestore firestore;
  AdminDataSourceImpl(this.firestore);

  @override
  Future<void> login(String id, String password) async {
    try {
      final snapshot = await firestore.collection('Admin').get();

      if (snapshot.docs.isEmpty) {
        throw Exception('Admin record not found.');
      }

      final data = snapshot.docs.first.data();

      if (data['id'] != id) {
        throw Exception('Provided username is wrong.');
      }

      if (data['password'] != password) {
        throw Exception('Provided password is wrong.');
      }

    } catch (e) {
      rethrow;
    }
  }
}