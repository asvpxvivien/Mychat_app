import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mychat/controllers/signup_controller.dart';
import 'package:mychat/screens/dashboard_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var userForm = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup")),
      body: Form(
        key: userForm,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                },
                decoration: InputDecoration(label: Text("Email")),
              ),
              SizedBox(height: 23),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                },

                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(label: Text("Password")),
              ),
              SizedBox(height: 23),

              ElevatedButton(
                onPressed: () {
                  if (userForm.currentState!.validate()) {
                    //creating an account
                    SignupController.createAccount(
                      context: context,
                      email: email.text,
                      password: password.text,
                    );
                  }
                },
                child: Text("Create account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
