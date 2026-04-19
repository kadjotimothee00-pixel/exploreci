import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParametresPage extends StatefulWidget {
  const ParametresPage({super.key});

  @override
  State<ParametresPage> createState() => _ParametresPageState();
}

class _ParametresPageState extends State<ParametresPage> {
  bool _notifications = true;
  String _langue = "Français";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: const Text(
          "Paramètres",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // Préférences
            _buildTitre("Préférences"),
            const SizedBox(height: 10),

            // Notifications
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SwitchListTile(
                secondary: CircleAvatar(
                  backgroundColor: Colors.green.shade100,
                  child: Icon(Icons.notifications,
                      color: Colors.green.shade800),
                ),
                title: const Text("Notifications"),
                subtitle: const Text("Recevoir les alertes"),
                value: _notifications,
                activeColor: Colors.green.shade800,
                onChanged: (val) => setState(() => _notifications = val),
              ),
            ),

            const SizedBox(height: 20),

            // Langue
            _buildTitre("Langue"),
            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text(" Français"),
                    trailing: _langue == "Français"
                        ? Icon(Icons.check, color: Colors.green.shade800)
                        : null,
                    onTap: () => setState(() => _langue = "Français"),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text(" English"),
                    trailing: _langue == "English"
                        ? Icon(Icons.check, color: Colors.green.shade800)
                        : null,
                    onTap: () {
                      setState(() => _langue = "English");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("BIENTÔT DISPONIBLE"),
                          backgroundColor: Colors.orange,
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Compte
            _buildTitre("Compte"),
            const SizedBox(height: 10),

            // Modifier le profil
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade100,
                  child: Icon(Icons.edit, color: Colors.green.shade800),
                ),
                title: const Text("Modifier le profil"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => _modifierProfil(context),
              ),
            ),

            const SizedBox(height: 8),

            // Changer mot de passe
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade100,
                  child: Icon(Icons.lock, color: Colors.green.shade800),
                ),
                title: const Text("Changer le mot de passe"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => _changerMotDePasse(context),
              ),
            ),

            const SizedBox(height: 20),

            // Support
            _buildTitre("Support"),
            const SizedBox(height: 10),

            // Nous contacter
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Icon(Icons.contact_support,
                      color: Colors.blue.shade800),
                ),
                title: const Text("Nous contacter"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => _nousContacter(context),
              ),
            ),

            const SizedBox(height: 8),

            // À propos
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade100,
                  child: Icon(Icons.info, color: Colors.green.shade800),
                ),
                title: const Text("À propos de ExploreCI"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("ExploreCI"),
                      content: const Text(
                        "ExploreCI est une application de découverte des sites touristiques de Côte d'Ivoire.\n\nVersion 1.0.0\nDéveloppé avec Flutter & Firebase",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Fermer"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // Déconnexion
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red.shade100,
                  child: Icon(Icons.logout, color: Colors.red.shade800),
                ),
                title: Text(
                  "Se déconnecter",
                  style: TextStyle(color: Colors.red.shade800),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  if (!mounted) return;
                  Navigator.of(context).pushReplacementNamed('/landing');
                },
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTitre(String titre) {
    return Text(
      titre,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      ),
    );
  }

  // Modifier le profil
  void _modifierProfil(BuildContext context) {
    final nomController = TextEditingController();
    final prenomController = TextEditingController();

    // Charger le nom actuel
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('utilisateurs')
          .doc(user.uid)
          .get()
          .then((doc) {
        if (doc.exists) {
          nomController.text = doc['nom'] ?? "";
        }
      });
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Modifier le profil",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Nom
            TextField(
              controller: nomController,
              decoration: InputDecoration(
                labelText: "Nom complet",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Bouton enregistrer
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (nomController.text.isNotEmpty && user != null) {
                    await FirebaseFirestore.instance
                        .collection('utilisateurs')
                        .doc(user.uid)
                        .update({'nom': nomController.text.trim()});

                    if (!mounted) return;
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Profil mis à jour ✅"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade800,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Enregistrer",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Nous contacter
  void _nousContacter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nous contacter",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Email
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Icon(Icons.email, color: Colors.blue.shade800),
                ),
                title: const Text("Email"),
                subtitle: const Text("exploreci@gmail.com"),
              ),
            ),

            const SizedBox(height: 8),

            // WhatsApp
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade100,
                  child: Icon(Icons.phone, color: Colors.green.shade800),
                ),
                title: const Text("WhatsApp"),
                subtitle: const Text("+225 0506067310"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Changer mot de passe
  void _changerMotDePasse(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Changer le mot de passe"),
        content: TextField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Nouveau mot de passe",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                await FirebaseAuth.instance.currentUser
                    ?.updatePassword(controller.text);
                if (!mounted) return;
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Mot de passe changé ✅"),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade800,
            ),
            child: const Text(
              "Confirmer",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}