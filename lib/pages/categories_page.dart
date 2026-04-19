import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  static const List<Map<String, dynamic>> tousLesSites = [
    {
      "nom": "Basilique Notre-Dame de la Paix",
      "ville": "Yamoussoukro",
      "categorie": "Monument",
      "note": 4.8,
      "couleur": Colors.orange,
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6xPW1sgBEqm5CjR4FQiwqkM_7E9FcwsAYkA&s",
    },
    {
      "nom": "Parc National de Taï",
      "ville": "Sud-Ouest",
      "categorie": "Nature",
      "note": 4.6,
      "couleur": Colors.green,
      "image": "https://upload.wikimedia.org/wikipedia/commons/b/bf/Ta%C3%AF_National_Park_%2824148248710%29.jpg",
    },
    {
      "nom": "Plage de Grand-Bassam",
      "ville": "Grand-Bassam",
      "categorie": "Plage",
      "note": 4.5,
      "couleur": Colors.blue,
      "image": "https://media-files.abidjan.net/photo/plage(1).jpg",
    },
    {
      "nom": "Marché de Cocody",
      "ville": "Abidjan",
      "categorie": "Culture",
      "note": 4.3,
      "couleur": Colors.purple,
      "image": "https://lh3.googleusercontent.com/p/AF1QipNvNYt2e-hJoEPAzhmWT5eJaA7PijZKxrDC9kGx=s1600-w640",
    },
    {
      "nom": "Cascade de Man",
      "ville": "Man",
      "categorie": "Nature",
      "note": 4.7,
      "couleur": Colors.teal,
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnX8NO_nHlGz32nn6yx75QCVYjrodeFVV5pQ&s",
    },
    {
      "nom": "Le ZOO d'Abidjan",
      "ville": "Abidjan",
      "categorie": "Divertissement",
      "note": 4.7,
      "couleur": Colors.teal,
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReG6VnIUAwQHL57nvMMqYx1bNeaxAVFCSXbA&s",
    },
    {
      "nom": "Mosquée Salam du Plateau",
      "ville": "Abidjan",
      "categorie": "Monument",
      "note": 4.7,
      "couleur": Colors.orange,
      "image": "https://res.cloudinary.com/yafohi-travel/image/upload/f_auto/images/districts-places/mosq-bf72epfq27.jpg",
    },
    {
      "nom": "Pont de Lianes de Man",
      "ville": "Man",
      "categorie": "Nature",
      "note": 4.5,
      "couleur": Colors.green,
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWf8s5ayhBlreukPJJCq7WwcuYVCcz9ubb8A&s",
    },
    {
      "nom": "Plage de San Pedro",
      "ville": "San Pedro",
      "categorie": "Plage",
      "note": 4.6,
      "couleur": Colors.blue,
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcResBV2LO7dJ15jLu9X8lZq_iHBqXorwUefuQ&s",
    },
    {
      "nom": "Musée National du Costume",
      "ville": "Grand-Bassam",
      "categorie": "Culture",
      "note": 4.4,
      "couleur": Colors.purple,
      "image": "https://cdn.tripinafrica.com/places/musee_national_du_costume-X1Mkp.jpg",
    },
    {
      "nom": "Palais de la culture d'Abidjan",
      "ville": "Abidjan",
      "categorie": "Divertissement",
      "note": 4.1,
      "couleur": Colors.teal,
      "image": "https://images.cdn-files-a.com/uploads/2050992/800_5ca50a39a6662.jpg",
    },
    {
      "nom": "Stade de la Paix de Bouaké",
      "ville": "Bouaké",
      "categorie": "Divertissement",
      "note": 4.0,
      "couleur": Colors.teal,
      "image": "https://www.mangalis.com/wp-content/uploads/sites/166/2024/11/DJI_0531.jpg",
    },
    {
      "nom": "Maison de Samory Touré",
      "ville": "Bondoukou",
      "categorie": "Culture",
      "note": 4.3,
      "couleur": Colors.purple,
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1N-4LA7jz9fntbO6aMEM8myxi4xzuCjEkdw&s",
    },
    {
      "nom": "Grande Mosquée de Kong",
      "ville": "Kong",
      "categorie": "Monument",
      "note": 4.4,
      "couleur": Colors.orange,
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqRLXKUsCBjLOhsmgEgcsAnDYpP56g_wrhcQ&s",
    },
  ];

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    // ✅ Mode visiteur
    if (user == null) {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color.fromARGB(248, 20, 154, 45),
          unselectedItemColor: Colors.grey,
          currentIndex: 1,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: "Catégories"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favoris"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
          ],
          onTap: (index) {
            if (index == 0) Navigator.pushNamed(context, '/home');
            if (index == 2) Navigator.pushNamed(context, '/favoris');
            if (index == 3) Navigator.pushNamed(context, '/profil');
          },
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.category_outlined,
                      size: 50, color: Colors.grey.shade400),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Accès aux catégories",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  "Connectez-vous pour explorer les catégories de sites touristiques.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/connexion'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  const Color.fromARGB(248, 20, 154, 45),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Se connecter",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/inscription'),
                  child: const Text(
                    "Créer un compte",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // ✅ Utilisateur connecté
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green.shade800,
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Catégories"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favoris"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, '/home');
          if (index == 2) Navigator.pushNamed(context, '/favoris');
          if (index == 3) Navigator.pushNamed(context, '/profil');
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color:  const Color.fromARGB(255, 252, 151, 0),
              child: const Text(
                "Catégories",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Sites touristiques",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54)),
                    const SizedBox(height: 12),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.3,
                      children: [
                        _buildBoutonSite(context, icone: Icons.location_city, nom: "Villes", couleur: Colors.indigo, onTap: () => _afficherVilles(context)),
                        _buildBoutonSite(context, icone: Icons.church, nom: "Monuments", couleur: Colors.orange, onTap: () => _afficherSitesParCategorie(context, "Monument")),
                        _buildBoutonSite(context, icone: Icons.forest, nom: "Nature", couleur: Colors.green, onTap: () => _afficherSitesParCategorie(context, "Nature")),
                        _buildBoutonSite(context, icone: Icons.beach_access, nom: "Plages", couleur: Colors.blue, onTap: () => _afficherSitesParCategorie(context, "Plage")),
                        _buildBoutonSite(context, icone: Icons.store, nom: "Culture", couleur: Colors.purple, onTap: () => _afficherSitesParCategorie(context, "Culture")),
                        _buildBoutonSite(context, icone: Icons.attractions, nom: "Divertissement", couleur: Colors.teal, onTap: () => _afficherSitesParCategorie(context, "Divertissement")),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text("Services",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54)),
                    const SizedBox(height: 12),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.3,
                      children: [
                        _buildBoutonService(icone: Icons.hotel, nom: "Hôtels", couleur: Colors.amber, onTap: () => _afficherBientot(context, "Hôtels")),
                        _buildBoutonService(icone: Icons.local_hospital, nom: "Hôpitaux", couleur: Colors.red, onTap: () => _afficherBientot(context, "Hôpitaux")),
                        _buildBoutonService(icone: Icons.local_pharmacy, nom: "Pharmacies", couleur: Colors.cyan, onTap: () => _afficherBientot(context, "Pharmacies")),
                        _buildBoutonService(icone: Icons.restaurant, nom: "Restaurants", couleur: Colors.deepOrange, onTap: () => _afficherBientot(context, "Restaurants")),
                        _buildBoutonService(icone: Icons.event, nom: "Événements", couleur: Colors.pink, onTap: () => _afficherBientot(context, "Événements")),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoutonSite(BuildContext context, {required IconData icone, required String nom, required Color couleur, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(colors: [couleur.withOpacity(0.8), couleur.withOpacity(0.5)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          boxShadow: [BoxShadow(color: couleur.withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 3))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, color: Colors.white, size: 40),
            const SizedBox(height: 8),
            Text(nom, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildBoutonService({required IconData icone, required String nom, required Color couleur, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          border: Border.all(color: couleur.withOpacity(0.4)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 3))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, color: couleur, size: 40),
            const SizedBox(height: 8),
            Text(nom, style: TextStyle(color: couleur, fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
              child: const Text("Bientôt", style: TextStyle(fontSize: 10, color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }

  void _afficherVilles(BuildContext context) {
    List<String> villes = tousLesSites.map((s) => s["ville"] as String).toSet().toList();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6, maxChildSize: 0.9, minChildSize: 0.4, expand: false,
        builder: (context, scrollController) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Choisir une ville", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: villes.map((ville) {
                    int nbSites = tousLesSites.where((s) => s["ville"] == ville).length;
                    return ListTile(
                      leading: CircleAvatar(backgroundColor: Colors.green.shade100, child: Icon(Icons.location_city, color: Colors.green.shade800)),
                      title: Text(ville, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("$nbSites site(s)"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () { Navigator.pop(context); _afficherSitesParVille(context, ville); },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _afficherSitesParVille(BuildContext context, String ville) {
    List<Map<String, dynamic>> sites = tousLesSites.where((s) => s["ville"] == ville).toList();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6, maxChildSize: 0.9, minChildSize: 0.4, expand: false,
        builder: (context, scrollController) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sites à $ville", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: sites.length,
                  itemBuilder: (context, index) {
                    final site = sites[index];
                    return ListTile(
                      leading: CircleAvatar(backgroundColor: (site["couleur"] as Color).withOpacity(0.2), child: Icon(Icons.location_on, color: site["couleur"])),
                      title: Text(site["nom"], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(site["categorie"]),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.star, size: 14, color: Colors.amber), Text(" ${site["note"]}")]),
                      onTap: () { Navigator.pop(context); Navigator.pushNamed(context, '/detail', arguments: site); },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _afficherSitesParCategorie(BuildContext context, String categorie) {
    List<Map<String, dynamic>> sites = tousLesSites.where((s) => s["categorie"] == categorie).toList();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6, maxChildSize: 0.9, minChildSize: 0.4, expand: false,
        builder: (context, scrollController) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(categorie, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: sites.isEmpty
                    ? const Center(child: Text("Aucun site disponible"))
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: sites.length,
                        itemBuilder: (context, index) {
                          final site = sites[index];
                          return ListTile(
                            leading: CircleAvatar(backgroundColor: (site["couleur"] as Color).withOpacity(0.2), child: Icon(Icons.location_on, color: site["couleur"])),
                            title: Text(site["nom"], style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(site["ville"]),
                            trailing: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.star, size: 14, color: Colors.amber), Text(" ${site["note"]}")]),
                            onTap: () { Navigator.pop(context); Navigator.pushNamed(context, '/detail', arguments: site); },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _afficherBientot(BuildContext context, String service) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("‼️", style: TextStyle(fontSize: 50)),
            const SizedBox(height: 16),
            Text("$service - Bientôt disponible !", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text("Cette fonctionnalité sera disponible dans une prochaine mise à jour.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: const Text("OK", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}