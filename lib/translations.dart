// import 'package:al_quran/favorite.dart';
import 'package:al_quran/surahs.dart';
import 'package:al_quran/theme_styling/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

class TranslatedQuran extends StatefulWidget {
  const TranslatedQuran({super.key});

  @override
  State<TranslatedQuran> createState() => _TranslatedQuranState();
}

class _TranslatedQuranState extends State<TranslatedQuran> {
  final FavSurahClass favSurahClass = FavSurahClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: surahList(),
    );
  }

  Widget surahList() {
    return ListView.builder(
      itemCount: quran.totalSurahCount,
      itemBuilder: (context, index) {
        int surahIndex = index + 1;

        return Card(
          color: Theme.of(context).colorScheme.onSurface,
          elevation: 4,
          shape: const BeveledRectangleBorder(),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Translations(surahIndex)),
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
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            trailing: GestureDetector(
              onTap: () {
                setState(() {
                  if (favSurahClass.favSurah.contains(surahIndex)) {
                    favSurahClass.removeFavSurah(surahIndex);
                  } else {
                    favSurahClass.addFavSurah(surahIndex);
                  }
                });
              },
              child: Icon(
                favSurahClass.favSurah.contains(surahIndex)
                    ? Icons.star
                    : Icons.star_border_purple500_outlined,
                color: favSurahClass.favSurah.contains(surahIndex)
                    ? Colors.greenAccent.shade400
                    : Colors.grey.shade400,
              ),
            ),
          ),
        );
      },
    );
  }
}

class Translations extends StatefulWidget {
  final int surahIndex;
  const Translations(this.surahIndex, {super.key});

  @override
  State<Translations> createState() => _TranslationsState();
}

class _TranslationsState extends State<Translations> {
  dynamic defaultTranslation = quran.Translation.enClearQuran;
  Map<String, dynamic> translations = {
    "English (Clear Quran)": quran.Translation.enClearQuran,
    "Turkish": quran.Translation.trSaheeh,
    "Farsi": quran.Translation.faHusseinDari,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Text(
                'Translations Page',
                style: TextStyle(color: Colors.black),
              ),
              Icon(Icons.translate),
            ],
          ),
        ),
        body: Column(
          children: [
            Card(
              color: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<dynamic>(
                  dropdownColor: Theme.of(context).colorScheme.primary,
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    size: 16,
                  ),
                  isDense: true,
                  iconSize: 16,
                  value: defaultTranslation,
                  items: translations.entries.map((entry) {
                    return DropdownMenuItem<dynamic>(
                      value: entry.value,
                      child: Text(entry.key, style: primaryText(context)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      defaultTranslation = value!;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: quran.getVerseCount(1),
                    itemBuilder: (context, index) {
                      return Card(
                        color: Theme.of(context).colorScheme.onSurface,
                        elevation: 4,
                        shape: const BeveledRectangleBorder(),
                        child: ListTile(
                          title: Text(
                            quran.getVerseTranslation(
                                widget.surahIndex, index + 1,
                                translation: defaultTranslation),
                            style: surahText(context),
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ));
  }
}
