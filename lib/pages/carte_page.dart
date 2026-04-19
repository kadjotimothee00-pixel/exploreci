import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

class CartePage extends StatefulWidget {
  const CartePage({super.key});

  @override
  State<CartePage> createState() => _CartePageState();
}

class _CartePageState extends State<CartePage> {
  final MapController _carteController = MapController();
  final TextEditingController _rechercheController = TextEditingController();
  LatLng? _positionUtilisateur;
  List<LatLng> _itineraire = [];
  bool _chargementItineraire = false;

  final List<Map<String, dynamic>> _sites = [
    {
      "nom": "Basilique Notre-Dame de la Paix",
      "ville": "Yamoussoukro",
      "position": const LatLng(6.8067, -5.2759),
      "couleur": Colors.orange,
    },
    {
      "nom": "Parc National de Taï",
      "ville": "Sud-Ouest",
      "position": const LatLng(5.8333, -7.2500),
      "couleur": Colors.green,
    },
    {
      "nom": "Plage de Grand-Bassam",
      "ville": "Grand-Bassam",
      "position": const LatLng(5.1993, -3.7362),
      "couleur": Colors.blue,
    },
    {
      "nom": "Marché de Cocody",
      "ville": "Abidjan",
      "position": const LatLng(5.3600, -3.9800),
      "couleur": Colors.purple,
    },
    {
      "nom": "Cascade de Man",
      "ville": "Man",
      "position": const LatLng(7.4000, -7.5500),
      "couleur": Colors.teal,
    },
    {
      "nom": "Le ZOO d'Abidjan",
      "ville": "Abidjan",
      "position": const LatLng(5.38082177, -4.00506393),
      "couleur": Colors.teal,
    },
    {
      "nom": "Mosquée Salam du Plateau",
      "ville": "Abidjan",
      "position": const LatLng(5.31916, -4.01833),
      "couleur": Colors.orange,
    },
    {
      "nom": "Pont de Lianes de Man",
      "ville": "Man",
      "position": const LatLng(7.41228, -7.55385),
      "couleur": Colors.green,
    },
    {
      "nom": "Plage de San Pedro",
      "ville": "San Pedro",
      "position": const LatLng(4.74851, -6.63630),
      "couleur": Colors.blue,
    },
    {
      "nom": "Musée National du Costume",
      "ville": "Grand-Bassam",
      "position": const LatLng(5.20172, -3.73907),
      "couleur": Colors.purple,
    },
    {
      "nom": "Palais de la Culture Bernard Binlin-Dadié",
      "ville": "Abidjan",
      "position": const LatLng(5.312254, -4.0125803),
      "couleur": Colors.orange,
    },
    {
      "nom": "Stade de la Paix de Bouaké",
      "ville": "Bouaké",
      "position": const LatLng(7.682943820953369, -5.044763088226318),
      "couleur": Colors.green,
    },
    {
      "nom": "Maison de Samory Touré",
      "ville": "Bondoukou",
      "position": const LatLng(8.040138, -2.800338),
      "couleur": Colors.purple,
    },
    {
      "nom": "Grande Mosquée de Kong",
      "ville": "Kong",
      "position": const LatLng(9.1491871, -4.6094382),
      "couleur": Colors.orange,
    },
  ];

