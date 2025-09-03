import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
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
  XFile? pickedAvatar;
  bool isSaving = false;

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
      setState(() {
        isSaving = true;
      });

      String? newAvatarUrl;
      if (pickedAvatar != null) {
        final storageRef = FirebaseStorage.instance.ref().child(
          'avatars/$userId.jpg',
        );
        await storageRef.putFile(File(pickedAvatar!.path));
        newAvatarUrl = await storageRef.getDownloadURL();
      }

      final updateMap = <String, dynamic>{"name": newName};
      if (newAvatarUrl != null) {
        updateMap["avatarUrl"] = newAvatarUrl;
      }

      await db.collection("users").doc(userId).update(updateMap);

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
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
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
              const SizedBox(height: 8),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        pickedAvatar != null
                            ? FileImage(File(pickedAvatar!.path))
                            : (userProvider.userAvatarUrl != null &&
                                userProvider.userAvatarUrl!.isNotEmpty)
                            ? NetworkImage(userProvider.userAvatarUrl!)
                                as ImageProvider
                            : null,
                    child:
                        (userProvider.userAvatarUrl == null ||
                                    userProvider.userAvatarUrl!.isEmpty) &&
                                pickedAvatar == null
                            ? Text(
                              userProvider.userName.isNotEmpty
                                  ? userProvider.userName[0]
                                  : "?",
                            )
                            : null,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt),
                      onPressed: () async {
                        final picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 80,
                        );
                        if (image != null) {
                          setState(() {
                            pickedAvatar = image;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
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
              const SizedBox(height: 16),
              if (isSaving) const LinearProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
