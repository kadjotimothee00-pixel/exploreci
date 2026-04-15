import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ParametresPage extends StatefulWidget {
  const ParametresPage({super.key});

  @override
  State<ParametresPage> createState() => _ParametresPageState();
}

class _ParametresPageState extends State<ParametresPage> {
  bool _notifications = true;
  bool _modeNuit = false;
  String _langue = "Français";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _modeNuit ? Colors.grey.shade900 : Colors.grey.shade100,
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

            // 🟢 Section Préférences
            _buildTitre("Préférences"),
            const SizedBox(height: 10),

            // Notifications
            _buildSwitch(
              icone: Icons.notifications,
              titre: "Notifications",
              sousTitre: "Recevoir les alertes",
              valeur: _notifications,
              onChanged: (val) => setState(() => _notifications = val),
            ),

            const SizedBox(height: 8),

            // Mode nuit 🌙
            _buildSwitch(
              icone: _modeNuit ? Icons.nightlight_round : Icons.wb_sunny,
              titre: "Mode nuit",
              sousTitre: _modeNuit ? "Mode sombre activé" : "Mode clair activé",
              valeur: _modeNuit,
              onChanged: (val) => setState(() => _modeNuit = val),
            ),

            const SizedBox(height: 20),

            // 🟢 Section Langue
            _buildTitre("Langue"),
            const SizedBox(height: 10),

            // Choix de langue
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _buildLangue("🇫🇷  Français"),
                  const Divider(height: 1),
                  _buildLangue("🇬🇧  English"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🟢 Section Compte
            _buildTitre("Compte"),
            const SizedBox(height: 10),

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
                title: Text(
                  _langue == "Français"
                      ? "Changer le mot de passe"
                      : "Change password",
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => _changerMotDePasse(context),
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
                title: Text(
                  _langue == "Français"
                      ? "À propos de ExploreCI"
                      : "About ExploreCI",
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("ExploreCI"),
                      content: Text(
                        _langue == "Français"
                            ? "ExploreCI est une application de découverte des sites touristiques de Côte d'Ivoire.\n\nVersion 1.0.0\nDéveloppé avec Flutter & Firebase"
                            : "ExploreCI is an app to discover tourist sites in Côte d'Ivoire.\n\nVersion 1.0.0\nBuilt with Flutter & Firebase",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            _langue == "Français" ? "Fermer" : "Close",
                          ),
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
                  _langue == "Français" ? "Se déconnecter" : "Sign out",
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

  // Widget titre section
  Widget _buildTitre(String titre) {
    return Text(
      titre,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: _modeNuit ? Colors.white70 : Colors.black54,
      ),
    );
  }

  // Widget switch
  Widget _buildSwitch({
    required IconData icone,
    required String titre,
    required String sousTitre,
    required bool valeur,
    required Function(bool) onChanged,
  }) {
    return Card(
      color: _modeNuit ? Colors.grey.shade800 : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SwitchListTile(
        secondary: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          child: Icon(icone, color: Colors.green.shade800),
        ),
        title: Text(
          titre,
          style: TextStyle(
            color: _modeNuit ? Colors.white : Colors.black87,
          ),
        ),
        subtitle: Text(
          sousTitre,
          style: TextStyle(
            color: _modeNuit ? Colors.white54 : Colors.black54,
          ),
        ),
        value: valeur,
        activeColor: Colors.green.shade800,
        onChanged: onChanged,
      ),
    );
  }

  // Widget choix langue
  Widget _buildLangue(String langue) {
    bool estSelectionnee = _langue == langue.replaceAll(RegExp(r'[^a-zA-Zéçàè ]+'), '').trim();
    return ListTile(
      title: Text(langue),
      trailing: estSelectionnee
          ? Icon(Icons.check, color: Colors.green.shade800)
          : null,
      onTap: () {
        setState(() {
          _langue = langue.contains("Français") ? "Français" : "English";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              langue.contains("Français")
                  ? "Langue changée en Français 🇫🇷"
                  : "Language changed to English 🇬🇧",
            ),
            backgroundColor: Colors.green.shade800,
            duration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }

  // Changer mot de passe
  void _changerMotDePasse(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          _langue == "Français" ? "Changer le mot de passe" : "Change password",
        ),
        content: TextField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            labelText: _langue == "Français"
                ? "Nouveau mot de passe"
                : "New password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(_langue == "Français" ? "Annuler" : "Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                await FirebaseAuth.instance.currentUser
                    ?.updatePassword(controller.text);
                if (!mounted) return;
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _langue == "Français"
                          ? "Mot de passe changé "
                          : "Password changed ",
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade800,
            ),
            child: Text(
              _langue == "Français" ? "Confirmer" : "Confirm",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}