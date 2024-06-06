import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAbLyVszlNb2gMg2_4Krf8T2AfQnyAINuw",
      appId: "1:384833772198:android:d09244d95daf0f05b23267",
      messagingSenderId: "384833772198",
      projectId: "weather-information-dashboard",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Set this to false

      title: 'WeatherApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
