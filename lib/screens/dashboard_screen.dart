import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mychat/screens/profile_screen.dart';
import 'package:mychat/screens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var user = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;

  List<Map<String, dynamic>> chatroomsList = [];

  void getChatrooms() {
    db.collection("chatrooms").get().then((dataSnapshot) {
      for (var singleChatroomData in dataSnapshot.docs) {
        chatroomsList.add(singleChatroomData.data());
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
    return Scaffold(
      appBar: AppBar(title: Text("Global Chat")),
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

                leading: Icon(Icons.people),
                title: Text("Profile"),
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
            leading: CircleAvatar(child: Text(chatroomName[0])),
            title: Text(chatroomName),

            subtitle: Text(chatroomsList[index]["desc"] ?? ""),
          );
        },
      ),
    );
  }
}
