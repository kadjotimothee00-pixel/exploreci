import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // En-tête
            Container(
              width: double.infinity,
              height: 350,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Image.asset(
                  'assets/images/symbole.png',
                  width: 200,
                  height: 200,
                    ),
                    const SizedBox(height: 16),
                  const Text(
                    "ExploreCI",
                    style: TextStyle(
                      color: Color.fromARGB(255, 48, 158, 52),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Découvrez les merveilles\nde la Côte d'Ivoire",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Fonctionnalités
            const Text(
              "Pourquoi ExploreCI ?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            _buildFeature(Icons.map, "Carte Interactive",
                "Trouvez les sites touristiques près de vous"),
            _buildFeature(Icons.photo_library, "Photos & Détails",
                "Découvrez chaque site en images"),
            _buildFeature(
                Icons.favorite, "Favoris", "Sauvegardez vos sites préférés"),

            const SizedBox(height: 30),

            // Boutons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Bouton Créer un compte
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/inscription'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade800,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Créer un compte",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Bouton Se connecter
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/connexion'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(color: Colors.green.shade800),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Se connecter",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green.shade800,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Bouton mode visiteur
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/home'),
                    child: Text(
                      "Continuer sans compte →",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icone, String titre, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.green.shade100,
            child: Icon(icone, color: const Color.fromARGB(255, 46, 125, 59)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titre,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(description,
                    style: TextStyle(
                        color: Colors.grey.shade600, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}