import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/feature/profile/domain/entity/profile_entity.dart';
import 'package:foodygo/feature/profile/domain/use_case/profile_use_case.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUseCase profileUseCase;

  ProfileCubit( this.profileUseCase) : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await profileUseCase.callProfile();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> uploadImage(File image) async {
    final current = state;
    if (current is! ProfileLoaded) return;

    emit(ProfileImageUploading(current.profile));
    try {
      final url = await profileUseCase.callImageUpload(image);
      final updated = ProfileEntity(
        name: current.profile.name,
        email: current.profile.email,
        profileUrl: url,
      );
      emit(ProfileImageUploaded(updated));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      await profileUseCase.callSignOut();
      emit(ProfileSignedOut());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    try {
      await profileUseCase.callDelete();
      emit(ProfileDeleted());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}