import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mychat/screens/splash_screen.dart';

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

      var userId = FirebaseAuth.instance.currentUser!.uid;

      var db = FirebaseFirestore.instance;
      Map<String, dynamic> data = {
        "name": name,
        "country": country,
        "email": email,
        "Id": userId.toString(),
      };

      try {
        await db.collection("users").doc(userId.toString()).set(data);
      } catch (e) {
        print(e);
      }

      if (!context.mounted) return; //stop tout si le widget est monté

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
        (route) => false,
      );

      print("Account created successfully");
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(e.toString())),
      );
      print(e);
    }
  }
}