  @override
  void initState() {
    super.initState();
    _obtenirPosition();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is Map) {
        final lat = args["lat"];
        final lng = args["lng"];
        if (lat != null && lng != null) {
          final position = LatLng(
            (lat as num).toDouble(),
            (lng as num).toDouble(),
          );
          _carteController.move(position, 14.0);
          _calculerItineraire(position);
        }
      }
    });
  }

  Future<void> _obtenirPosition() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition();
        setState(() {
          _positionUtilisateur = LatLng(
            position.latitude,
            position.longitude,
          );
        });
      }
    } catch (e) {
      debugPrint("Erreur position : $e");
    }
  }

  Future<void> _calculerItineraire(LatLng destination) async {
    if (_positionUtilisateur == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Position GPS non disponible 📍\nActivez votre GPS"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _chargementItineraire = true);

    try {
      final url = "https://router.project-osrm.org/route/v1/driving/"
          "${_positionUtilisateur!.longitude},${_positionUtilisateur!.latitude};"
          "${destination.longitude},${destination.latitude}"
          "?overview=full&geometries=geojson";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data["code"] == "Ok") {
          final coordinates =
              data["routes"][0]["geometry"]["coordinates"] as List;

          setState(() {
            _itineraire = coordinates
                .map((coord) => LatLng(
                      coord[1].toDouble(),
                      coord[0].toDouble(),
                    ))
                .toList();
          });

          final latMilieu =
              (_positionUtilisateur!.latitude + destination.latitude) / 2;
          final lngMilieu =
              (_positionUtilisateur!.longitude + destination.longitude) / 2;
          _carteController.move(LatLng(latMilieu, lngMilieu), 7.0);

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Itinéraire tracé ! 🗺️"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Erreur de connexion 😕"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    if (mounted) setState(() => _chargementItineraire = false);
  }

  void _centrerSurMoi() {
    if (_positionUtilisateur != null) {
      _carteController.move(_positionUtilisateur!, 14.0);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Position non disponible 📍"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    // ✅ Mode visiteur
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade800,
          title: const Text("Carte",
              style: TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(color: Colors.white),
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
                  child: Icon(Icons.map_outlined,
                      size: 50, color: Colors.grey.shade400),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Accès à la carte",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  "Connectez-vous pour explorer la carte des sites touristiques et tracer des itinéraires.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/connexion'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade800,
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
                  onTap: () =>
                      Navigator.pushNamed(context, '/inscription'),
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
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: TextField(
          controller: _rechercheController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Rechercher un site...",
            hintStyle: const TextStyle(color: Colors.white60),
            prefixIcon: const Icon(Icons.search, color: Colors.white),
            suffixIcon: _rechercheController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _rechercheController.clear();
                        _itineraire = [];
                      });
                    },
                  )
                : null,
            filled: true,
            fillColor: Colors.white24,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (valeur) {
            setState(() {});
            if (valeur.isNotEmpty) {
              final site = _sites.firstWhere(
                (s) => s["nom"]
                    .toLowerCase()
                    .contains(valeur.toLowerCase()),
                orElse: () => {},
              );
              if (site.isNotEmpty) {
                _carteController.move(site["position"], 12.0);
              }
            }
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _carteController,
            options: const MapOptions(
              initialCenter: LatLng(7.5400, -5.5471),
              initialZoom: 6.5,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: "com.example.exploreci",
              ),
              if (_itineraire.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _itineraire,
                      color: Colors.blue.shade700,
                      strokeWidth: 5,
                    ),
                  ],
                ),
              MarkerLayer(
                markers: [
                  ..._sites.map((site) {
                    return Marker(
                      point: site["position"],
                      width: 45,
                      height: 45,
                      child: GestureDetector(
                        onTap: () => _afficherInfoSite(context, site),
                        child: Container(
                          decoration: BoxDecoration(
                            color: site["couleur"],
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.location_on,
                              color: Colors.white, size: 22),
                        ),
                      ),
                    );
                  }),
                  if (_positionUtilisateur != null)
                    Marker(
                      point: _positionUtilisateur!,
                      width: 50,
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: const Icon(Icons.person_pin,
                            color: Colors.white, size: 25),
                      ),
                    ),
                ],
              ),
            ],
          ),

          if (_chargementItineraire)
            Positioned(
              top: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 10),
                      Text("Calcul de l'itinéraire..."),
                    ],
                  ),
                ),
              ),
            ),

          if (_itineraire.isNotEmpty)
            Positioned(
              top: 16,
              left: 16,
              child: FloatingActionButton.small(
                heroTag: "effacer",
                onPressed: () => setState(() => _itineraire = []),
                backgroundColor: Colors.red,
                child: const Icon(Icons.close, color: Colors.white),
              ),
            ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(12),
                itemCount: _sites.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _carteController.move(
                        _sites[index]["position"], 13.0),
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on,
                              color: _sites[index]["couleur"], size: 18),
                          const SizedBox(height: 4),
                          Text(
                            _sites[index]["nom"],
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            _sites[index]["ville"],
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          Positioned(
            right: 16,
            bottom: 140,
            child: FloatingActionButton(
              heroTag: "position",
              onPressed: _centrerSurMoi,
              backgroundColor: Colors.white,
              child: Icon(Icons.my_location, color: Colors.green.shade800),
            ),
          ),
        ],
      ),
    );
  }

  void _afficherInfoSite(BuildContext context, Map<String, dynamic> site) {
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
            Text(
              site["nom"],
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.location_on,
                    size: 14, color: Colors.grey.shade500),
                Text(site["ville"],
                    style: TextStyle(
                        color: Colors.grey.shade500, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _calculerItineraire(site["position"]);
                },
                icon: const Icon(Icons.directions, color: Colors.white),
                label: const Text("Tracer l'itinéraire",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade800,
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
    );
  }
}