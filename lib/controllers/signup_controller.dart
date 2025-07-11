import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mychat/screens/dashboard_screen.dart';

class SignupController {
  static Future<void> createAccount({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String country,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!context.mounted) return; //stop tout si le widget est monté

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
        (route) => false,
      );

      print("Account created successfully");
    } catch (e) {
      SnackBar messageSnackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(messageSnackBar);
      print(e);
    }
  }
}
