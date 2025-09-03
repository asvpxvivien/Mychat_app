import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mychat/providers/userProvider.dart';
import 'package:mychat/screens/chatroom_screen.dart';
import 'package:mychat/screens/profile_screen.dart';
import 'package:mychat/screens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var user = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;
  var scoffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> chatroomsList = [];
  List<String> chatroomsIds = [];

  void getChatrooms() {
    db.collection("chatrooms").get().then((dataSnapshot) {
      for (var singleChatroomData in dataSnapshot.docs) {
        chatroomsList.add(singleChatroomData.data());
        chatroomsIds.add(singleChatroomData.id.toString());
      }

      setState(() {});
    });
  }

  @override
  void initState() {
    getChatrooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      key: scoffoldKey,
      appBar: AppBar(
        title: Text("Global Chat"),
        leading: InkWell(
          onTap: () {
            scoffoldKey.currentState!.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: CircleAvatar(
              radius: 20,
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
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 50),
              ListTile(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },

                leading: CircleAvatar(
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
                title: Text(
                  userProvider.userName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                subtitle: Text(userProvider.userEmail),
              ),
              ListTile(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },

                leading: Icon(Icons.people),
                title: Text("Profile"),
              ),

              ListTile(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SplashScreen()),
                    (route) => false,
                  );
                },

                leading: Icon(Icons.logout),
                title: Text("Logout"),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: chatroomsList.length,
        itemBuilder: (BuildContext context, int index) {
          String chatroomName = chatroomsList[index]["chatroom_name"] ?? "";

          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ChatroomScreen(
                        chatroomName: chatroomName,
                        chatroomId: chatroomsIds[index],
                      ),
                ),
              );
            },
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey[900],
              child: Text(
                chatroomName.isNotEmpty ? chatroomName[0] : "?",
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text(chatroomName),

            subtitle: Text(chatroomsList[index]["desc"] ?? ""),
          );
        },
      ),
    );
  }
}
