import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/feature/auth/presentation/pages/login.dart';
import 'package:foodygo/feature/auth/presentation/pages/signup.dart';
import 'package:foodygo/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:foodygo/feature/profile/presentation/cubit/profile_state.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import '../widget/profile_action_card.dart';
import '../widget/profile_avatar.dart';
import '../widget/profile_detail_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<ProfileCubit>()..loadProfile(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatefulWidget {
  const _ProfileView();

  @override
  State<_ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<_ProfileView> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImage(BuildContext context) async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _selectedImage = File(image.path);
      if (!mounted) return;
      context.read<ProfileCubit>().uploadImage(_selectedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSignedOut) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const Login()),
                  (_) => false,
            );
          } else if (state is ProfileDeleted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const Signup()),
                  (_) => false,
            );
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                content: Text(state.message),
              ),
            );
          } else if (state is ProfileImageUploaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.deepOrange,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                content: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Profile photo updated!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final profile = switch (state) {
            ProfileLoaded()         => state.profile,
            ProfileImageUploading() => state.profile,
            ProfileImageUploaded()  => state.profile,
            _                       => null,
          };

          final isUploading = state is ProfileImageUploading;
          final isLoading   = state is ProfileLoading;

          return isLoading
              ? const Center(
            child: CircularProgressIndicator(color: Colors.deepOrange),
          )
              : SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: sh * 0.22,
                      width: sw,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(sw, 80),
                        ),
                      ),
                    ),
                    Positioned(
                      top: sh * 0.07,
                      child: Text(
                        profile?.name ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: sw * 0.055,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      top: sh * 0.12,
                      child: isUploading
                          ? SizedBox(
                        height: sw * 0.35,
                        width: sw * 0.35,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.deepOrange,
                          ),
                        ),
                      )
                          : ProfileAvatar(
                        profileUrl: profile?.profileUrl,
                        selectedImage: _selectedImage,
                        size: sw * 0.35,
                        onTap: () => _pickImage(context),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sw * 0.22),

                ProfileDetailCard(
                  icon: Icons.person,
                  title: 'Name',
                  value: profile?.name ?? '',
                ),
                SizedBox(height: sh * 0.02),
                ProfileDetailCard(
                  icon: Icons.email,
                  title: 'Email',
                  value: profile?.email ?? '',
                ),
                SizedBox(height: sh * 0.02),
                ProfileDetailCard(
                  icon: Icons.description,
                  title: 'Terms and Conditions',
                  value: 'View Terms',
                ),
                SizedBox(height: sh * 0.02),

                ProfileActionCard(
                  icon: Icons.delete_outline,
                  title: 'Delete Account',
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: () => _showConfirmDialog(
                    context: context,
                    title: 'Delete Account',
                    message:
                    'Are you sure you want to delete your account? This cannot be undone.',
                    onConfirm: () =>
                        context.read<ProfileCubit>().deleteAccount(),
                  ),
                ),
                SizedBox(height: sh * 0.02),
                ProfileActionCard(
                  icon: Icons.logout,
                  title: 'Logout',
                  iconColor: Colors.black,
                  onTap: () => _showConfirmDialog(
                    context: context,
                    title: 'Logout',
                    message: 'Are you sure you want to logout?',
                    onConfirm: () =>
                        context.read<ProfileCubit>().signOut(),
                  ),
                ),
                SizedBox(height: sh * 0.04),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showConfirmDialog({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Text(
              'Confirm',
              style: TextStyle(
                color: title == 'Delete Account'
                    ? Colors.red
                    : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}