import 'package:flutter/material.dart';
import 'package:mychat/providers/userProvider.dart';
import 'package:mychat/screens/edit_profile_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData = {};

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("")),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  (userProvider.userAvatarUrl != null &&
                          userProvider.userAvatarUrl!.isNotEmpty)
                      ? NetworkImage(userProvider.userAvatarUrl!)
                      : null,
              child:
                  (userProvider.userAvatarUrl == null ||
                          userProvider.userAvatarUrl!.isEmpty)
                      ? Text(
                        userProvider.userName.isNotEmpty
                            ? userProvider.userName[0]
                            : "?",
                      )
                      : null,
            ),
            Text(userProvider.userName),
            SizedBox(height: 8),
            Text(
              userProvider.userName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(userProvider.userEmail),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return EditProfileScreen();
                    },
                  ),
                );
              },
              child: Text("Edit Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
