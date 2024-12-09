import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../style/font.dart';
import '../style/spacings.dart';

import '../style/colors.dart';

class AccueilScreen extends StatelessWidget {
  const AccueilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Agora', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(kHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Message de bienvenue
            Text(
              'Bienvenue, ${user?.email ?? "Utilisateur"}!',
              style: kTitleHome,
            ),
            const SizedBox(height: kVerticalPadding),

            // Boutons de navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAccentColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/publish');
                  },
                  icon: const Icon(Icons.edit, color: Colors.black),
                  label: Text(
                    'Publier une Synthèse',
                    style: kBlackButtonTextStyle,
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAccentColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/explore');
                  },
                  icon: const Icon(Icons.search, color: Colors.black),
                  label: Text(
                    'Consulter les Synthèses',
                    style: kBlackButtonTextStyle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: kVerticalPadding),

            // Section des synthèses populaires
            Text(
              'Synthèses populaires',
              style: kSectionTitle,
            ),
            Divider(
              color: kPrimaryColor,
              thickness: 1.5,
              height: kVerticalPadding,
            ),

            // Grille pour les synthèses populaires
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kVerticalPadding,
                  crossAxisSpacing: kHorizontalPadding,
                  childAspectRatio: 0.8,
                ),
                itemCount: 6, // Par exemple, les 6 synthèses populaires
                itemBuilder: (context, index) {
                  return Card(
                    color: kSecondaryColor.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        // Action lors du clic sur une synthèse
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.description, size: 50, color: kAccentColor),
                              ),
                            ),
                            const SizedBox(height: kVerticalPaddingS),
                            Text(
                              'Titre de la synthèse $index',
                              style: kTextTabItem,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Domaine, Niveau',
                              style: kSmallTextBlack,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
