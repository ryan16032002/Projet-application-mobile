import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../style/font.dart';
import '../style/spacings.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: kBackgroundColor, // Utilise la couleur de fond définie dans colors.dart
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                "assets/logo3.png",
                height: 100,
              ),
              const SizedBox(height: kVerticalPaddingL), // Utilise l'espacement vertical large
              // Message de bienvenue
              const Text(
                'Bienvenue sur Agora',
                style: kWelcomeTextStyle, // Utilise le style de texte pour le message de bienvenue
              ),
              const SizedBox(height: kVerticalPadding),
              const Text(
                'Accédez à une bibliothèque de synthèses',
                textAlign: TextAlign.center,
                style: kSubtitleTextStyle, // Utilise le style de texte pour le sous-titre
              ),
              const SizedBox(height: kVerticalPaddingL),
              // Bouton de Connexion
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text(
                  'Se connecter',
                  style: kBlackButtonTextStyle, // Applique le style de texte en noir
                ),
              ),
              const SizedBox(height: kVerticalPadding),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text(
                  'Créer un compte',
                  style: kBlackButtonTextStyle, // Applique le style de texte en noir
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
