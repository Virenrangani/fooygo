import 'dart:io';
import '../entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile();
  Future<String> uploadProfileImage(File image);
  Future<void> signOut();
  Future<void> deleteAccount();
}