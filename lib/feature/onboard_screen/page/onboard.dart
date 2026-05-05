import 'package:flutter/material.dart';
import 'package:foodygo/core/constant/image/app_image/app_image.dart';
import 'package:foodygo/core/constant/padding/custom_padding.dart';
import 'package:foodygo/core/constant/string/custom_string.dart';
import 'package:foodygo/core/widget/elevated_button/custom_elevated_button.dart';
import '../slide_button_screen/slide_button_page.dart';
import '../widget/build_dot.dart';
import '../widget/content_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final int _numPages = 3;

  final List<Map<String, String>> _onboardingData = [
    {
      'image': AppImage.onBoarding1,
      'title': CustomString.welcomeTitle,
      'description': CustomString.welcomeDesc,
    },
    {
      'image': AppImage.onBoarding2,
      'title': CustomString.exploreTitle,
      'description': CustomString.exploreDesc,
    },
    {
      'image': AppImage.onBoarding3,
      'title': CustomString.getStartedTitle,
      'description': CustomString.getStartedDesc,
    },
  ];

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(BuildDot(isActive: i == _currentPage));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: PageView.builder(
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _numPages,
                itemBuilder: (context, index) {
                  return ContentPage(
                    image: _onboardingData[index]['image']!,
                    title: _onboardingData[index]['title']!,
                    description: _onboardingData[index]['description']!,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  );
                },
              ),
            ),
            Padding(
              padding: CustomPadding.edgeAll12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _currentPage == _numPages - 1 ?
                  CustomElevatedButton(text: CustomString.getStarted, onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context)=>ClickableButton())
                    );
                  })
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomElevatedButton(
                      text: CustomString.skip,
                      onPressed: (){
                    _pageController.animateToPage(_numPages - 1,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease);
                  }),
                  CustomElevatedButton(
                      text: CustomString.next,
                      onPressed: (){
                    _pageController.nextPage(duration: Duration(milliseconds: 500),
                        curve: Curves.ease);
                  }),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


