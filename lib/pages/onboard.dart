import 'package:flutter/material.dart';
import '../widget/builddot.dart';
import '../widget/contentpage.dart';
import 'button_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final int _numPages = 3;

  // Data for each onboarding page
  final List<Map<String, String>> _onboardingData = [
    {
      'image': 'assets/image/screen1.png',
      'title': 'Welcome to Our App!',
      'description': 'Discover amazing features and get started today!',
    },
    {
      'image': 'assets/image/screen2.png',
      'title': 'Explore New Possibilities',
      'description': 'Unlock a world of opportunities with our app.',},
    {
      'image': 'assets/image/screen3.png',
      'title': 'Get Started Now',
      'description': 'Join our community and start your journey!',
    },
  ];

  // Build page indicators
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
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _currentPage == _numPages - 1
                  ? ElevatedButton(
                onPressed: () {
                  // Navigate to the next screen (e.g., Home)
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                      builder: (context) =>
                  const ClickableButton()));
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                  ),
                ),
                child: const Text('Get Started',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Skip to the last page
                      _pageController.animateToPage(_numPages - 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    child: const Text('Skip',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black),),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Go to the next page
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    child: const Text('Next',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
                  ),
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


