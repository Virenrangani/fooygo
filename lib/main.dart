import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodygo/di/injection.dart';
import 'package:foodygo/feature/admin_home_page/page/admin_home_page.dart';
import 'package:foodygo/feature/home/presentation/page/bottomnav.dart';
import 'package:foodygo/feature/home/presentation/page/homepage.dart';
import 'package:foodygo/feature/onboard_screen/page/onboard.dart';
import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Injection().configDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner:false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: OnboardingScreen()
    );
  }
}

