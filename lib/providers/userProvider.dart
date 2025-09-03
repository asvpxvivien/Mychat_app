import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String userName = "Dummy Name";
  String userEmail = "Dummy Email";
  String userId = "Dummy userId";
  String? userAvatarUrl;

  var db = FirebaseFirestore.instance;

  Future<void> getUserDetails() async {
    var authUser = FirebaseAuth.instance.currentUser;
    if (authUser == null) return;

    try {
      var docSnapshot = await db.collection("users").doc(authUser.uid).get();

      if (docSnapshot.exists) {
        var data = docSnapshot.data();
        userName = data?["name"] ?? "";
        userEmail = data?["email"] ?? "";
        userAvatarUrl = data?["avatarUrl"] as String?;
        userId =
            docSnapshot.id; // 🔥 L’ID est ici, pas dans les champs Firestore
        notifyListeners();
      } else {
        print("Aucun utilisateur trouvé avec cet ID.");
      }
    } catch (e) {
      print("Erreur lors de la récupération des données utilisateur : $e");
    }
  }
}
