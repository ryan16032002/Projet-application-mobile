import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../style/font.dart';
import '../style/spacings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Connexion avec Firebase Auth
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        print("Utilisateur connecté : ${userCredential.user!.email}");
        // Rediriger vers l'écran d'accueil après connexion
        Navigator.pushReplacementNamed(context, '/accueil');
      } on FirebaseAuthException catch (e) {
        // Gérer les erreurs spécifiques de Firebase
        String message;
        if (e.code == 'user-not-found') {
          message = 'Utilisateur non trouvé.';
        } else if (e.code == 'wrong-password') {
          message = 'Mot de passe incorrect.';
        } else {
          message = 'Une erreur est survenue. Veuillez réessayer.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion', style: kTitleHome),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPaddingL),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: kVerticalPadding),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre mot de passe';
                  }
                  return null;
                },
              ),
              const SizedBox(height: kVerticalPaddingL),
              ElevatedButton(
                onPressed: _login,
                child: const Text(
                  'Se connecter',
                  style: kBlackButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
