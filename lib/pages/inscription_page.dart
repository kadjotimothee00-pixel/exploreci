import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _motDePasseController = TextEditingController();

  bool _motDePasseVisible = false;
  bool _chargement = false;

  Future<void> _inscrire() async {
    if (_nomController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _motDePasseController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Veuillez remplir tous les champs"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _chargement = true);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _motDePasseController.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection('utilisateurs')
          .doc(userCredential.user!.uid)
          .set({
        'nom': _nomController.text.trim(),
        'email': _emailController.text.trim(),
        'dateInscription': DateTime.now().toString(),
      });

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/home');

    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message = "";
      if (e.code == 'email-already-in-use') {
        message = "Cet email est déjà utilisé";
      } else if (e.code == 'weak-password') {
        message = "Mot de passe trop faible (6 caractères minimum)";
      } else if (e.code == 'invalid-email') {
        message = "Email invalide";
      } else {
        message = "Erreur : ${e.code}";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _chargement = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: const Text(
          "Inscription",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            const Text(
              "Créer un compte",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Rejoignez ExploreCI !",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 30),

            // Champ Nom
            TextField(
              controller: _nomController,
              decoration: InputDecoration(
                labelText: "Nom complet",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Champ Email
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Adresse email",
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Champ Mot de passe
            TextField(
              controller: _motDePasseController,
              obscureText: !_motDePasseVisible,
              decoration: InputDecoration(
                labelText: "Mot de passe",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _motDePasseVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() => _motDePasseVisible = !_motDePasseVisible);
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Bouton S'inscrire
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _chargement ? null : _inscrire,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade800,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _chargement
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "S'inscrire",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 16),

            // Lien vers connexion
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Déjà un compte ? ",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/connexion'),
                  child: Text(
                    "Se connecter",
                    style: TextStyle(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}