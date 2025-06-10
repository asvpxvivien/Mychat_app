import 'package:flutter/material.dart';
import 'package:mychat/screens/dashboard_screen.dart';
import 'package:mychat/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // check for user login status..
    Future.delayed(Duration(seconds: 5), () {
      openLogin();
    });
    // TODO: implement initState
    super.initState();
  }

  void openDashboard() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DashboardScreen();
        },
      ),
    );
  }

  void openLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Splash Screen")));
  }
}
