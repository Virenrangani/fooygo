import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodygo/feature/auth/presentation/pages/signup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import '../widget/sharedpref.dart';
import '../widget/signout.dart';
import '../feature/auth/presentation/pages/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? profile, name, email;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  bool _isLoading = false;
  Future getImage() async {
    setState(() {
      _isLoading = true;
    });
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      await uploadItem();
    }
    setState(() {
      _isLoading = false;
    });
  }

  uploadItem() async {
    if (selectedImage != null) {
      String addId = randomAlphaNumeric(10);

      Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();
      await sharedPrefHelper().saveUserProfile(downloadUrl);
      await getthesharedpref();
    }
  }

  getthesharedpref() async {
    profile = await sharedPrefHelper().getUserProfile();
    name = await sharedPrefHelper().getUserName();
    email = await sharedPrefHelper().getUserEmail();
    setState(() {});
  }

  onthisload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    onthisload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center, // Center Stack children
              children: [
                Container(
                  padding: EdgeInsets.only(top: screenHeight * 0.06, left: screenWidth * 0.05, right: screenWidth * 0.05), // Responsive padding
                  height: screenHeight / 4.3,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              screenWidth, 105.0))),
                ),
                Positioned(
                  top: screenHeight * 0.08,
                  child: Material(
                    elevation: 10.0,
                    borderRadius: BorderRadius.circular(75),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: GestureDetector(
                        onTap: (){
                          getImage();
                        },
                        child: selectedImage==null?
                        profile==null? Image.asset("assets/image/boy.jpeg",
                          height: screenWidth * 0.35, width: screenWidth * 0.35, fit: BoxFit.cover,)
                            :Image.network(
                          profile!,
                          height: screenWidth * 0.35,
                          width: screenWidth * 0.35,
                          fit: BoxFit.cover,
                        ) : Image.file(selectedImage!,
                          height: screenWidth * 0.35, // Responsive image size
                          width: screenWidth * 0.35, // Responsive image size
                          fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                ),
                Positioned( // Positioned for Name Text
                  top: screenHeight * 0.035, // Responsive top position
                  child: Text(
                    name ?? "Loading...", // Fallback to "Loading..." if name is null
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 24.0 : 28.0, // Responsive font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.025,
            ),
            _buildProfileDetailCard( // Pass screenHeight and screenWidth
              icon: Icons.person,
              title: "Name",
              value: name ?? "Loading...",
              isSmallScreen: isSmallScreen,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            _buildProfileDetailCard( // Pass screenHeight and screenWidth
              icon: Icons.email,
              title: "Email",
              value: email ?? "Loading...",
              isSmallScreen: isSmallScreen,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            _buildProfileDetailCard( // Pass screenHeight and screenWidth
              icon: Icons.description,
              title: "Terms and Condition",
              value: "View Terms", // You can replace with actual terms if needed
              isSmallScreen: isSmallScreen,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            _buildActionCard( // Pass screenHeight and screenWidth
              icon: Icons.delete,
              title: "Delete Account",
              onTap: () {
                AuthData().delete();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context)=>Signup()),
                        (route)=>false
                );
              },
              isSmallScreen: isSmallScreen,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            _buildActionCard(
              icon: Icons.logout,
              title: "LogOut",
              onTap: () {
                AuthData().signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context)=>Login()),
                        (route)=>false
                );
              },
              isSmallScreen: isSmallScreen,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetailCard({
    required IconData icon,
    required String title,
    required String value,
    required bool isSmallScreen,
    required double screenWidth,
    required double screenHeight,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
            horizontal: screenWidth * 0.025,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black,
                size: isSmallScreen ? 24 : 28,
              ),
              SizedBox(
                width: screenWidth * 0.05,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: isSmallScreen ? 14.0 : 16.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: isSmallScreen ? 14.0 : 16.0,
                        fontWeight: FontWeight.w600),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isSmallScreen,
    required double screenWidth,
    required double screenHeight, // Added screenHeight parameter
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Responsive margin
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 2.0,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02, // Responsive vertical padding
              horizontal: screenWidth * 0.025, // Responsive horizontal padding
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.black,
                  size: isSmallScreen ? 24 : 28, // Responsive icon size
                ),
                SizedBox(
                  width: screenWidth * 0.05,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: isSmallScreen ? 16.0 : 20.0, // Responsive font size
                          fontWeight: FontWeight.w600),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}