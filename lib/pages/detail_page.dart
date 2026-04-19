import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _estFavori = false;
  Map<String, dynamic>? _site;
  int _imageSelectionnee = 0;

  final Map<String, List<String>> _imagesSupplementaires = {
    "Basilique Notre-Dame de la Paix": [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6xPW1sgBEqm5CjR4FQiwqkM_7E9FcwsAYkA&s",
      "https://cdn.tripinafrica.com/places/basilique_notre_dame_de_la_paix-JxCoU.jpg",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdYuU_vihI0OyB8cOd3q87CwC7X1z3320qOw&s",
    ],
    "Parc National de Taï": [
      "https://upload.wikimedia.org/wikipedia/commons/b/bf/Ta%C3%AF_National_Park_%2824148248710%29.jpg",
      "https://discover-ivorycoast.com/wp-content/uploads/2019/01/marahoue_large.jpg",
      "https://i.pinimg.com/564x/65/c0/19/65c01942fb9cb2865ecb752a76c1cf5d.jpg",
    ],
    "Plage de Grand-Bassam": [
      "https://media-files.abidjan.net/photo/plage(1).jpg",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7pH2rieHZhrEvOORqeJItFyzBve31Rupqlw&s",
      "https://images.trvl-media.com/lodging/50000000/49140000/49133500/49133499/b5fbda11.jpg?impolicy=resizecrop&rw=575&rh=575&ra=fill",
    ],
    "Marché de Cocody": [
      "https://lh3.googleusercontent.com/p/AF1QipNvNYt2e-hJoEPAzhmWT5eJaA7PijZKxrDC9kGx=s1600-w640",
      "https://evendo-location-media.s3.amazonaws.com/LandmarkImages/9858314b-280b-474a-bddf-20bc4fbc4d74",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSO9_Iu0Yic-gbG9p_VOvQhqUni5jWUK7VOMw&s",
    ],
    "Cascade de Man": [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnX8NO_nHlGz32nn6yx75QCVYjrodeFVV5pQ&s",
      "https://voyageavecnous.com/wp-content/uploads/2024/07/WhatsApp-Image-2024-07-11-a-22.02.35_b2b29566-1024x576-1.webp",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3WrJ-7TMlPjj07Agwqdvv8-4UauVHDF95MA&s",
    ],
    "Le ZOO d'Abidjan": [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReG6VnIUAwQHL57nvMMqYx1bNeaxAVFCSXbA&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxCM_0raId4pY6OEmRtYiipGBdIn6sNO7Jjw&s",
      "https://www.sciencesetavenir.fr/assets/img/2015/04/02/cover-r4x3w1200-57df4368d2811-cote-d-ivoire-de-nouveaux-lions-pour-le-zoo-d-abidjan.jpg",
      "https://ci.chm-cbd.net/sites/ci/files/2022-06/IMG_6791.JPG",

    ],
     "Mosquée Salam du Plateau": [
      "https://res.cloudinary.com/yafohi-travel/image/upload/f_auto/images/districts-places/mosq-bf72epfq27.jpg",
      "https://res.cloudinary.com/yafohi-travel/image/upload/f_auto/images/districts-places/mosquee-0dai51ymctc.jpg",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5eQcxdSoEWXam3EQwTVGuqjVMuG1iLyV9vA&s",
      "https://res.cloudinary.com/yafohi-travel/image/upload/f_auto/images/districts-places/mosquee2-hisxdog269c.jpg",

    ],
       "Pont de Lianes de Man": [
      "https://openmoise.ci/web/image/product.image/15673/image_1024/Man%28Pont%20de%20liane%29?unique=86dc2e2",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLmto3hdFGhv153jX-LJ4iJjeYTiZAgaqiIg&s",
      "https://upload.wikimedia.org/wikipedia/commons/d/d0/Pont-de-liane-poubara-gabon.jpg",
    ],
       "Plage de San Pedro": [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcResBV2LO7dJ15jLu9X8lZq_iHBqXorwUefuQ&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCWAdJixhAK_oCx7Hk5Gm2oJootRTlKLpG3A&s",
      "https://preprod.abidjan4you.com/wp-content/uploads/2021/05/179109762_o.jpg",
    ],
    "Musée National du Costume": [
      "https://cdn.tripinafrica.com/places/musee_national_du_costume-X1Mkp.jpg",
      "https://openmoise.ci/web/image/product.image/15859/image_1024/Grand-bassam%20%28Mus%C3%A9e%29?unique=30965d2",
      "https://openmoise.ci/web/image/product.image/15861/image_1024/Grand-bassam%20%28Mus%C3%A9e%29?unique=30965d2",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSekkugcW7Ffpin8tQe1kVywjTOIki5mbI_Ww&s",
    ],
     "Palais de la culture d'Abidjan": [
      "https://images.cdn-files-a.com/uploads/2050992/800_5ca50a39a6662.jpg",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ083FD0f25AtehXNx0D7vjt8DxjH-96tMKlQ&s",
      "https://www.fratmat.info/media/k2/items/cache/fac9e8e9566799a8764818e584c58ce0_XL.jpg",
      "https://www.musicinafrica.net/sites/default/files/images/music_professional_profile/201507/palais-de-la-cultureabidjan.jpg",
    ],
      "Stade de la Paix de Bouaké": [
      "https://www.mangalis.com/wp-content/uploads/sites/166/2024/11/DJI_0531.jpg",
      "https://www.fratmat.info/uploads/images/2023/02/22/142385.png",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSSzpyGK1eMrcVGxdWKsfJyu3dQwpC1iizSA&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRb8C9LD2G9HATfyZNvtc6TeSwdXPdrMwGSSg&s",
    ],
       "Maison de Samory Touré": [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1N-4LA7jz9fntbO6aMEM8myxi4xzuCjEkdw&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRc71dU-Qr7RqBo9wVkTm_7eo9NH7fhBQMbxw&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKCYSjUFglpwlMnRDr2K3VAYe-6mI1p1ti9Q&s",
      "https://www.vnewsci.com/images/articles/1619/uploaded/Screenshot_20230707-201427.webp",
    ],
       "Grande Mosquée de Kong": [
      "https://upload.wikimedia.org/wikipedia/commons/7/75/Kong3.jpg",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSB0B_mcJDXDwNThmSVqP8mt1kMyWCyzy5dHQ&s",
      "https://www.traveladventures.org/countries/ivory-coast/images/kong-mosque06.jpg",
    ],
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_site == null) {
      _site = ModalRoute.of(context)!.settings.arguments
          as Map<String, dynamic>;
      _verifierFavori(_site!["nom"]);
    }
  }

  String _getImageActuelle() {
    List<String> images =
        _imagesSupplementaires[_site!["nom"]] ?? [_site!["image"]];
    if (_imageSelectionnee < images.length) {
      return images[_imageSelectionnee];
    }
    return _site!["image"];
  }

  Future<void> _verifierFavori(String nomSite) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('utilisateurs')
        .doc(user.uid)
        .collection('favoris')
        .doc(nomSite)
        .get();

    if (mounted) {
      setState(() => _estFavori = doc.exists);
    }
  }

  Future<void> _toggleFavori() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Connectez-vous pour ajouter des favoris"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final ref = FirebaseFirestore.instance
        .collection('utilisateurs')
        .doc(user.uid)
        .collection('favoris')
        .doc(_site!["nom"]);

    if (_estFavori) {
      await ref.delete();
      if (!mounted) return;
      setState(() => _estFavori = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Retiré des favoris"),
          backgroundColor: Colors.grey,
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      await ref.set({
        "nom": _site!["nom"],
        "ville": _site!["ville"],
        "categorie": _site!["categorie"],
        "note": _site!["note"],
        "couleur": (_site!["couleur"] as Color).value,
        "image": _site!["image"],
      });
      if (!mounted) return;
      setState(() => _estFavori = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ajouté aux favoris ❤️"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_site == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Grande image principale
            Stack(
              children: [
                Image.network(
                  _getImageActuelle(),
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      height: 280,
                      color: Colors.grey.shade200,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 280,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image_not_supported,
                          size: 60, color: Colors.grey),
                    );
                  },
                ),

                // Bouton retour
                Positioned(
                  top: 40,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),

                // Bouton favori
                Positioned(
                  top: 40,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: Icon(
                        _estFavori ? Icons.favorite : Icons.favorite_border,
                        color: _estFavori ? Colors.red : Colors.white,
                      ),
                      onPressed: _toggleFavori,
                    ),
                  ),
                ),
              ],
            ),

            // Galerie petites images
            _buildGalerie(),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom
                  Text(
                    _site!["nom"],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Ville + Note + Catégorie
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 16, color: Colors.grey.shade600),
                      Text(
                        _site!["ville"],
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      Text(" ${_site!["note"]}",
                          style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: (_site!["couleur"] as Color).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _site!["categorie"],
                          style: TextStyle(
                            color: _site!["couleur"],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Description
                  const Text(
                    "À propos",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getDescription(_site!["nom"]),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Infos pratiques
                  const Text(
                    "Informations pratiques",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildInfo(Icons.access_time, "Horaires",
                      "Ouvert tous les jours de 8h à 18h"),
                  _buildInfo(Icons.attach_money, "Entrée",
                      "Gratuit / Payant selon les zones"),

                  const SizedBox(height: 20),

                  // Contacts d'urgence
                  const Text(
                    "Contacts d'urgence",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildContactUrgence(
                      Icons.local_police, "Police Nationale", "110", Colors.blue),
                  _buildContactUrgence(
                      Icons.fire_truck, "Pompiers", "180", Colors.red),
                  _buildContactUrgence(
                      Icons.medical_services, "SAMU", "185", Colors.green),

                  const SizedBox(height: 24),

                  // Bouton naviguer
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/carte'),
                      icon: const Icon(Icons.directions, color: Colors.white),
                      label: const Text(
                        "Naviguer vers ce site",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 132, 0),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
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

  // Galerie de petites images
  Widget _buildGalerie() {
    List<String> images =
        _imagesSupplementaires[_site!["nom"]] ?? [_site!["image"]];

    return Container(
      height: 80,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        itemCount: images.length,
        itemBuilder: (context, index) {
          bool estSelectionnee = _imageSelectionnee == index;
          return GestureDetector(
            onTap: () => setState(() => _imageSelectionnee = index),
            child: Container(
              width: 70,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: estSelectionnee
                      ? Colors.green.shade400
                      : Colors.transparent,
                  width: 3,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  images[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade700,
                      child: const Icon(Icons.image_not_supported,
                          color: Colors.white54, size: 20),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfo(IconData icone, String titre, String contenu) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          child: Icon(icone, color: Colors.green.shade800),
        ),
        title: Text(titre,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(contenu),
      ),
    );
  }

  Widget _buildContactUrgence(
      IconData icone, String titre, String numero, Color couleur) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: couleur.withOpacity(0.15),
              child: Icon(icone, color: couleur),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titre,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  numero,
                  style: TextStyle(
                    color: couleur,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getDescription(String nom) {
    Map<String, String> descriptions = {
      "Basilique Notre-Dame de la Paix":
          "La Basilique Notre-Dame de la Paix de Yamoussoukro est l'une des plus grandes églises du monde. Construite entre 1985 et 1989, elle est classée au patrimoine mondial de l'UNESCO.",
      "Parc National de Taï":
          "Le Parc National de Taï est l'une des dernières grandes forêts tropicales primaires d'Afrique de l'Ouest. Il abrite de nombreuses espèces animales dont les chimpanzés.",
      "Plage de Grand-Bassam":
          "Grand-Bassam est une ancienne capitale coloniale classée patrimoine mondial. Ses plages magnifiques en font une destination prisée à seulement 40km d'Abidjan.",
      "Marché de Cocody":
          "Le marché de Cocody est un lieu incontournable pour découvrir l'artisanat ivoirien. Tissus, sculptures, bijoux et épices y sont proposés par des artisans locaux.",
      "Cascade de Man":
          "Les cascades de Man sont parmi les plus belles de Côte d'Ivoire. Situées dans la région montagneuse de l'ouest, elles offrent un cadre naturel exceptionnel.",
      "Le ZOO d'Abidjan":
          "Le Zoo d'Abidjan est l'un des espaces verts les plus emblématiques de la capitale économique de Côte d'Ivoire. Situé au cœur du Banco, il abrite une grande variété d'animaux africains et constitue un lieu de détente et de découverte pour les familles.",
      "Mosquée Salam du Plateau":
          "La Mosquée Salam du Plateau est l'un des lieux de culte musulman les plus emblématiques d'Abidjan, située au cœur du quartier des affaires du Plateau. Avec son architecture majestueuse et ses minarets imposants, elle constitue un symbole religieux et culturel important pour la communauté musulmane de Côte d'Ivoire.",    
      "Pont de Lianes de Man":
          "Le Pont de Lianes de Man est l'un des sites naturels les plus fascinants de Côte d'Ivoire, situé dans la région des montagnes à Man, à l'ouest du pays. Suspendu au-dessus d'une rivière et entièrement construit de lianes tressées par les populations Dan, il constitue un symbole fort du patrimoine culturel et naturel ivoirien, attirant chaque année de nombreux touristes et aventuriers.",  
      "Plage de San Pedro":
          "La Plage de San Pedro est l'une des plus belles plages de Côte d'Ivoire, située dans la ville portuaire de San Pedro, au sud-ouest du pays. Bordée de cocotiers et baignée par les eaux de l'Atlantique, elle offre un cadre naturel exceptionnel et constitue un lieu de détente et de villégiature prisé aussi bien par les habitants que par les touristes en quête de soleil et de mer.",
      "Musée National du Costume":
          "Le Musée National du Costume est un joyau culturel de Côte d'Ivoire, situé dans la ville historique de Grand-Bassam, classée au patrimoine mondial de l'UNESCO. Il abrite une impressionnante collection de costumes traditionnels et de tenues cérémonielles représentant la richesse et la diversité des peuples ivoiriens, faisant de lui un lieu incontournable pour découvrir l'identité culturelle et vestimentaire de la Côte d'Ivoire.",  
      "Palais de la culture d'Abidjan":
          "Le Palais de la Culture Bernard Binlin-Dadié est le principal temple de la culture d'Abidjan, situé à Treichville sur le front lagunaire, entre les deux ponts Houphouët-Boigny et Général de Gaulle. Fruit d'une coopération ivoiro-chinoise, cet imposant complexe de 12 900 m² a été construit entre 1996 et 1999. Son architecture distinctive, inspirée du siège royal akan, abrite plusieurs salles de spectacle, un théâtre à ciel ouvert de 2 500 places et de nombreux espaces culturels, accueillant concerts, pièces de théâtre, festivals et grandes manifestations artistiques qui font rayonner la créativité ivoirienne.",            
      "Stade de la Paix de Bouaké":
    "Le Stade de la Paix de Bouaké est l'une des plus grandes et des plus emblématiques infrastructures sportives de Côte d'Ivoire, situé en plein centre-ville de Bouaké, deuxième ville du pays. Inauguré en 1984 pour accueillir la Coupe d'Afrique des Nations organisée pour la première fois en terre ivoirienne, ce joyau architectural de forme ovale dispose aujourd'hui de 40 000 places assises après une profonde rénovation achevée en 2023. Son nom « Stade de la Paix » lui a été attribué en mémoire de la cérémonie historique de réconciliation nationale de 2007, où les armes de la crise ivoirienne furent symboliquement brûlées en ses enceintes.",
      "Maison de Samory Touré": 
    "La Maison de Samory Touré est un site historique majeur situé à Bondoukou, dans la région du Gontougo, à l'est de la Côte d'Ivoire. Elle fut la résidence de Samory Touré, célèbre résistant mandingue qui s'opposa farouchement à la colonisation française à la fin du XIXe siècle, faisant de lui l'une des figures les plus emblématiques de la résistance africaine. Classée patrimoine historique national, cette demeure témoigne du passage de l'almamy dans la région lors de ses campagnes militaires. Aujourd'hui lieu de mémoire et de fierté culturelle, elle attire historiens, chercheurs et touristes désireux de retracer l'épopée de ce héros panafricain.",
     "Grande Mosquée de Kong": 
    "La mosquée de Kong ou Grande mosquée de Kong est un édifice religieux islamique situé dans la ville de Kong au nord de la Côte d'Ivoire. En 1741 il a été noté que la ville de Kong possédait déjà plusieurs mosquées dont la Grande mosquée (Missiriba) détruite par Samory Touré vers 1897 et rebâtie à l'aube du XXe siècle",
    };
    return descriptions[nom] ??
        "Un site touristique magnifique à découvrir lors de votre visite en Côte d'Ivoire.";
  }
}