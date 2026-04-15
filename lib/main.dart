import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:exploreci/pages/splash_screen.dart';
import 'package:exploreci/pages/landing_page.dart';
import 'package:exploreci/pages/inscription_page.dart';
import 'package:exploreci/pages/connexion_page.dart';
import 'package:exploreci/pages/home_page.dart';
import 'package:exploreci/pages/detail_page.dart';
import 'package:exploreci/pages/profil_page.dart';
import 'package:exploreci/pages/favoris_page.dart';
import 'package:exploreci/pages/parametres_page.dart';
import 'package:exploreci/pages/carte_page.dart';
import 'package:exploreci/pages/categories_page.dart';






void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const exploreci());
}

class exploreci extends StatelessWidget {
  const exploreci({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExploreCI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/landing': (context) => const LandingPage(),
        '/inscription': (context) => const InscriptionPage(),
         '/connexion': (context) => const ConnexionPage(),
         '/home': (context) => const HomePage(),
        '/profil': (context) => const ProfilPage(),
         '/detail': (context) => const DetailPage(),
         '/carte': (context) => const CartePage(),
         '/favoris': (context) => const FavorisPage(),
        '/parametres': (context) => const ParametresPage(),
        '/categories': (context) => const CategoriesPage(),
      },
    );
  }
}