import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mychat/providers/userProvider.dart';
import 'package:mychat/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final alreadyInitialized = Firebase.apps.any(
      (app) => app.name == '[DEFAULT]',
    );
    if (!alreadyInitialized) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
      print("⚠️ Firebase app '[DEFAULT]' already initialized. Skipping.");
    } else {
      rethrow;
    }
  }

  // FCM minimal: demande permission et récupère le token
  try {
    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  } catch (_) {}

  runApp(
    ChangeNotifierProvider(create: (context) => UserProvider(), child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.light,
        ),
        fontFamily: "Poppins",
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.dark,
        ),
        fontFamily: "Poppins",
      ),
    );
  }
}
