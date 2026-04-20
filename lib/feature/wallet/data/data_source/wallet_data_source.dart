import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/storage/shared_pref/shared_pref_service.dart';

abstract class WalletDataSource {
  Future<int> getWalletBalance(String userId);
  Future<void> updateWalletBalance(String userId, int balance);
}

class WalletDataSourceImpl implements WalletDataSource {
  final FirebaseFirestore firestore;
  WalletDataSourceImpl(this.firestore);

  @override
  Future<int> getWalletBalance(String userId) async {
    try {
      final doc =
      await firestore.collection('user').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        return doc.get('wallet') ?? 0;
      }final saved = await SharedPrefService.getWalletBalance();
      return saved;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateWalletBalance(String userId, int balance) async {
    try {
      await Future.wait([
        firestore
            .collection('user')
            .doc(userId)
            .update({'wallet': balance}),
        SharedPrefService.saveWalletBalance(balance),
      ]);
    } catch (e) {
      rethrow;
    }
  }
}