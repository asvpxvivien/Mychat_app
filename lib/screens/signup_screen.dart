import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup")),
      body: Column(
        children: [
          TextField(decoration: InputDecoration(label: Text("Email"))),
          SizedBox(height: 20),
          TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(label: Text("Password")),
          ),
          SizedBox(height: 20),

          ElevatedButton(onPressed: () {}, child: Text("Create account")),
        ],
      ),
    );
  }
}
