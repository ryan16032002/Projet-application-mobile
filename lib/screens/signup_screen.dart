import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../style/font.dart';
import '../style/spacings.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Crée un utilisateur avec Firebase Auth
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        print("Utilisateur inscrit : ${userCredential.user!.email}");
        // Redirige vers un écran d'accueil ou de confirmation après inscription
        Navigator.pushReplacementNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        print("Code d'erreur Firebase: ${e.code}");
        print("Message d'erreur Firebase: ${e.message}");

        String message;
        if (e.code == 'weak-password') {
          message = 'Le mot de passe est trop faible.';
        } else if (e.code == 'email-already-in-use') {
          message = 'Cet email est déjà utilisé.';
        } else if (e.code == 'invalid-email') {
          message = 'L\'adresse email est invalide.';
        } else {
          message = 'Erreur Firebase : ${e.message}';
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
        title: const Text('Créer un compte', style: kTitleHome),
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
                  if (value.length < 6) {
                    return 'Le mot de passe doit contenir au moins 6 caractères';
                  }
                  return null;
                },
              ),
              const SizedBox(height: kVerticalPaddingL),
              ElevatedButton(
                onPressed: _signUp,
                child: const Text(
                  'Créer un compte',
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
