import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_string/random_string.dart';
import '../../../../core/storage/shared_pref/shared_pref_service.dart';
import '../../domain/entity/profile_entity.dart';

abstract class ProfileDataSource {
  Future<ProfileEntity> getProfile();
  Future<String> uploadProfileImage(File image);
  Future<void> signOut();
  Future<void> deleteAccount();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  ProfileDataSourceImpl(
     this.firebaseAuth,
     this.firebaseStorage,
  );

  @override
  Future<ProfileEntity> getProfile() async {
    final name    = await SharedPrefService.getUserName()  ?? '';
    final email   = await SharedPrefService.getUserEmail() ?? '';
    final profile = await SharedPrefService.getUserProfile();
    return ProfileEntity(name: name, email: email, profileUrl: profile);
  }

  @override
  Future<String> uploadProfileImage(File image) async {
    try {
      final String imageId = randomAlphaNumeric(10);
      final Reference ref = firebaseStorage
          .ref()
          .child('profileImages')
          .child(imageId);

      final UploadTask task = ref.putFile(image);
      final String downloadUrl = await (await task).ref.getDownloadURL();

      await SharedPrefService.saveUserProfile(downloadUrl);
      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
      await SharedPrefService.clearUser();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await firebaseAuth.currentUser?.delete();
      await SharedPrefService.clearUser();
    } catch (e) {
      rethrow;
    }
  }
}