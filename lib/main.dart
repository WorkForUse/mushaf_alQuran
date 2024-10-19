import 'dart:async';

import 'package:al_quran/favorite.dart';
import 'package:al_quran/surahs.dart';
import 'package:al_quran/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.light(
            primary: const Color(0xFFEAD6A6),
            secondary: Colors.black,
            inversePrimary: const Color(0xFFEAD6A6),
            onSurface: Colors.grey.shade200,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFFFFFFF),
          )),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.dark(
            surface: Colors.grey.shade900,
            primary: Colors.grey.shade700,
            secondary: Colors.white,
            inversePrimary: Colors.grey.shade700,
            onSurface: Colors.grey.shade800,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey.shade700,
            foregroundColor: Colors.black,
          )),
      themeMode: ThemeMode.light,
      // themeMode: ThemeMode.system,
      home: const Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 200,
            ),
            // const SpinKitWave(color: Colors.white,)
            const SpinKitCircle(
              color: Colors.black,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FavSurahClass favSurahClass = FavSurahClass();
  int _selectedIndex = 0; // To track the selected bottom navigation bar item

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const Quran(), // Assuming Quran is a widget
      const TranslatedQuran(), // Assuming TranslatedQuran is a widget
      FavoritesPage(favSurahClass: favSurahClass),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'مُصْحَف',
          style: TextStyle(
            shadows: <Shadow>[
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 1.5,
                color: Color(0xFF4A4A4A),
              ),
              Shadow(
                offset: Offset(10.0, 10.0),
                blurRadius: 8.0,
                color: Color(0x7A3F3F3C),
              ),
            ],
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 50.0, // Use double for font size
          ),
        ),
      ),
      body: pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Quran',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.translate),
            label: 'Translations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex, // Set the selected index
        selectedItemColor:
            const Color(0xFF000000), // Change this for desired color
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
