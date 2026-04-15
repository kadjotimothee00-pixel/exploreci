import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key});

  @override
  State<ConnexionPage> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _motDePasseController = TextEditingController();
  bool _motDePasseVisible = false;
  bool _chargement = false;

  Future<void> _connecter() async {
    if (_emailController.text.isEmpty || _motDePasseController.text.isEmpty) {
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _motDePasseController.text.trim(),
      );

      // Vérifier que le widget est toujours actif
      if (!mounted) return;

      // Aller à la Home Page
      Navigator.of(context).pushReplacementNamed('/home');

    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message = "";
      if (e.code == 'user-not-found') {
        message = "Aucun compte trouvé avec cet email";
      } else if (e.code == 'wrong-password') {
        message = "Mot de passe incorrect";
      } else if (e.code == 'invalid-credential') {
        message = "Email ou mot de passe incorrect";
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
          "Connexion",
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
              "Bon retour !",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Connectez-vous pour continuer",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),

            const SizedBox(height: 30),

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

            // Bouton Se connecter
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _chargement ? null : _connecter,
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
                        "Se connecter",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),

            const SizedBox(height: 16),

            // Lien inscription
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Pas de compte ? ",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/inscription'),
                  child: Text(
                    "S'inscrire",
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