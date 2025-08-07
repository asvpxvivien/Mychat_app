import 'package:flutter/material.dart';
import 'package:mychat/controllers/signup_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var userForm = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController country = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: userForm,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(label: Text("Email")),
                  ),
                  SizedBox(height: 23),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please your Password is required";
                      }
                      return null;
                    },

                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(label: Text("Password")),
                  ),
                  SizedBox(height: 23),

                  SizedBox(height: 23),

                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please your Name is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(label: Text("Name")),
                  ),
                  SizedBox(height: 23),

                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: country,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please your Country is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(label: Text("Country")),
                  ),
                  SizedBox(height: 23),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(0, 50),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepPurpleAccent,
                          ),
                          onPressed: () async {
                            if (userForm.currentState!.validate()) {
                              isLoading = true;
                              setState(() {});
                              //creating an account
                              await SignupController.createAccount(
                                context: context,
                                email: email.text,
                                password: password.text,
                                name: name.text,
                                country: country.text,
                              );
                            }
                            isLoading = false;
                            setState(() {});
                          },
                          child:
                              isLoading
                                  ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                  : Text("Create account"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
