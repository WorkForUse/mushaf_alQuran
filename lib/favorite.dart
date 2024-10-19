import 'package:al_quran/surahs.dart';
import 'package:al_quran/theme_styling/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

class FavoritesPage extends StatefulWidget {
  final FavSurahClass favSurahClass;
  const FavoritesPage({super.key, required this.favSurahClass});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: widget.favSurahClass.favSurah.isEmpty
          ? const Center(child: Text('No favorite Surahs'))
          : ListView.builder(
              itemCount: widget.favSurahClass.favSurah.length,
              itemBuilder: (context, index) {
                int surahIndex = widget.favSurahClass.favSurah[index];

                return Card(
                  color: Theme.of(context).colorScheme.onSurface,
                  elevation: 4,
                  shape: const BeveledRectangleBorder(),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SurahRead(surahIndex)),
                      );
                    },
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text('$surahIndex'),
                    ),
                    title: Text(
                      quran.getSurahNameArabic(surahIndex),
                      style: surahText(context),
                    ),
                    subtitle: Text(
                      quran.getSurahName(surahIndex),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (widget.favSurahClass.favSurah
                              .contains(surahIndex)) {
                            widget.favSurahClass.removeFavSurah(surahIndex);
                          } else {
                            widget.favSurahClass.addFavSurah(surahIndex);
                          }
                        });
                      },
                      child: Icon(
                        widget.favSurahClass.favSurah.contains(surahIndex)
                            ? Icons.star
                            : Icons.star_border_purple500_sharp,
                        color:
                            widget.favSurahClass.favSurah.contains(surahIndex)
                                ? Colors.greenAccent.shade400
                                : Colors.grey.shade400,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
