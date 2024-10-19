import 'package:al_quran/theme_styling/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:just_audio/just_audio.dart';

class FavSurahClass {
  List<int> favSurah = [1, 18];

  void addFavSurah(int surahIndex) {
    favSurah.add(surahIndex);
    print('Added Surah $surahIndex to Favorites');
  }

  void removeFavSurah(int surahIndex) {
    favSurah.remove(surahIndex);
  }

  List<int> getFavSurah() {
    return favSurah;
  }
}

class Quran extends StatefulWidget {
  const Quran({super.key});

  @override
  State<Quran> createState() => _QuranState();
}

class _QuranState extends State<Quran> {
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
                MaterialPageRoute(builder: (context) => SurahRead(surahIndex)),
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
              // style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              style: TextStyle(color: Colors.brown.shade500),
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

class SurahRead extends StatefulWidget {
  final int index;
  const SurahRead(this.index, {super.key});

  @override
  State<SurahRead> createState() => _SurahReadState();
}

class _SurahReadState extends State<SurahRead> {
  AudioPlayer audioPlayer = AudioPlayer();
  IconData playpauseButton = Icons.play_circle_outline_sharp;
  bool isPlaying = true;

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> togglebtn() async {
    try {
      final audioUrl = quran.getAudioURLBySurah(widget.index);
      audioPlayer.setUrl(audioUrl);
      if (isPlaying) {
        audioPlayer.play();
        setState(() {
          playpauseButton = Icons.pause_circle_filled_rounded;
          isPlaying = false;
        });
      } else {
        audioPlayer.pause();
        setState(() {
          playpauseButton = Icons.play_circle_fill_rounded;
          isPlaying = true;
        });
      }
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Surah ${widget.index}',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: surahPage(widget.index),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the button
          children: [
            IconButton(
              icon: Icon(playpauseButton),
              color: Theme.of(context).colorScheme.onSurface, // Icon color
              iconSize: 32, // Size of the icon
              onPressed: togglebtn, // Toggle play/pause action
            ),
          ],
        ),
      ),
    );
  }
}

Widget surahPage(var ayahcount) {
  return ListView.builder(
      itemCount: quran.getVerseCount(ayahcount),
      itemBuilder: (context, index) {
        return Card(
          color: Theme.of(context).colorScheme.onSurface,
          elevation: 4,
          shape: const BeveledRectangleBorder(),
          child: ListTile(
            title: Text(
              quran.getVerse(ayahcount, index + 1, verseEndSymbol: true),
              textAlign: TextAlign.right,
              style: surahText(context),
            ),
          ),
        );
      });
}
