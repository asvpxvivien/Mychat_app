import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mychat/providers/userProvider.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final TextEditingController nameText = TextEditingController();
  final GlobalKey<FormState> editProfileForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Récupérer le nom après que le widget soit monté
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      nameText.text = userProvider.userName;
    });
  }

  void updateData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null || userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur : utilisateur non connecté.")),
      );
      return;
    }

    final newName = nameText.text.trim();

    if (newName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Le nom ne peut pas être vide.")),
      );
      return;
    }

    try {
      await db.collection("users").doc(userId).update({"name": newName});

      // Met à jour localement les infos utilisateur
      await Provider.of<UserProvider>(context, listen: false).getUserDetails();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nom mis à jour avec succès.")),
      );

      Navigator.pop(context); // Revenir à l'écran précédent
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de la mise à jour : $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          InkWell(
            onTap: () {
              if (editProfileForm.currentState!.validate()) {
                updateData();
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.check),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: editProfileForm,
          child: Column(
            children: [
              TextFormField(
                controller: nameText,
                decoration: const InputDecoration(labelText: "Name"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
