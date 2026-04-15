import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String _nom = "";
  String _email = "";
  bool _chargement = true;

  @override
  void initState() {
    super.initState();
    _chargerProfil();
  }

  Future<void> _chargerProfil() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('utilisateurs')
            .doc(user.uid)
            .get();

        if (doc.exists) {
          setState(() {
            _nom = doc['nom'] ?? "";
            _email = doc['email'] ?? "";
          });
        }
      }
    } catch (e) {
      debugPrint("Erreur chargement profil : $e");
    } finally {
      if (mounted) setState(() => _chargement = false);
    }
  }

  Future<void> _deconnecter() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('/landing');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green.shade800,
        unselectedItemColor: Colors.grey,
        currentIndex: 3,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Catégories"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favoris"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, '/home');
          if (index == 1) Navigator.pushNamed(context, '/categories');
          if (index == 2) Navigator.pushNamed(context, '/favoris');
        },
      ),
      body: _chargement
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(child: _buildPageProfil()),
    );
  }

  Widget _buildPageProfil() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // En-tête
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            color: Colors.green.shade800,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.green.shade800,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _nom.isEmpty ? "Utilisateur" : _nom,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _email,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Mon compte",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 12),

                _buildOption(
                  Icons.favorite,
                  "Mes Favoris",
                  () => Navigator.pushNamed(context, '/favoris'),
                ),
                _buildOption(
                  Icons.settings,
                  "Paramètres",
                  () => Navigator.pushNamed(context, '/parametres'),
                ),
                _buildOption(
                  Icons.map,
                  "Carte des sites",
                  () => Navigator.pushNamed(context, '/carte'),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Autres",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 12),

                _buildOption(
                  Icons.logout,
                  "Se déconnecter",
                  () => _afficherConfirmation(context),
                  couleur: Colors.red,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildOption(IconData icone, String titre, VoidCallback onTap,
      {Color? couleur}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: (couleur ?? Colors.green.shade800).withOpacity(0.1),
          child: Icon(icone, color: couleur ?? Colors.green.shade800),
        ),
        title: Text(
          titre,
          style: TextStyle(color: couleur ?? Colors.black87),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _afficherConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Déconnexion"),
        content: const Text("Voulez-vous vraiment vous déconnecter ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _deconnecter();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text(
              "Déconnecter",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}