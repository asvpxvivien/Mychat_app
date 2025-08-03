import 'package:flutter/material.dart';
import 'package:mychat/providers/userProvider.dart';
import 'package:mychat/screens/dashboard_screen.dart';
import 'package:mychat/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    // check for user login status..
    Future.delayed(Duration(seconds: 2), () {
      if (user == null) {
        openLogin();
      } else {
        openDashboard();
      }
    });
  }

  void openDashboard() async {
    await Provider.of<UserProvider>(context, listen: false).getUserDetails();
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
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: Image.asset("assets/images/logo.png"),
        ),
      ),
    );
  }
}
