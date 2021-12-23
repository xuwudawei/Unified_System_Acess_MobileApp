// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:usa_app/screens/AccountRegistrationPages/documentScanningPage.dart';
import 'package:usa_app/screens/AccountRegistrationPages/register_account.dart';
import 'package:usa_app/screens/initialScreens/landing_page.dart';
import 'package:usa_app/screens/initialScreens/loading_screens.dart';
import 'package:usa_app/screens/initialScreens/splash_screen.dart';
import 'package:usa_app/screens/signInPage/sign_in_page.dart';
import 'package:usa_app/screens/verifyNumberScreen/verify_number_screen.dart';

class RouteGenerator {
  // ignore: missing_return
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final arg = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case '/loading':
        return MaterialPageRoute(
          builder: (_) => LoadingScreen(),
        );
      case '/landingPage':
        return MaterialPageRoute(
          builder: (_) => LandingPage(),
        );
      case '/landingPage/VerifyNumber':
        return MaterialPageRoute(
          builder: (_) => VerifyNumberPage(),
        );
      case '/signIn':
        return MaterialPageRoute(
          builder: (_) => SignInPage(),
        );
      case '/RegisterAccount':
        return MaterialPageRoute(
          builder: (_) => RegisterAccountPage(),
        );
      case '/Country/DocumentScanning':
        return MaterialPageRoute(
          builder: (_) => DocumentScanningPage(),
        );
    }
  }
}