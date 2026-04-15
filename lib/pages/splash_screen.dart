import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _verifierConnexion();
  }

  Future<void> _verifierConnexion() async {
    // Attendre 3 secondes
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // Vérifier si l'utilisateur est déjà connecté
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Déjà connecté → aller directement au Home
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      // Pas connecté → aller à la Landing Page
      Navigator.of(context).pushReplacementNamed('/landing');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.green.shade800,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.explore,
              size: 100,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            const Text(
              "ExploreCI",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Découvrez la Côte d'Ivoire",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}