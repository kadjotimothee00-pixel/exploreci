import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _recherche = "";

  final List<Map<String, dynamic>> _sites = [
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
      "categorie": "divertissement",
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
      "categorie": "divertissement",
      "note": 4.1,
      "couleur": Colors.teal,
      "image": "https://images.cdn-files-a.com/uploads/2050992/800_5ca50a39a6662.jpg",
    },
    {
      "nom": "Stade de la Paix de Bouaké",
      "ville": "Bouaké",
      "categorie": "divertissement",
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
    List<Map<String, dynamic>> sitesFiltres = _sites.where((site) {
      return site["nom"].toLowerCase().contains(_recherche.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: BottomNavigationBar(
      selectedItemColor: Colors.green.shade800,
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
    BottomNavigationBarItem(icon: Icon(Icons.category_outlined), label: "Catégories"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favoris"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
  ],
  onTap: (index) {
    if (index == 1) Navigator.pushNamed(context, '/categories');
    if (index == 2) Navigator.pushNamed(context, '/favoris');
    if (index == 3) Navigator.pushNamed(context, '/profil');
  },
),
      body: SafeArea(
        child: Column(
          children: [
            // En-tête
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.green.shade800,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "AKWABA",
                        
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pushNamed(context, '/carte'),
                        icon: const Icon(Icons.map, color: Colors.white, size: 28),
                      ),
                    ],
                  ),
                  const Text(
                    "Explorons la Côte d'Ivoire !",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    onChanged: (valeur) => setState(() => _recherche = valeur),
                    decoration: InputDecoration(
                      hintText: "Rechercher un site...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Liste des sites
            Expanded(
              child: sitesFiltres.isEmpty
                  ? const Center(
                      child: Text("Aucun site trouvé ",
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: sitesFiltres.length,
                      itemBuilder: (context, index) {
                        return _buildCarteSite(sitesFiltres[index], context);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarteSite(Map<String, dynamic> site, BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detail', arguments: site),
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Column(
          children: [
            // Image du site
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                site["image"],
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    height: 180,
                    color: Colors.grey.shade200,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image_not_supported,
                        size: 50, color: Colors.grey),
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
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                size: 13, color: Colors.grey.shade500),
                            Text(site["ville"],
                                style: TextStyle(
                                    color: Colors.grey.shade500, fontSize: 12)),
                            const SizedBox(width: 8),
                            const Icon(Icons.star,
                                size: 13, color: Colors.amber),
                            Text(" ${site["note"]}",
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (site["couleur"] as Color).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      site["categorie"],
                      style: TextStyle(
                          color: site["couleur"],
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}