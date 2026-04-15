import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavorisPage extends StatelessWidget {
  const FavorisPage({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
   bottomNavigationBar: BottomNavigationBar(
      selectedItemColor: Colors.green.shade800,
      unselectedItemColor: Colors.grey,
      currentIndex: 2,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
        BottomNavigationBarItem(icon: Icon(Icons.category), label: "Catégories"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favoris"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
      ],
      onTap: (index) {
        if (index == 0) Navigator.pushNamed(context, '/home');
        if (index == 1) Navigator.pushNamed(context, '/categories');
        if (index == 3) Navigator.pushNamed(context, '/profil');
       },
      ),
      body: SafeArea(
        child: Column(
          children: [
            // En-tête
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.green.shade800,
              child: const Text(
                "Mes Favoris ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Contenu
            Expanded(
              child: user == null
                  ? const Center(
                      child: Text("Connectez-vous pour voir vos favoris"),
                    )
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('utilisateurs')
                          .doc(user.uid)
                          .collection('favoris')
                          .snapshots(),
                      builder: (context, snapshot) {

                        // Chargement
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        // Aucun favori
                        if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.favorite_border,
                                    size: 80,
                                    color: Colors.grey.shade400),
                                const SizedBox(height: 16),
                                Text(
                                  "Aucun favori pour l'instant",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Explorez des sites et ajoutez-les\nà vos favoris !",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade500),
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton.icon(
                                  onPressed: () => Navigator.pushNamed(
                                      context, '/home'),
                                  icon: const Icon(Icons.explore,
                                      color: Colors.white),
                                  label: const Text(
                                    "Explorer les sites",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade800,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        // Liste des favoris
                        final favoris = snapshot.data!.docs;
                        return ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: favoris.length,
                          itemBuilder: (context, index) {
                            final data = favoris[index].data()
                                as Map<String, dynamic>;
                            final site = {
                              ...data,
                              "couleur": Color(data["couleur"]),
                            };
                            return _buildCarteFavori(
                              context,
                              site,
                              user.uid,
                              favoris[index].id,
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarteFavori(BuildContext context, Map<String, dynamic> site,
      String uid, String docId) {
    return Dismissible(
      key: Key(docId),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        // Supprimer de Firestore
        FirebaseFirestore.instance
            .collection('utilisateurs')
            .doc(uid)
            .collection('favoris')
            .doc(docId)
            .delete();
      },
      background: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete, color: Colors.white, size: 28),
            SizedBox(height: 4),
            Text("Supprimer",
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () =>
            Navigator.pushNamed(context, '/detail', arguments: site),
        child: Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: Column(
            children: [
              // Image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  site["image"],
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image_not_supported,
                          size: 40, color: Colors.grey),
                    );
                  },
                ),
              ),

              // Infos
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            site["nom"],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  size: 13,
                                  color: Colors.grey.shade500),
                              Text(
                                site["ville"],
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 12),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.star,
                                  size: 13, color: Colors.amber),
                              Text(" ${site["note"]}",
                                  style:
                                      const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.favorite,
                        color: Colors.red.shade400, size: 22),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}