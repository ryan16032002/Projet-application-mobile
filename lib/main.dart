import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/homescreen.dart';
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/accueil_screen.dart';
import 'screens/Publishscreen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDimcX6IwTEVCGsWv2u73rih5Fhj9EYdMA",
        authDomain: "monappagora.firebaseapp.com",
        projectId: "monappagora",
        storageBucket: "monappagora.appspot.com",
        messagingSenderId: "333075960260",
        appId: "1:333075960260:web:e55ab52d3cc58a24055491",
        measurementId: "G-7MEPE73KRK",
      ),
    );
    print("Firebase initialisé avec succès");
  } catch (e) {
    print("Erreur d'initialisation de Firebase: $e");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/signup': (context) => const SignupScreen(),
        '/login': (context) => const LoginScreen(),
        '/accueil': (context) => const AccueilScreen(),
        '/publish': (context) => const PublishScreen(),
        '/explore': (context) => Placeholder(), // Remplace par ton écran de consultation
      },


    );
  }
}
