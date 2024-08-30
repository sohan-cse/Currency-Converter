import 'package:demo/features/app/splash_screen/splash_screen.dart';
import 'package:demo/features/user_auth/presentation/pages/home_page.dart';
import 'package:demo/features/user_auth/presentation/pages/login_page.dart';
import 'package:demo/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:demo/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


import 'firebase_options.dart';
 
Future<void> main() async {

    WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MaterialApp(
    routes: {
          "/home": (context) => HomePage(),
          "/login": (context) => LoginPage(),
          "/signup": (context) => SignUpPage()
          
        },
    debugShowCheckedModeBanner: false,
    home: SplashScreen(
      child: Center(child: LoginPage()),
    ),
  ));
}

