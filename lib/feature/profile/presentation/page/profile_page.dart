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

class _ProfileViewState extends State<_ProfileView>
    with TickerProviderStateMixin {

  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;

  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(BuildContext context) async {

    final image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      _selectedImage = File(image.path);

      if (!mounted) return;

      context
          .read<ProfileCubit>()
          .uploadImage(_selectedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {

    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),

      body: BlocConsumer<ProfileCubit, ProfileState>(

        listener: (context, state) {

          if (state is ProfileSignedOut) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const Login(),
              ),
                  (_) => false,
            );
          }

          if (state is ProfileDeleted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const Signup(),
              ),
                  (_) => false,
            );
          }

          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                content: Text(state.message),
              ),
            );
          }

          if (state is ProfileImageUploaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.deepOrange,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                content: const Row(
                  children: [

                    Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),

                    SizedBox(width: 10),

                    Text(
                      "Profile updated successfully",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },

        builder: (context, state) {

          final profile = switch (state) {
            ProfileLoaded() => state.profile,
            ProfileImageUploading() => state.profile,
            ProfileImageUploaded() => state.profile,
            _ => null,
          };

          final isUploading =
          state is ProfileImageUploading;

          final isLoading =
          state is ProfileLoading;

          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.deepOrange,
              ),
            );
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [

              // ================= HEADER =================

              SliverAppBar(
                expandedHeight: sh * 0.38,
                pinned: true,
                elevation: 0,
                backgroundColor: Colors.black,

                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [

                      // GRADIENT BACKGROUND
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF111111),
                              Color(0xFF2A2A2A),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),

                      // GLOW EFFECT
                      Positioned(
                        top: -40,
                        right: -20,
                        child: Container(
                          width: sw * 0.55,
                          height: sw * 0.55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange
                                .withOpacity(0.12),
                          ),
                        ),
                      ),

                      // CONTENT
                      Positioned.fill(
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [

                            SizedBox(height: sh * 0.06),

                            // PROFILE IMAGE
                            AnimatedBuilder(
                              animation: _glowController,
                              builder: (context, child) {

                                return Container(
                                  padding: const EdgeInsets.all(5),

                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,

                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.orange
                                            .withOpacity(
                                          0.25 +
                                              (_glowController.value *
                                                  0.2),
                                        ),
                                        blurRadius:
                                        25 +
                                            (_glowController.value *
                                                18),
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),

                                  child: Hero(
                                    tag: "profile_image",

                                    child: Stack(
                                      children: [

                                        GestureDetector(
                                          onTap: () =>
                                              _pickImage(
                                                  context),

                                          child: isUploading
                                              ? Container(
                                            width:
                                            sw * 0.34,
                                            height:
                                            sw * 0.34,
                                            decoration:
                                            const BoxDecoration(
                                              shape:
                                              BoxShape.circle,
                                              color:
                                              Colors.white,
                                            ),
                                            child:
                                            const Center(
                                              child:
                                              CircularProgressIndicator(
                                                color:
                                                Colors.deepOrange,
                                              ),
                                            ),
                                          )
                                              : ProfileAvatar(
                                            profileUrl:
                                            profile?.profileUrl,
                                            selectedImage:
                                            _selectedImage,
                                            size:
                                            sw * 0.34,
                                            onTap: () =>
                                                _pickImage(
                                                    context),
                                          ),
                                        ),

                                        // CAMERA BUTTON
                                        Positioned(
                                          bottom: 0,
                                          right: 0,

                                          child: Container(
                                            padding:
                                            EdgeInsets.all(
                                              sw * 0.02,
                                            ),

                                            decoration:
                                            BoxDecoration(
                                              color: Colors
                                                  .deepOrange,
                                              shape: BoxShape
                                                  .circle,
                                              border: Border.all(
                                                color:
                                                Colors.white,
                                                width: 3,
                                              ),
                                            ),

                                            child: Icon(
                                              Icons.camera_alt,
                                              color:
                                              Colors.white,
                                              size:
                                              sw * 0.05,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                            SizedBox(height: sh * 0.02),

                            // NAME
                            TweenAnimationBuilder(
                              tween: Tween<double>(
                                begin: 0,
                                end: 1,
                              ),

                              duration: const Duration(
                                milliseconds: 900,
                              ),

                              curve: Curves.easeOut,

                              builder:
                                  (context, value, child) {

                                return Opacity(
                                  opacity: value,

                                  child: Transform.translate(
                                    offset: Offset(
                                      0,
                                      25 * (1 - value),
                                    ),

                                    child: child,
                                  ),
                                );
                              },

                              child: Column(
                                children: [

                                  Text(
                                    profile?.name ?? "",

                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                      sw * 0.07,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(
                                    height: sh * 0.008,
                                  ),

                                  Text(
                                    profile?.email ?? "",

                                    style: TextStyle(
                                      color:
                                      Colors.white70,
                                      fontSize:
                                      sw * 0.038,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ================= BODY =================

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(sw * 0.05),

                  child: Column(
                    children: [

                      // ACCOUNT SECTION
                      _buildSectionTitle(
                        title: "Account",
                        sw: sw,
                      ),

                      SizedBox(height: sh * 0.02),

                      _modernCard(
                        sw: sw,
                        icon: Icons.person_outline,
                        title: "Name",
                        subtitle: profile?.name ?? "",
                      ),

                      SizedBox(height: sh * 0.018),

                      _modernCard(
                        sw: sw,
                        icon: Icons.email_outlined,
                        title: "Email",
                        subtitle: profile?.email ?? "",
                      ),

                      SizedBox(height: sh * 0.018),

                      _modernCard(
                        sw: sw,
                        icon: Icons.description_outlined,
                        title: "Terms & Conditions",
                        subtitle: "View terms and privacy",
                      ),

                      SizedBox(height: sh * 0.04),

                      // ACTIONS
                      _buildSectionTitle(
                        title: "Actions",
                        sw: sw,
                      ),

                      SizedBox(height: sh * 0.02),

                      _actionCard(
                        sw: sw,
                        icon: Icons.logout,
                        title: "Logout",
                        color: Colors.black,
                        onTap: () {
                          _showConfirmDialog(
                            context: context,
                            title: "Logout",
                            message:
                            "Are you sure you want to logout?",
                            onConfirm: () {
                              context
                                  .read<ProfileCubit>()
                                  .signOut();
                            },
                          );
                        },
                      ),

                      SizedBox(height: sh * 0.018),

                      _actionCard(
                        sw: sw,
                        icon: Icons.delete_outline,
                        title: "Delete Account",
                        color: Colors.red,
                        onTap: () {
                          _showConfirmDialog(
                            context: context,
                            title: "Delete Account",
                            message:
                            "This action cannot be undone.",
                            onConfirm: () {
                              context
                                  .read<ProfileCubit>()
                                  .deleteAccount();
                            },
                          );
                        },
                      ),

                      SizedBox(height: sh * 0.05),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ================= SECTION TITLE =================

  Widget _buildSectionTitle({
    required String title,
    required double sw,
  }) {
    return Align(
      alignment: Alignment.centerLeft,

      child: Text(
        title,

        style: TextStyle(
          fontSize: sw * 0.05,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ================= MODERN CARD =================

  Widget _modernCard({
    required double sw,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {

    return Container(
      padding: EdgeInsets.all(sw * 0.045),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Row(
        children: [

          Container(
            padding: EdgeInsets.all(sw * 0.03),

            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(18),
            ),

            child: Icon(
              icon,
              color: Colors.deepOrange,
              size: sw * 0.06,
            ),
          ),

          SizedBox(width: sw * 0.04),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: sw * 0.035,
                  ),
                ),

                SizedBox(height: sw * 0.01),

                Text(
                  subtitle,

                  style: TextStyle(
                    fontSize: sw * 0.042,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          Icon(
            Icons.arrow_forward_ios,
            size: sw * 0.04,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  // ================= ACTION CARD =================

  Widget _actionCard({
    required double sw,
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,

      child: Ink(
        padding: EdgeInsets.all(sw * 0.045),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: Row(
          children: [

            Container(
              padding: EdgeInsets.all(sw * 0.03),

              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(18),
              ),

              child: Icon(
                icon,
                color: color,
                size: sw * 0.06,
              ),
            ),
            SizedBox(width: sw * 0.04),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: sw * 0.044, fontWeight: FontWeight.w600, color: color,),
              ),
            ),

            Icon(
              Icons.arrow_forward_ios, size: sw * 0.04, color: Colors.grey,
            ),
          ],
        ),
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
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),

          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold,),
          ),

          content: Text(message),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Cancel", style: TextStyle(color: Colors.grey,),),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                title == "Delete Account"
                    ? Colors.red
                    : Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14),),
              ),

              onPressed: () {
                Navigator.pop(context);onConfirm();
              },
              child: const Text("Confirm", style: TextStyle(color: Colors.white,),
              ),
            ),
          ],
        );
      },
    );
  }
}